def IMAGE_TAG
def PROJECT_NAME
def PROJECT_VERSION
def REPOSITORY_NAME
def REPOSITORY_IMAGE_URI

pipeline {
    environment {
        JAVA_TOOL_OPTIONS = '-Duser.home=/root'
        AWS_ACCOUNT_ID="612038113296"
        AWS_DEFAULT_REGION="us-east-1" 
        REPOSITORY_BASE_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
        REPOSITORY_BASE_NAME = "manumura"
    }
    agent none
    stages {
        stage('SCM Checkout') {
            agent any
            steps {
                sh """
                    if [ -z "$GIT_REPOSITORY" ]; then
                        echo "*** No Git respository supplied in ENV GIT_REPOSITORY, exiting... ****"
                        exit 1
                    fi
                """

                checkout([$class: 'GitSCM', 
                branches: [[name: '*/master']],
                doGenerateSubmoduleConfigurations: false,
                extensions: [[$class: 'CleanCheckout']],
                submoduleCfg: [], 
                userRemoteConfigs: [[url: "${GIT_REPOSITORY}"]]])
                sh "ls -ltr"
            }
        }
        stage('Build binaries') {
            agent { 
                docker { 
                    image 'maven:3.8.4-openjdk-11-slim' 
                    args '-v /var/jenkins_home:/root'
                } 
            }
            steps {
                script {
                    sh script: 'mvn -B clean package'
                    PROJECT_NAME = sh script: 'mvn help:evaluate -Dexpression=project.name -q -DforceStdout', returnStdout: true
                    PROJECT_VERSION = sh script: 'mvn help:evaluate -Dexpression=project.version -q -DforceStdout', returnStdout: true
                }
                jacoco()
            }
             post {
                success {
                    junit 'target/surefire-reports/*.xml' 
                }
            }
        }
        stage('Build Docker image') {
            agent any
            steps {
                script {
                    CURRENT_DATETIME = sh(script: "echo `date +'%Y%m%d%H%M%S'`", returnStdout: true).trim()
                    IMAGE_TAG = PROJECT_VERSION + "-" + CURRENT_DATETIME

                    REPOSITORY_NAME = REPOSITORY_BASE_NAME + "/" + PROJECT_NAME
                    REPOSITORY_IMAGE_URI = "${REPOSITORY_BASE_URI}/${REPOSITORY_NAME}"
                }
                sh """
                    docker build -t ${REPOSITORY_NAME}:${IMAGE_TAG} .
                """
                // script {
                //     app = docker.build("${env.JOB_NAME}:${env.BUILD_NUMBER}", "-f demo-gateway-client1/Dockerfile .")
                // }
            }
        }
        stage('Push to registry') {
            agent any
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding', 
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                    credentialsId: 'ecr-remote-pusher'
                ]]) {
                    sh """
                        aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${REPOSITORY_BASE_URI}
                        docker tag ${REPOSITORY_NAME}:${IMAGE_TAG} ${REPOSITORY_IMAGE_URI}:$IMAGE_TAG
                        docker push ${REPOSITORY_IMAGE_URI}:${IMAGE_TAG}
                    """
                }
            }
        }
    }
}
