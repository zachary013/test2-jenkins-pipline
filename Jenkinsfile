pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'docker.io'
        DOCKER_IMAGE = 'zakariaeazn123/flask-app'
        DOCKER_CREDENTIALS = 'docker-hub-credentials'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Simulating code checkout...'
            }
        }
        
        stage('Setup Python') {
            steps {
                echo 'Simulating Python setup...'
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Simulating test execution...'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Simulating Docker image build...'
            }
        }

        stage('Push Docker Image') {
            when {
                anyOf {
                    branch 'main'
                    branch 'staging'
                }
            }
            steps {
                echo 'Simulating Docker image push...'
            }
        }

        stage('Deploy') {
            when {
                anyOf {
                    branch 'main'
                    branch 'staging'
                }
            }
            steps {
                echo 'Simulating deployment...'
            }
        }
    }

    post {
        always {
            echo 'Cleaning workspace...'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed! Check the logs for details.'
        }
    }
}