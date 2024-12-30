pipeline {
    agent any

    environment {
        PROJECT_ID = 'symmetric-aura-445306-q2'
        IMAGE_NAME = 'simple_app' 
        IMAGE_TAG = 'v1'                
        CLUSTER_NAME = 'my-first-cluster-2'        
        CLUSTER_ZONE = 'us-central1-c'            
        SERVICE_ACCOUNT_KEY = credentials('multi-k8s')
    }

    stages {
        stage('Checkout Code') {
            steps {
                git "https://github.com/sam-k16/react.git"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t asia-south1-docker.pkg.dev/symmetric-aura-445306-q2/samrepo/simple_app ."
                }
            }
        }

        stage('Authenticate with GCP') {
            steps {
                script {
                    // Authenticate with GCP
                    sh """
                    echo $SERVICE_ACCOUNT_KEY > gcloud-key.json
                    gcloud auth activate-service-account --key-file=gcloud-key.json
                    gcloud config set project $PROJECT_ID
                    """
                }
            }
        }

        stage('Push Docker Image to GCR') {
            steps {
                script {
                    // Push image to Google Container Registry
                    sh "gcloud auth configure-docker"
                    sh "docker push asia-south1-docker.pkg.dev/symmetric-aura-445306-q2/samrepo/simple_app:v2"
                }
            }
        }

        stage('Deploy to GKE') {
            steps {
                script {
                    // Configure kubectl for the GKE cluster
                    sh """
                    gcloud container clusters get-credentials $CLUSTER_NAME --zone $CLUSTER_ZONE --project $PROJECT_ID
                    kubectl apply -f kubernetes/deploy.yml
                    """
                }
            }
        }
    }

    post {
        always {
            cleanWs() // Cleanup workspace
        }
    }
}
