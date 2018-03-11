pipeline {
    agent none
    stages {
        stage('Hello World') {
            agent {
                docker {
                    image 'busybox'
                }

            }
            steps {
                sh 'echo \'hello word\''
            }
        }
        stage('Test') {
            agent {
                docker {
                    image 'java:8-jdk-alpine'
                }
            }
            steps {
                sh './gradlew clean test'
            }
        }
    }
}