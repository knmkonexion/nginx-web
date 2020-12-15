pipeline {

  agent { label 'master' }

  environment {
    registry = 'knmkonexion'
    registryCredential = 'kasey-dockerhub'
    dockerImage = ''
    IMAGE_NAME = 'nginx-site'
    IMAGE_VERSION = 'latest'
  }

  stages {

    stage('Build Image') {
      steps {
        script {
          dockerImage = docker.build "${registry}/${IMAGE_NAME}:${IMAGE_VERSION}"
        }
      }
    }
    
    stage('Test Image') {
      agent {
        docker {
          label 'master'
          image "${registry}/${IMAGE_NAME}:${IMAGE_VERSION}"
          registryCredentialsId "${registryCredential}"
          reuseNode true
        }
      }
      steps {
        sh """
          curl localhost:80
        """
      }
    }

    stage('Publish Image') {
      steps {
        script {
          docker.withRegistry('', registryCredential) { dockerImage.push() }
        }
      }
    }
 
  }
}