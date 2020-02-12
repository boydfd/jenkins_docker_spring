pipeline {
    agent none
    stages {
		stage('Test') {
			agent { kubernetes { label 'gradle' }}
			steps {
				container ('gradle') {
					sh '''
					./gradlew clean test
					ls /usr/bin
					ls /usr/local/bin
					'''
				}
			}
			post {
				always {
					junit 'build/test-results/**/*.xml'
				}
			}
		}
		stage('Build') {
			agent { kubernetes { label 'gradle' }}
			steps {
				container ('gradle') {
				sh './gradlew clean build'
				}
			}
			post {
				success {
					archiveArtifacts artifacts: 'build/libs/*.jar', fingerprint: true
				}
			}
		}

        stage('Build Docker') {
			agent { kubernetes { label 'docker' }}
            steps {
				container ('docker') {
					step([$class              : 'CopyArtifact',
						  filter              : 'build/libs/*.jar',
						  fingerprintArtifacts: true,
						  projectName         : '${JOB_NAME}',
						  selector            : [$class: 'SpecificBuildSelector', buildNumber: '${BUILD_NUMBER}']
					])
//
					sh 'cp build/libs/*.jar docker/app.jar'
					sh 'docker/build.sh'
					sh 'ls /usr/bin'
					sh 'ls /usr/local/bin'
				}
            }
        }
    }
}