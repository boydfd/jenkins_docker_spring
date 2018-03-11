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
  }
}