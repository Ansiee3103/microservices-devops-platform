pipeline {
    agent any

    environment {
        DOCKER_USER = "ansiee"
    }

    stages {

        stage('Clone Repository') {
            steps {
                git 'https://github.com/Ansiee3103/microservices-devops-platform.git'
            }
        }

        stage('Build Auth Service') {
            steps {
                sh 'docker build -t $DOCKER_USER/auth-service:v2 ./services/auth-service'
            }
        }

        stage('Build Product Service') {
            steps {
                sh 'docker build -t $DOCKER_USER/product-service:v2 ./services/product-service'
            }
        }

        stage('Build Order Service') {
            steps {
                sh 'docker build -t $DOCKER_USER/order-service:v2 ./services/order-service'
            }
        }

        stage('Push Images') {
            steps {
                sh 'docker push $DOCKER_USER/auth-service:v2'
                sh 'docker push $DOCKER_USER/product-service:v2'
                sh 'docker push $DOCKER_USER/order-service:v2'
            }
        }
    }
}
