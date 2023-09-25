pipeline{
    agent any
    parameters {
      choice choices: ['Dev', 'Test', 'Prod'], description: 'Passing envi details using Parameters', name: 'EnvirName'
    }
    stages{
        stage("maven buld"){
            steps{
                sh "mvn clean package"
            }
        }
        stage("Deployment to Dev"){
            steps{
                echo params.EnvirName
                echo "dev deployment"
            }
        } 
        stage("Deployment to Test"){
            steps{
                echo params.EnvirName
                echo "Test deployment"
            }
        } 
        stage("Deployment to Prod"){
            steps{
                echo params.EnvirName
                echo "PROD deployment"
            }
        }
    }
}
