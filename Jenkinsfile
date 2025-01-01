pipeline {
    agent any

    environment {
        PROJECT_ID = 'symmetric-aura-445306-q2'
        IMAGE_NAME = 'simple_app' 
        IMAGE_TAG = 'v1'                
        CLUSTER_NAME = 'my-first-cluster-2'        
        CLUSTER_ZONE = 'us-central1-c'            
       
    }

    stages {
        stage('Checkout Code') {
            steps {
                git "https://github.com/sam-k16/react.git"
            }
        }
    
     stage ('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t asia-south1-docker.pkg.dev/symmetric-aura-445306-q2/samrepo/simple_app ."
                }
            }
        }
    }
}      
