pipeline {
    agent {
        kubernetes {
            yaml '''
              apiVersion: v1
              kind: Pod
              spec:
                containers:
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

    environment {
        GOPATH = "${WORKSPACE}"
		PATH = "${PATH}:/usr/local/go/bin:${GOPATH}/bin"
		NAME = "job-to-xml"
		BASE = "${WORKSPACE}/src/github.com/rsmaxwell/${NAME}"
    }

	stages {
		stage('test maven ') {
			steps {
				container('maven') {
					sh('mvn version')
				}
			}
		}

		stage('test go') {
			steps {
				container('go') {
					sh('go version')
				}
			}
		}

		stage('prepare') {
			steps {
				container('go') {
					echo 'preparing the application'
					dir('src/github.com/rsmaxwell/job-to-xml') {
						checkout([
							$class: 'GitSCM', 
							branches: [[name: '*/main']], 
							extensions: [], 
							userRemoteConfigs: [[url: 'https://github.com/rsmaxwell/job-to-xml']]
						])
					}
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

