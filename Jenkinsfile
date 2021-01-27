#!/usr/bin/groovy

pipeline {
    agent {
        node {
            label 'curves-dev'
            customWorkspace '/src/new/Kata-BowlingGame'
        }
    }

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }

    stages {
        stage('Gradle') {
            steps {
                script {
                    try {
                        sh '''
                            cd ./java
                            chmod +x ./gradlew && ./gradlew clean test --no-daemon
                        '''
                    } finally {
                        junit '**/build/test-results/test/*.xml'
                    }
                }
            }
        }

        stage('Cmake') {
            steps {
                sh '''
                    cd ./cpp
                    rm -rf ./build
                    source /opt/rh/devtoolset-8/enable
                    ./cpp_easy_setup.sh
                '''
            }
        }
    }
}
