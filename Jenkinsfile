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
