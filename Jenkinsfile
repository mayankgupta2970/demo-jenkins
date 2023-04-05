pipeline {
  agent any

  environment {
    ECR_REGIONS = ['us-east-1', 'us-west-2']
    ECR_REPO_NAME = 'ecr-demo-img'
    DOCKER_IMAGE_NAME = 'demo-app'
    DOCKERFILE_PATH = './Dockerfile'
  }

  stages {
    stage('Clone Git Repo') {
      steps {
        git branch: 'main', url: 'https://github.com/mayankgupta2970/demo-jenkins.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          docker.build(DOCKER_IMAGE_NAME, "-f ${DOCKERFILE_PATH} .")
        }
      }
    }

    stage('Push Docker Image to ECR') {
      steps {
        script {
          for (region in env.ECR_REGIONS) {
            withAWS(region: region) {
              sh "aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin public.ecr.aws/h2r7k9t2"
              sh "docker tag ${DOCKER_IMAGE_NAME}:latest public.ecr.aws/h2r7k9t2/${ECR_REPO_NAME}:${BUILD_NUMBER}-${region}"
              sh "docker push public.ecr.aws/h2r7k9t2/${ECR_REPO_NAME}:${BUILD_NUMBER}-${region}"
            }
          }
        }
      }
    }
  }
}
          
