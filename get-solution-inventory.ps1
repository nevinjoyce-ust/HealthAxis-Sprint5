param(
    [string]$Root = (Get-Location).Path,
    [string]$OutputFile = "solution-inventory.txt"
)

$ErrorActionPreference = "Stop"

$excludedDirectories = @(
    ".git",
    ".vs",
    ".idea",
    ".sonarqube",
    ".scannerwork",
    "bin",
    "obj",
    "node_modules",
    "dist",
    "coverage",
    "TestResults",
    ".angular",
    "logs"
)

$excludedExtensions = @(
    ".dll", ".exe", ".pdb", ".cache", ".zip", ".7z",
    ".png", ".jpg", ".jpeg", ".gif", ".ico", ".pdf"
)

$rootPath = (Resolve-Path $Root).Path
$outputPath = Join-Path $rootPath $OutputFile

function Test-IsExcludedPath {
    param([string]$FullName)

    $relativePath = [System.IO.Path]::GetRelativePath($rootPath, $FullName)
    $segments = $relativePath -split '[\\/]'

    foreach ($segment in $segments) {
        if ($excludedDirectories -contains $segment) {
            return $true
        }
    }

    return $false
}

$lines = [System.Collections.Generic.List[string]]::new()

$lines.Add("HealthAxis solution inventory")
$lines.Add("Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss zzz')")
$lines.Add("Root: $rootPath")
$lines.Add("")

$lines.Add("=== SOLUTION AND PROJECT FILES ===")
Get-ChildItem -Path $rootPath -Recurse -File |
    Where-Object {
        -not (Test-IsExcludedPath $_.FullName) -and
        ($_.Extension -in @('.sln', '.slnx', '.csproj', '.esproj', '.fsproj'))
    } |
    Sort-Object FullName |
    ForEach-Object {
        $lines.Add([System.IO.Path]::GetRelativePath($rootPath, $_.FullName))
    }

$lines.Add("")
$lines.Add("=== DIRECTORY TREE ===")

Get-ChildItem -Path $rootPath -Recurse -Force |
    Where-Object {
        -not (Test-IsExcludedPath $_.FullName) -and
        ($_.PSIsContainer -or $_.Extension -notin $excludedExtensions)
    } |
    Sort-Object FullName |
    ForEach-Object {
        $relativePath = [System.IO.Path]::GetRelativePath($rootPath, $_.FullName)
        $depth = ($relativePath -split '[\\/]').Count - 1
        $indent = '  ' * $depth
        $marker = if ($_.PSIsContainer) { '[D]' } else { '[F]' }
        $lines.Add("$indent$marker $($_.Name)")
    }

$lines.Add("")
$lines.Add("=== PROJECT REFERENCES AND PACKAGES ===")

Get-ChildItem -Path $rootPath -Recurse -File -Filter *.csproj |
    Where-Object { -not (Test-IsExcludedPath $_.FullName) } |
    Sort-Object FullName |
    ForEach-Object {
        $relativeProject = [System.IO.Path]::GetRelativePath($rootPath, $_.FullName)
        $lines.Add("")
        $lines.Add("--- $relativeProject ---")

        [xml]$projectXml = Get-Content $_.FullName

        $projectReferences = @($projectXml.Project.ItemGroup.ProjectReference)
        if ($projectReferences.Count -gt 0) {
            $lines.Add("ProjectReference:")
            foreach ($reference in $projectReferences) {
                $lines.Add("  $($reference.Include)")
            }
        }

        $packageReferences = @($projectXml.Project.ItemGroup.PackageReference)
        if ($packageReferences.Count -gt 0) {
            $lines.Add("PackageReference:")
            foreach ($package in $packageReferences) {
                $version = if ($package.Version) { $package.Version } else { '(central/inherited)' }
                $lines.Add("  $($package.Include) | $version")
            }
        }
    }

$lines.Add("")
$lines.Add("=== TEST AND COVERAGE CONFIGURATION FILES ===")
Get-ChildItem -Path $rootPath -Recurse -File |
    Where-Object {
        -not (Test-IsExcludedPath $_.FullName) -and
        $_.Name -in @(
            'runsettings.xml',
            '.runsettings',
            'coverlet.runsettings',
            'sonar-project.properties',
            'Directory.Build.props',
            'Directory.Build.targets',
            'Directory.Packages.props',
            'package.json',
            'angular.json',
            'tsconfig.json',
            'tsconfig.app.json',
            'tsconfig.spec.json'
        )
    } |
    Sort-Object FullName |
    ForEach-Object {
        $lines.Add([System.IO.Path]::GetRelativePath($rootPath, $_.FullName))
    }

$lines | Set-Content -Path $outputPath -Encoding UTF8

Write-Host "Inventory written to: $outputPath" -ForegroundColor Green
Write-Host "Review the file for secrets before sharing it." -ForegroundColor Yellow
