pipeline{
    agent any
    parameters {
      choice choices: ['Dev', 'Test', 'Prod'], description: 'Passing envi details using Parameters', name: 'EnvirName'
    }
    
    stages{
        stage("maven buld"){
            when{
                expression {params.EnvirName == 'Dev'}
            } 
            steps{
                sh "mvn clean package"
            }
        }
        stage("Upload artifacts to Nexus"){
            when{
                expression {params.EnvirName == 'Dev'}
            }
            steps{
                script{
                    def pom = readMavenPom file: 'pom.xml'
                    def ver = pom.version
                    def repoName = 'doctor-online-release'
                    if(ver.endsWith("SNAPSHOT")){
                        repoName = 'doctor-online-snapshot'                        
                    }
                    nexusArtifactUploader artifacts: [[artifactId: 'doctor-online', 
                    classifier: '', file: 'target/doctor-online.war',
                    type: 'war']], credentialsId: 'nexus3', groupId: 'in.javahome',
                    nexusUrl: '3.21.39.182:8081',
                    nexusVersion: 'nexus3', protocol: 'http',
                    repository: repoName, version: ver
                }
            }
        }
        stage("Deployment to Dev"){
            when{
                expression {params.EnvirName == 'Dev'}
            }
            steps{
                echo params.EnvirName
                echo "dev deployment"
            }
        } 
        stage("Deployment to Test"){
            when{
                expression { params.EnvirName == 'Test'}
            }
            steps{
                echo params.EnvirName
                echo "Test deployment"
            }
        } 
        stage("Deployment to Prod"){
            when{
                expression { params.EnvirName == 'Prod'}
            }
            steps{
                echo params.EnvirName
                echo "PROD deployment"
            }
        }
    }
}
