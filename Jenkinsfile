pipeline {
    agent any

    environment {
        PROJECT_ID = 'symmetric-aura-445306-q2'
        IMAGE_NAME = 'simple_app' 
        IMAGE_TAG = 'v1'                
        CLUSTER_NAME = 'my-first-cluster-2'        
        CLUSTER_ZONE = 'us-central1-c'            
       
    }
#first jenkin file
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
     stage ('gcloud auth') {
            steps {
                script {
                    sh "gcloud auth configure-docker asia-south1-docker.pkg.dev"
                }
            }
        }
        stage('Push Docker Image to GCR') {
            steps {
                script {
                    sh "docker push asia-south1-docker.pkg.dev/symmetric-aura-445306-q2/samrepo/simple_app"
                }
            }
        }
        stage('Deploy to GKE') {
            steps {
                script {
                    sh "kubectl apply -f deploy.yml"
                }
            }
        }
        stage(check) {
            steps {
                script {
                    sh "kubectl get pods"
                }
            }
        }
    }
}      
