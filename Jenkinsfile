pipeline {
    agent {
        kubernetes {
            yaml '''
              apiVersion: v1
              kind: Pod
              spec:
                containers:
                - name: git
                  image: alpine/git:latest
                  command:
                  - cat
                  tty: true
                - name: go
                  image: golang:latest
                  command:
                  - cat
                  tty: true
                - name: maven
                  image: maven:alpine
                  command:
                  - cat
                  tty: true
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
					sh('id -a')
					sh('pwd')
					sh('ls -al')
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

