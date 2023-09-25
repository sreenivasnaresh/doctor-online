pipeline{
    agent any
    stages{
        stage("git checkout"){
            steps{
                git branch: 'main', credentialsId: '3f038be7-ca0a-4c0d-bc0d-8e27d692c28e', url: 'https://github.com/sreenivasnaresh/doctor-online'
            }
        }
        stage("maven buld"){
            steps{
                sh "mvn clean package"
            }
        }
        stage("Web deployment"){
            steps{
                sshagent(['SSH-tomcat-server']) {
                    sh "scp -o StrictHostKeyChecking=no target/doctor-online.war ec2-user@172.31.13.133:/opt/tomcat9/webapps/"
                    sh "ssh ec2-user@172.31.13.133 /opt/tomcat9/bin/shutdown.sh"
                    sh "ssh ec2-user@172.31.13.133 /opt/tomcat9/bin/startup.sh"
                }
            }
        }
    }
}
