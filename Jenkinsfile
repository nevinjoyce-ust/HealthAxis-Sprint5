pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
        timestamps()
        disableConcurrentBuilds()
    }

    environment {
        AWS_REGION = 'ap-south-1'
        AWS_CA_BUNDLE = 'C:\\Users\\Public\\JenkinsCerts\\aws-zscaler-ca-bundle.pem'

        EB_APPLICATION_NAME = 'HealthAxis'
        EB_ENVIRONMENT_NAME = 'HealthAxis-dev'

        S3_BUCKET = 'healthaxis-db-migration-2026'
        S3_PREFIX = 'jenkins-deployments'

        DEPLOYMENT_VERSION = "healthaxis-${BUILD_NUMBER}"
        DEPLOYMENT_PACKAGE = 'healthaxis-deployment.zip'
    }

    stages {
        stage('Clean and Checkout') {
            steps {
                cleanWs()
                checkout scm
            }
        }

        stage('Verify Build Environment') {
            steps {
                bat '''
                    dotnet --version
                    node --version
                    npm.cmd --version
                    aws --version
                    jar --version
                '''
            }
        }

        stage('Install Angular Dependencies') {
            steps {
                dir('HealthAxis.Web') {
                    bat 'npm.cmd ci'
                }
            }
        }

        stage('Build Angular') {
            steps {
                dir('HealthAxis.Web') {
                    bat 'npm.cmd run build'
                }
            }
        }

        stage('Publish Blazor Admin') {
            steps {
                bat '''
                    if exist blazor-publish-temp rmdir /S /Q blazor-publish-temp
                    dotnet publish HealthAxis.Admin\\HealthAxis.Admin.csproj -c Release -o blazor-publish-temp
                '''
            }
        }

        stage('Copy Blazor Admin into API') {
            steps {
                bat '''
                    if exist HealthAxis.API\\wwwroot\\admin rmdir /S /Q HealthAxis.API\\wwwroot\\admin
                    mkdir HealthAxis.API\\wwwroot\\admin
                    xcopy /E /Y /I blazor-publish-temp\\wwwroot\\* HealthAxis.API\\wwwroot\\admin\\
                '''
            }
        }

        stage('Build Solution') {
            steps {
                bat 'dotnet build HealthAxis.slnx -c Release --no-incremental'
            }
        }

        stage('Run Tests') {
            steps {
                bat 'dotnet test HealthAxisTests\\HealthAxisTests.csproj -c Release --no-build'
            }
        }

        stage('Publish API') {
            steps {
                bat '''
                    if exist publish rmdir /S /Q publish
                    dotnet publish HealthAxis.API\\HealthAxis.API.csproj -c Release -o publish --no-restore
                '''
            }
        }

        stage('Create Deployment Package') {
            steps {
                bat '''
                    if exist %DEPLOYMENT_PACKAGE% del /F /Q %DEPLOYMENT_PACKAGE%
                    cd publish
                    jar -cMf ..\\%DEPLOYMENT_PACKAGE% .
                '''
            }
        }

        stage('Upload to S3') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-deploy-creds'
                ]]) {
                    bat '''
                        aws s3 cp %DEPLOYMENT_PACKAGE% s3://%S3_BUCKET%/%S3_PREFIX%/%DEPLOYMENT_VERSION%.zip --region %AWS_REGION%
                    '''
                }
            }
        }

        stage('Create Elastic Beanstalk Version') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-deploy-creds'
                ]]) {
                    bat '''
                        aws elasticbeanstalk create-application-version ^
                            --application-name %EB_APPLICATION_NAME% ^
                            --version-label %DEPLOYMENT_VERSION% ^
                            --description "HealthAxis Jenkins build %BUILD_NUMBER%" ^
                            --source-bundle S3Bucket=%S3_BUCKET%,S3Key=%S3_PREFIX%/%DEPLOYMENT_VERSION%.zip ^
                            --region %AWS_REGION%
                    '''
                }
            }
        }

        stage('Deploy to Elastic Beanstalk') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-deploy-creds'
                ]]) {
                    bat '''
                        aws elasticbeanstalk update-environment ^
                            --environment-name %EB_ENVIRONMENT_NAME% ^
                            --version-label %DEPLOYMENT_VERSION% ^
                            --region %AWS_REGION%

                        aws elasticbeanstalk wait environment-updated ^
                            --environment-names %EB_ENVIRONMENT_NAME% ^
                            --region %AWS_REGION%
                    '''
                }
            }
        }

        stage('Verify Elastic Beanstalk Status') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-deploy-creds'
                ]]) {
                    bat '''
                        aws elasticbeanstalk describe-environments ^
                            --environment-names %EB_ENVIRONMENT_NAME% ^
                            --query "Environments[0].{Environment:EnvironmentName,Status:Status,Health:Health,HealthStatus:HealthStatus,Version:VersionLabel,CNAME:CNAME}" ^
                            --output table ^
                            --region %AWS_REGION%
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'HealthAxis build and Elastic Beanstalk deployment completed successfully.'
        }

        failure {
            echo 'HealthAxis pipeline failed. Review the first failed stage in the console output.'
        }

        always {
            archiveArtifacts artifacts: 'healthaxis-deployment.zip',
                             fingerprint: true,
                             onlyIfSuccessful: true
        }
    }
}