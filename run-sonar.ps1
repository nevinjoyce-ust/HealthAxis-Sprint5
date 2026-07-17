param(
    [string]$Token = $env:SONAR_TOKEN,
    [string]$ProjectKey = "HealthAxis",
    [string]$ProjectName = "HealthAxis"
)

$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($Token)) {
    throw "Set SONAR_TOKEN or pass -Token 'your-token'."
}

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$solutionPath = Join-Path $repoRoot "HealthAxis.slnx"
$testProjectPath = Join-Path $repoRoot "HealthAxisTests\HealthAxisTests.csproj"
$configPath = Join-Path $repoRoot "SonarQube.Analysis.xml"
$tempDirectory = Join-Path $repoRoot ".sonar-temp"
$tempProjectPath = Join-Path $tempDirectory "HealthAxis.Web.Sonar.csproj"
$testResultsPath = Join-Path $repoRoot "TestResults"

foreach ($requiredPath in @($solutionPath, $testProjectPath, $configPath)) {
    if (-not (Test-Path $requiredPath)) {
        throw "Required file not found: $requiredPath"
    }
}

function Invoke-Step {
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [scriptblock]$Command
    )

    Write-Host "`n=== $Name ===" -ForegroundColor Cyan
    & $Command

    if ($LASTEXITCODE -ne 0) {
        throw "$Name failed with exit code $LASTEXITCODE."
    }
}

function Assert-CoverageScope {
    param(
        [Parameter(Mandatory)]
        [string]$ResultsDirectory
    )

    $coverageFiles = @(Get-ChildItem -Path $ResultsDirectory -Filter "coverage.opencover.xml" -Recurse)

    if ($coverageFiles.Count -eq 0) {
        throw "No OpenCover report was created under $ResultsDirectory."
    }

    foreach ($coverageFile in $coverageFiles) {
        [xml]$coverageXml = Get-Content -Path $coverageFile.FullName
        $sourceFiles = @($coverageXml.CoverageSession.Modules.Module.Files.File)

        foreach ($sourceFile in $sourceFiles) {
            $normalisedPath = ([string]$sourceFile.fullPath).Replace('\', '/')

            if ($normalisedPath -and
                $normalisedPath -notmatch '/HealthAxis\.API/Services/Impl/.+\.cs$') {
                throw "Coverage report contains an out-of-scope file: $normalisedPath"
            }
        }
    }

    Write-Host "Coverage report scope verified: HealthAxis.API/Services/Impl only." -ForegroundColor Green
}

Push-Location $repoRoot

try {
    foreach ($path in @("TestResults", ".sonarqube", ".sonar-temp")) {
        if (Test-Path $path) {
            Remove-Item -Path $path -Recurse -Force
        }
    }

    New-Item -ItemType Directory -Path $tempDirectory | Out-Null

    @'
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net10.0</TargetFramework>
    <EnableDefaultItems>false</EnableDefaultItems>
  </PropertyGroup>

  <!--
    SonarScanner for .NET discovers files through MSBuild projects.
    The Angular application is not an MSBuild project, so this temporary wrapper
    registers only its TypeScript and HTML source files for the current analysis.
    Stylesheets are intentionally neither registered nor analysed.
  -->
  <ItemGroup>
    <None Include="..\HealthAxis.Web\src\**\*.ts" />
    <None Include="..\HealthAxis.Web\src\**\*.html" />
    <None Include="..\HealthAxis.Web\angular.json" />
    <None Include="..\HealthAxis.Web\package.json" />
    <None Include="..\HealthAxis.Web\tsconfig.json" />
    <None Include="..\HealthAxis.Web\tsconfig.app.json" />
  </ItemGroup>
</Project>
'@ | Set-Content -Path $tempProjectPath -Encoding UTF8

    Invoke-Step "Start SonarQube analysis" {
        dotnet sonarscanner begin `
            "/k:$ProjectKey" `
            "/n:$ProjectName" `
            "/s:$configPath" `
            "/d:sonar.token=$Token"
    }

    Invoke-Step "Build complete .NET solution" {
        dotnet build $solutionPath --no-incremental
    }

    Invoke-Step "Register Angular TypeScript and HTML for analysis" {
        dotnet build $tempProjectPath --no-incremental
    }

    Invoke-Step "Run tests and collect filtered OpenCover coverage" {
        dotnet test $testProjectPath `
            --no-build `
            --collect:"XPlat Code Coverage" `
            --results-directory $testResultsPath `
            -- `
            "DataCollectionRunSettings.DataCollectors.DataCollector.Configuration.Format=opencover" `
            "DataCollectionRunSettings.DataCollectors.DataCollector.Configuration.Include=[HealthAxis.API]HealthAxis.API.Services.Impl.*"
    }

    Assert-CoverageScope -ResultsDirectory $testResultsPath

    Invoke-Step "Finish SonarQube analysis" {
        dotnet sonarscanner end "/d:sonar.token=$Token"
    }

    Write-Host "`nAnalysis complete." -ForegroundColor Green
    Write-Host "Static analysis includes .NET custom code plus Angular TypeScript and HTML." -ForegroundColor Green
    Write-Host "CSS, SCSS, Sass and IdentityDataSeeder.cs are excluded." -ForegroundColor Green
    Write-Host "Coverage is limited to HealthAxis.API/Services/Impl." -ForegroundColor Green
}
finally {
    if (Test-Path $tempDirectory) {
        Remove-Item -Path $tempDirectory -Recurse -Force
    }

    Pop-Location
}
