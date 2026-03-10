pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        DOCKER_USER = "ansiee"
    }

    stages {

        stage('SonarQube Scan') {
    steps {
        withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN')]) {
            sh '''
            docker run --rm \
            --network=host \
            -v $(pwd):/usr/src \
            sonarsource/sonar-scanner-cli \
            -Dsonar.host.url=http://localhost:9000 \
            -Dsonar.login=$SONAR_TOKEN \
            -Dsonar.projectKey=microservices-devops \
            -Dsonar.projectName=microservices-devops \
            -Dsonar.sources=.
            '''
        }
    }
}
        stage('Trivy Security Scan') {
    steps {
        sh '''
        trivy image ansiee/auth-service:latest
        trivy image ansiee/product-service:latest
        trivy image ansiee/order-service:latest
        '''
    }
}

        stage('Build Images') {
            steps {
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
    }
}