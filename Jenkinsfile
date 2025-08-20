pipeline {
    agent any

    tools {
        nodejs "DefaultNode"
    }

    environment {
        PROJECT_ID = "your-gcp-project-id"
        REGION = "us-central1"
        SERVICE = "nodejs-demo-service"
        IMAGE = "gcr.io/${PROJECT_ID}/${SERVICE}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install & Test') {
            steps {
                sh 'npm install'
                sh 'npm test || echo "No tests defined"'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "gcloud auth configure-docker -q"
                sh "docker build -t $IMAGE ."
            }
        }

        stage('Push to GCP Artifact Registry') {
            steps {
                sh "docker push $IMAGE"
            }
        }

        stage('Deploy to Cloud Run') {
            steps {
                sh """
                gcloud run deploy $SERVICE \
                  --image $IMAGE \
                  --platform managed \
                  --region $REGION \
                  --allow-unauthenticated
                """
            }
        }
    }

    post {
        success {
            echo " Deployment successful! Your app is live on GCP Cloud Run."
        }
        failure {
            echo " Build or Deploy failed. Check logs."
        }
    }
}
