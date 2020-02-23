pipeline {
    agent none
    options { skipDefaultCheckout(); timeout(time: 1, unit: 'HOURS'); }
    stages {
		stage('Test/Build') {
			agent { kubernetes { label 'gradle' }}
			steps {
				checkout scm
				container ('gradle') {
					sh './gradlew clean test'
					sh './gradlew build'
				}
			}
			post {
				always {
					junit 'build/test-results/**/*.xml'
				}
				success {
					archiveArtifacts artifacts: 'build/libs/*.jar', fingerprint: true
					archiveArtifacts artifacts: 'docker/*', fingerprint: true
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
					step([$class              : 'CopyArtifact',
						  filter              : 'docker/*',
						  fingerprintArtifacts: true,
						  projectName         : '${JOB_NAME}',
						  selector            : [$class: 'SpecificBuildSelector', buildNumber: '${BUILD_NUMBER}']
					])
					sh 'cp build/libs/*.jar docker/app.jar'
					sh 'docker/build.sh'
				}
            }
        }
    }
}