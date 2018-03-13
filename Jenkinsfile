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
                    args '-v /home/jenkins/.gradle:/root/.gradle'
                }
            }
            steps {
                sh './gradlew clean test'
            }
            post {
                always {
                    junit 'build/test-results/**/*.xml'
                }
            }
        }
    }
}