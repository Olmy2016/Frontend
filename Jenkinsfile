def imageName = "192.168.44.44:8082/panda/frontend"
def dockerTag = ""
def dockerRegistry="https://192.168.44.44:8082"
def registryCredentials="artifactory"
pipeline {
    agent { 
        label 'agent' 
    }
    environment {
        PIP_BREAK_SYSTEM_PACKAGES=1
        scannerHome=tool 'SonarQube'
    }
    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
    
        stage('Frontend') {
            steps {
                git branch: 'main', url: 'https://github.com/Olmy2016/Frontend'
            }
        }
        stage('Tests') {
            steps {
                sh '''
                    pip3 install -r requirements.txt
                    python3 -m pytest --cov=. --cov-report xml:test-results/coverage.xml --junitxml=test-results/pytest-report.xml
                
                '''
            }
            post {
                success {
                    sh 'ls -a'
                    archiveArtifacts 'test-results/pytest-report.xml'
                }
            }
        }
        stage('SonarQube analysis') {
            steps {
             //withSonarQubeEnv('SonarQube') {
             //   sh "${scannerHome}/bin/sonar-scanner"
            //}
                sh 'echo sonar'
            }
        }
        stage('Build Frontend'){
            steps{
                script{
                    docker.withRegistry(dockerRegistry,registryCredentials) {
                        dockerTag = "RC-${env.BUILD_ID}"
                        applicationImage = docker.build("$imageName:$dockerTag")
                        applicationImage.push()
                        applicationImage.push('latest')
                    }
                }
            }
        }
    }
    post {
        always {
            junit testResults: "test-results/*.xml"
            cleanWs()
        }
    }
}




