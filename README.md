# UST-Live-01

Initialized by UST EvalHub.

# HealthAxis

HealthAxis is a full-stack healthcare appointment and health-record management application with separate experiences for patients, doctors, and administrators. The deployed solution hosts an Angular application at the site root, an ASP.NET Core API under `/api`, and a Blazor WebAssembly administration portal under `/admin`.

> **Demo environment:** The AWS Elastic Beanstalk environment and the infrastructure EC2 instance are normally terminated/stopped outside demonstrations to control cost. The application URL is therefore available only while the demo environment is running.

## Key Features

### Patient
- Register and authenticate with JWT-based security.
- Browse doctors and available appointment slots.
- Book and cancel eligible appointments.
- View appointments, health records, and profile information.

### Doctor
- Manage availability.
- Review pending, confirmed, upcoming, and cancelled appointments.
- Confirm or cancel eligible appointments.
- Complete consultations by creating health records.
- View authorised patient history and manage profile information.

### Administrator
- Authenticate through Angular and complete a one-time handoff to the Blazor portal.
- View dashboard information, doctors, patients, and appointment reports.
- Add and manage doctors.
- Cancel eligible appointments and manage the current administrator profile.

## Architecture

```text
Internet
  -> AWS Elastic Beanstalk (.NET 10 on Linux)
       -> Angular 21                 /
       -> ASP.NET Core API           /api
       -> Blazor WebAssembly Admin   /admin
       -> Health endpoint            /health
       -> Private VPC connectivity
            -> SQL Server on EC2     TCP 1433
            -> RabbitMQ on EC2       TCP 5672

GitHub push
  -> Jenkins
       -> Build Angular
       -> Publish Blazor
       -> Build and test .NET solution
       -> Publish API
       -> Package and upload to S3
       -> Create Elastic Beanstalk version
       -> Deploy and verify environment status
```

The Angular and Blazor production outputs are bundled into `HealthAxis.API/wwwroot`, allowing Elastic Beanstalk to deploy the application as one release package.

## Technology Stack

- **API:** ASP.NET Core and .NET 10
- **Patient/Doctor frontend:** Angular 21, TypeScript, RxJS and Tailwind CSS
- **Administration frontend:** Blazor WebAssembly on .NET 10
- **Data:** Entity Framework Core 10 and Microsoft SQL Server
- **Authentication:** ASP.NET Core Identity and JWT bearer authentication
- **Messaging:** RabbitMQ with MassTransit
- **Mapping:** AutoMapper
- **Logging:** Serilog console and rolling-file sinks
- **Testing:** xUnit, Moq, EF Core In-Memory provider and Coverlet
- **CI/CD:** Jenkins, GitHub, AWS CLI, Amazon S3 and AWS Elastic Beanstalk

## Repository Structure

```text
HealthAxis.API/       ASP.NET Core API, persistence, services, messaging and hosting
HealthAxis.Admin/     Blazor WebAssembly administrator portal
HealthAxis.Shared/    Shared DTOs, enums, constants and contracts
HealthAxis.Web/       Angular public, patient and doctor application
HealthAxisTests/      Automated backend tests
HealthAxis.slnx       .NET solution
Jenkinsfile           Jenkins build, test and deployment pipeline
```

## Local Prerequisites

- .NET 10 SDK
- Node.js 24 and npm 11
- Microsoft SQL Server
- RabbitMQ
- Git

Do not commit database passwords, JWT signing keys, RabbitMQ passwords, AWS credentials, private keys, backups, generated deployment packages, or local publish output.

## Local Configuration

The committed `appsettings.json` contains configuration keys but no production secrets. Supply sensitive local values through .NET User Secrets or another secure local configuration source.

Required configuration sections include:

```text
ConnectionStrings:HealthAxisDb
Jwt:Issuer
Jwt:Audience
Jwt:Key
Jwt:AccessTokenExpirationMinutes
RabbitMq:HostName
RabbitMq:Port
RabbitMq:UserName
RabbitMq:Password
RabbitMq:VirtualHost
RabbitMq:AppointmentBookedQueue
SeedData:SeedDemoData
```

Example local commands:

```powershell
cd HealthAxis.API
dotnet user-secrets set "ConnectionStrings:HealthAxisDb" "<local-connection-string>"
dotnet user-secrets set "Jwt:Key" "<strong-local-signing-key>"
dotnet user-secrets set "RabbitMq:Password" "<local-rabbitmq-password>"
```

## Build and Test

Install and build Angular first because its production output is written into the API web root and may clean that directory:

```powershell
cd HealthAxis.Web
npm ci
npm run build
cd ..
```

Publish Blazor and copy its static output under `/admin`:

```powershell
dotnet publish .\HealthAxis.Admin\HealthAxis.Admin.csproj -c Release -o .\blazor-publish-temp
Remove-Item .\HealthAxis.API\wwwroot\admin -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path .\HealthAxis.API\wwwroot\admin -Force | Out-Null
Copy-Item .\blazor-publish-temp\wwwroot\* .\HealthAxis.API\wwwroot\admin -Recurse -Force
```

Build and test the solution:

```powershell
dotnet build .\HealthAxis.slnx -c Release --no-incremental
dotnet test .\HealthAxisTests\HealthAxisTests.csproj -c Release --no-build
```

Run the API locally:

```powershell
dotnet run --project .\HealthAxis.API\HealthAxis.API.csproj
```

Swagger is enabled only in the Development environment.

## AWS Deployment

### Environment

- **Region:** `ap-south-1`
- **Elastic Beanstalk application:** `HealthAxis`
- **Demo environment:** `HealthAxis-dev`
- **Platform:** .NET 10 on 64-bit Amazon Linux 2023
- **Deployment model:** Single instance for the training/demo environment
- **Deployment bundle storage:** `s3://healthaxis-db-migration-2026/jenkins-deployments/`

The infrastructure EC2 instance hosts SQL Server and RabbitMQ. The Elastic Beanstalk instance and infrastructure instance use the same VPC.

### Network Security

- `healthaxis-beanstalk-app-sg` is attached to each Elastic Beanstalk application instance.
- SQL Server port `1433` and RabbitMQ port `5672` accept traffic only from `healthaxis-beanstalk-app-sg`.
- Database and messaging ports are not exposed to `0.0.0.0/0`.
- The temporary Elastic Beanstalk-managed security group is not referenced by the infrastructure security group.
- SSH is not publicly exposed; AWS Systems Manager Session Manager is used for infrastructure administration.
- The application does not use the SQL Server `sa` account or the RabbitMQ `guest` account remotely.

### Production Configuration

Elastic Beanstalk environment properties provide production settings, including:

```text
ASPNETCORE_ENVIRONMENT=Production
ConnectionStrings__HealthAxisDb
Jwt__Issuer
Jwt__Audience
Jwt__Key
Jwt__AccessTokenExpirationMinutes
RabbitMq__HostName
RabbitMq__Port
RabbitMq__UserName
RabbitMq__Password
RabbitMq__VirtualHost
RabbitMq__AppointmentBookedQueue
SeedData__SeedDemoData
```

Real values are intentionally excluded from this repository.

## Jenkins CI/CD Pipeline

The root `Jenkinsfile` defines a Declarative Pipeline with the following stages:

1. Clean the Jenkins workspace and check out the selected Git commit.
2. Verify .NET, Node.js, npm, AWS CLI and JAR tooling.
3. Install locked Angular dependencies with `npm ci`.
4. Build Angular into the API web root.
5. Publish Blazor WebAssembly and copy its static assets to `wwwroot/admin`.
6. Build the complete .NET solution in Release mode.
7. Run the automated backend tests.
8. Publish the ASP.NET Core API.
9. Create a Linux-compatible deployment ZIP with `jar`.
10. Upload the versioned package to Amazon S3.
11. Create a new Elastic Beanstalk application version.
12. Update `HealthAxis-dev`, wait for the deployment operation, and report environment status.
13. Archive and fingerprint the successful deployment artifact.

The pipeline prevents concurrent deployments and reports explicit success or failure messages. AWS access keys are stored in the Jenkins credential store under `aws-deploy-creds`; they are not written into the Jenkinsfile.

For the controlled demo, Poll SCM may remain disabled and the job can be started with **Build Now**. When automatic polling is enabled, Jenkins monitors the GitHub `main` branch and starts the pipeline after detecting a new commit.

## Health and Deployment Verification

After deployment:

1. Confirm Jenkins reports `SUCCESS`.
2. Confirm Elastic Beanstalk reports `Ready` and healthy status.
3. Confirm the running version matches `healthaxis-<Jenkins build number>`.
4. Verify these routes:
   - `/health`
   - `/`
   - `/login`
   - `/admin/`
5. Run the end-to-end patient, doctor and administrator demonstration.

Invalid `/api` routes return `404` rather than Angular HTML. Separate SPA fallbacks support Angular at `/` and Blazor under `/admin`.

## Demo Flow

A suggested structured demonstration is:

1. Introduce the business problem, user roles and architecture.
2. Show the Jenkins pipeline and explain build, test and deployment automation.
3. Trigger or review a successful pipeline run.
4. Verify Elastic Beanstalk health and the `/health` endpoint.
5. Register or log in as a patient and book an available appointment.
6. Log in as the doctor, manage the appointment and complete the consultation.
7. Log in as the administrator through the Angular-to-Blazor handoff and verify the updated data.
8. Summarise security controls, testing, monitoring and known limitations.
9. Terminate the Elastic Beanstalk environment and stop the infrastructure EC2 instance after the demo.

## Security and Production-Readiness Controls

- JWT validation checks issuer, audience, lifetime and signing key with zero clock skew.
- Role and ownership rules are enforced by the API rather than UI state.
- ASP.NET Core Identity requires unique email addresses and strong passwords.
- Global exception handling returns standard problem details.
- Serilog provides structured request and application logging.
- Swagger is restricted to Development.
- Generated files, build output, logs, Sonar working directories, test results and local user files are excluded by `.gitignore`.
- AWS credentials are injected temporarily from Jenkins Credentials Binding.
- Runtime secrets are supplied outside source control through Elastic Beanstalk environment configuration.
- The `/health` endpoint supports deployment verification.

## Environment Lifecycle and Cost Control

The cloud environment is provisioned only for demonstrations:

1. Start `healthaxis-infrastructure` and verify SQL Server and RabbitMQ.
2. Create `HealthAxis-dev` under the existing Elastic Beanstalk application.
3. Attach `healthaxis-beanstalk-app-sg` and add the secured environment properties.
4. Deploy using Jenkins and validate the application.
5. Disable Poll SCM after the demonstration.
6. Terminate `HealthAxis-dev` and wait for its resources to be removed.
7. Stop, but do not terminate, `healthaxis-infrastructure`.

The Elastic Beanstalk application, permanent security group, private S3 database backup, Jenkins job, and infrastructure EBS volume are retained for reuse.

## Known Limitations and Planned Improvements

- Deployment secrets are currently supplied through Elastic Beanstalk environment properties for the training environment. AWS Secrets Manager or Systems Manager Parameter Store is the intended hardening path.
- HTTPS with a managed certificate and custom domain is a future production-hardening task.
- Database-aware and RabbitMQ-aware health checks can extend the current process health endpoint.
- Test-only Coverlet dependencies should be kept in the test project rather than the API project.
- The Jenkins pipeline verifies Elastic Beanstalk deployment status; additional HTTP smoke tests can further strengthen post-deployment validation.

## AI-Assisted Development

Microsoft Copilot was used as an engineering assistant during selected activities, including deployment troubleshooting, Jenkins pipeline guidance, architecture review, documentation drafting and targeted debugging. AI-generated suggestions were not accepted blindly: commands, configuration changes, code changes, build output, test results, AWS health, and end-to-end flows were reviewed and validated by the developer before use.

No production credential or secret value is included in AI-generated documentation or committed source files.

## Repository

Sprint 5 demonstration repository:

```text
https://github.com/nevinjoyce-ust/HealthAxis-Sprint5
```

## Disclaimer

HealthAxis is a training and demonstration project. It is not intended for real clinical use or for storing real patient data.
