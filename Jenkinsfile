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
        stage('Build') {
            agent {
                docker {
                    image 'java:8-jdk-alpine'
                    args '-v /home/jenkins/.gradle:/root/.gradle'
                }
            }
            steps {
                sh './gradlew clean build'
            }
            post {
                success {
                    archiveArtifacts artifacts: 'build/libs/*.jar', fingerprint: true
                }
            }
        }

        stage('Build Docker') {
            agent {
                docker {
                    image 'docker:stable'
                    args '-v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                step([$class              : 'CopyArtifact',
                      filter              : 'build/libs/*.jar',
                      fingerprintArtifacts: true,
                      projectName         : '${JOB_NAME}',
                      selector            : [$class: 'SpecificBuildSelector', buildNumber: '${BUILD_NUMBER}']
                ])

                sh 'cp build/libs/*.jar docker/app.jar'
                sh 'docker/build.sh'
            }
        }

        stage('Deploy') {
            agent {
                docker { image 'busybox' }
            }
            steps {
                sshPublisher(publishers: [
                        sshPublisherDesc(
                                configName: 'configuration1',
                                transfers: [sshTransfer(execCommand: 'echo 111')])])
            }
        }
    }
}