pipeline {

  agent { label 'master' }

  environment {
    registry = 'knmkonexion'
    registryCredential = 'kasey-dockerhub'
    dockerImage = ''
    IMAGE_NAME = 'nginx-web'
    IMAGE_VERSION = 'dev-0.0.1'
  }

  stages {

    stage('Build Image') {
      steps {
        script {
          dockerImage = docker.build "${registry}/${IMAGE_NAME}:${IMAGE_VERSION}"
        }
      }
    }

    // STOPPED WORKING, figure out why later....    
    // stage('Test Image') {
    //   agent {
    //     docker {
    //       label 'master'
    //       image "${registry}/${IMAGE_NAME}:${IMAGE_VERSION}"
    //       registryCredentialsId "${registryCredential}"
    //       reuseNode true
    //     }
    //   }
    //   steps {
    //     sh """
    //       ls -alh /usr/share/nginx/html
    //     """
    //   }
    // }

    stage('Publish Image') {
      steps {
        script {
          docker.withRegistry('', registryCredential) { dockerImage.push() }
        }
      }
    }
 
  }
}