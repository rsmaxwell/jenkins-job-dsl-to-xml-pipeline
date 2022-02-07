pipeline {
    agent {
        kubernetes {
            yaml '''
              apiVersion: v1
              kind: Pod
              spec:
                containers:
                - name: git
                  image: rsmaxwell/git
                  command:
                  - cat
                  tty: true
                - name: go
                  image: rsmaxwell/go
                  command:
                  - cat
                  tty: true
                - name: maven
                  image: rsmaxwell/maven
                  volumeMounts:
                  - name: maven-home
                    mountPath: /home/builder/.m2
                  command:
                  - cat
                  tty: true
                volumes:
                - name: mydir
                  hostPath:
                    path: /var/local/aaa
                    type: DirectoryOrCreate
                - name: myfile
                  hostPath:
                    path: /var/local/aaa/settings.xml
                    type: FileOrCreate
                - name: maven-home
                    local:
                      path: /mnt/disks/ssd1
              '''
        }
    }

    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '5', daysToKeepStr: '', numToKeepStr: '5')
        disableConcurrentBuilds()
    }

    environment {
        GOPATH = "${WORKSPACE}"
        PATH = "${PATH}:/usr/local/go/bin:${GOPATH}/bin"
        NAME = "job-to-xml"
        BASE = "${WORKSPACE}/src/github.com/rsmaxwell/${NAME}"
    }

    stages {

        stage('test maven') {
            steps {
                container('maven') {
                    echo 'test maven'
                    sh('id -a')
                    sh('pwd')
                    sh('ls -al ')
                    sh('ls -al ~/.m2')
                    sh('ls -al /usr/bin/mvn')
                    sh('mvn -version')
                }
            }
        }

        stage('test go') {
            steps {
                container('go') {
                    echo 'test go'
                    sh('go version')
                }
            }
        }

        stage('prepare') {
            steps {
                container('git') {
                    echo 'preparing the application'
                    dir('src/github.com/rsmaxwell/job-to-xml') {
                        checkout([
                            $class: 'GitSCM', 
                            branches: [[name: '*/main']], 
                            extensions: [], 
                            userRemoteConfigs: [[url: 'https://github.com/rsmaxwell/job-to-xml']]
                        ])
                    }
                    sh('pwd')
                    sh('ls -al')
                    sh('ls -al ./prepare.sh')
                    sh('./prepare.sh')
                    echo 'finished preparing'
                }
            }
        }

        stage('build') {
            steps {
                container('go') {
                    echo 'building the application'
                    sh('./build.sh')
                }
            }
        }

        stage('test') {
            steps {
                container('go') {
                    echo 'testing the application'
                    sh("./test.sh")
                }
            }
        }

        stage('deploy') {
            steps {
                container('maven') {
                    echo 'deploying the application'
                    sh('./deploy.sh')
                }
            }
        }
    }
}

