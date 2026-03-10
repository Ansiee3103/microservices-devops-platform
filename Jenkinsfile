pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        DOCKER_USER = "ansiee"
    }

    stages {

        stage('Build Images') {
            stgit eps {
                sh 'docker build -t $DOCKER_USER/auth-service:latest ./services/auth-service'
                sh 'docker build -t $DOCKER_USER/product-service:latest ./services/product-service'
                sh 'docker build -t $DOCKER_USER/order-service:latest ./services/order-service'
            }
        }

        stage('Docker Login') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Push Images') {
            steps {
                sh 'docker push $DOCKER_USER/auth-service:latest'
                sh 'docker push $DOCKER_USER/product-service:latest'
                sh 'docker push $DOCKER_USER/order-service:latest'
            }
        }
        stage('SonarQube Scan') {
    steps {
        withSonarQubeEnv('SonarQube') {
            sh '''
            docker run --rm \
            -e SONAR_HOST_URL=http://host.docker.internal:9000 \
            -e SONAR_LOGIN=$SONAR_AUTH_TOKEN \
            -v $(pwd):/usr/src \
            sonarsource/sonar-scanner-cli
            '''
        }
    }
}
    }
}