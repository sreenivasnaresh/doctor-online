pipeline{
    agent any
    parameters {
      choice choices: ['Dev', 'Test', 'Prod'], description: 'Passing envi details using Parameters', name: 'EnvirName'
    }
    environment {
        nexus_url = "172.31.22.124:8081"
    }
    
    stages{
        stage("maven buld"){
            when{
                expression{params.EnvirName == 'Dev'}
            }
            steps{
                sh "mvn clean package"
            }
        }
        stage("Upload artifacts to Nexus"){
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
                    nexusUrl: env.nexus_url,
                    nexusVersion: 'nexus3', protocol: 'http',
                    repository: repoName, version: ver
                }
            }
        }
        stage("Download artifacts from Nexus"){
            steps{
                script{
                    withCredentials([usernameColonPassword(credentialsId: 'nexus3', variable: 'USERPASS')]){
                        def pom = readMavenPom file: 'pom.xml'
                        def ver = pom.version 
                        sh """
                            curl -o doctor-online.war -u $USERPASS -X GET "${env.nexus_url}/repository/doctor-online-release/in/javahome/doctor-online/${ver}/doctor-online-${ver}.war"
                        """
                    }  
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
