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

        stage('[Java] Gradle') {
            steps {
                script {
                    try {
                        sh '''
                            cd ./java
                            chmod +x ./gradlew && ./gradlew clean test --no-daemon
                        '''
                    } finally {
                        junit '**/build/test-results/test/*.xml'
                        //make the junit test results available in any case (success & failure)
                    }
                }
            }
        }

        stage('[C++] Retrieve cmake') {
            steps {
                sh '''
                    CMAKE_VERSION=3.19.3
                    CMAKE_ZIP_URL="http://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz"
                    CMAKE_EXPECTED_FOLDER=cmake-${CMAKE_VERSION}-Linux-x86_64
                    CMAKE_EXPECTED_ZIP_FILE=${CMAKE_EXPECTED_FOLDER}.tar.gz
                    mkdir -p ./cmake
                    pushd ../cmake
                    if [ ! -f "${CMAKE_EXPECTED_ZIP_FILE}" ]
                    then
                        wget --output-document="${CMAKE_EXPECTED_ZIP_FILE}" ${CMAKE_ZIP_URL}
                        tar -xf ${CMAKE_EXPECTED_ZIP_FILE}
                        mv ${CMAKE_EXPECTED_FOLDER} cmake-Linux-x86_64
                    fi
                    popd
                '''
            }
        }

        stage('[C++] Clean Up') {
            steps {
                sh 'rm -rf build'
                sh 'mkdir build'
            }
        }

        stage('[C++] Generate Makefiles') {
            steps {
                sh '''
                    cd ./build
                    source /opt/rh/devtoolset-8/enable
                    ../../cmake/cmake-Linux-x86_64/bin/cmake -G "Unix Makefiles" -S ../cpp
                '''
            }
        }

        stage('[C++] Build Solution') {
            steps {
                sh '''
                    cd ./build
                    source /opt/rh/devtoolset-8/enable
                    ../../cmake/cmake-Linux-x86_64/bin/cmake --build . --config Debug
                '''
            }
        }

        stage('[C++] Run Tests') {
            steps {
                sh '''
                    cd ./build
                    ../../cmake/cmake-Linux-x86_64/bin/ctest -C Debug
                '''
            }
        }
    }
}
