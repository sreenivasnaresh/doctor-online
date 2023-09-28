@Library('jenkins_shared_libs') _
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
            steps{
                sh "mvn clean package"
            }
        }
        stage("Upload artifacts to Nexus"){
            steps{
                script{
                    upload_artifacts_nexus()
                }
            }
        }
        stage("Download artifacts from Nexus"){
            steps{
                script{
                    withCredentials([usernameColonPassword(credentialsId: 'nexus3', variable: 'USERPASS')]){
                        nexus_download_artifacts('doctor-online.war','in.javahome', 'doctor-online','doctor-online-snapshot' )
                        // def pom = readMavenPom file: 'pom.xml'
                        // def ver = pom.version 
                        // sh """
                        //     curl -o doctor-online.war -u $USERPASS -X GET "${env.nexus_url}/repository/doctor-online-release/in/javahome/doctor-online/${ver}/doctor-online-${ver}.war"
                        // """
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
                sshagent(['SSH-tomcat-server']) {
                    sh "scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/pipeline-with-parameters/doctor-online.war ec2-user@172.31.13.133:/opt/tomcat9/webapps/"
                }
                echo params.EnvirName
                echo "PROD deployment"
            }
        }
    }
}
