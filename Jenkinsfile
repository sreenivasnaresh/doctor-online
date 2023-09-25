pipeline{
    agent any
    parameters {
      choice choices: ['Dev', 'Test', 'Prod'], description: 'Passing envi details using Parameters', name: 'EnvirName'
    }
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
        stage("Deployment to Dev"){
            steps{
                params.EnvirName
                echo "dev deployment"
            }
        } 
        stage("Deployment to Test"){
            steps{
                params.EnvirName
                echo "Test deployment"
            }
        } 
        stage("Deployment to Prod"){
            steps{
                params.EnvirName
                echo "PROD deployment"
            }
        }
    }
}
