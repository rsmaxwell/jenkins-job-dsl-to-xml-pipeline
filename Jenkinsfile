pipeline {
	agent none

    environment {
        GOPATH = "${WORKSPACE}"
		PATH = "${PATH}:/usr/local/go/bin:${GOPATH}/bin"
		NAME = "job-to-xml"
		BASE = "${WORKSPACE}/src/github.com/rsmaxwell/${NAME}"
    }

	stages {
		stage('prepare') {
            agent { label 'go' }
			steps {
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

		stage('build') {
			agent { label 'go' }
			steps {
				echo 'building the application'
				sh('./build.sh')
			}
		}

		stage('test') {
			agent { label 'go' }
			steps {
				echo 'testing the application'
				sh("./test.sh")
			}
		}

		stage('deploy') {
			agent { label 'maven' }
			steps {
				echo 'deploying the application'
				sh('./deploy.sh')
			}
		}
	}
}

