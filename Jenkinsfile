pipeline {
    agent any
    
    environment {
        // Update these values with your information
        DOCKER_REGISTRY = 'docker.io'
        DOCKER_IMAGE = 'your-dockerhub-username/flask-app'
        DOCKER_CREDENTIALS = 'docker-hub-credentials'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Setup Python') {
            steps {
                script {
                    // Create and activate virtual environment
                    sh '''
                        python -m venv .venv
                        . .venv/bin/activate
                        pip install -r requirements.txt
                    '''
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    sh '''
                        . .venv/bin/activate
                        python -m pytest tests/
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build with branch name or latest for main
                    def imageTag = env.BRANCH_NAME == 'main' ? 'latest' : env.BRANCH_NAME
                    sh "docker build -t ${DOCKER_IMAGE}:${imageTag} ."
                }
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
                script {
                    def imageTag = env.BRANCH_NAME == 'main' ? 'latest' : env.BRANCH_NAME
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh """
                            echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin
                            docker push ${DOCKER_IMAGE}:${imageTag}
                        """
                    }
                }
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
                script {
                    def port = env.BRANCH_NAME == 'main' ? '5000' : '5001'
                    sh """
                        chmod +x scripts/deploy.sh
                        ./scripts/deploy.sh ${env.BRANCH_NAME} ${port}
                    """
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed! Check the logs for details."
        }
    }
}