pipeline {
	agent {
		label 'go'
	}

    environment {
        GOPATH = "${pwd}"
		PATH = "${PATH}:/usr/local/go/bin"
		NAME = "job-to-xml"
    }

	stages {
		stage('prepare') {
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
			}
		}

		stage('build') {
			steps {
				echo 'building the application'
				sh('./build.sh')
			}
		}

		stage('test') {
			steps {
				echo 'testing the application'
				sh("./test.sh")
			}
		}

		stage('deploy') {
			steps {
				echo 'deploying the application'
				sh('./deploy.sh')
			}
		}
	}
}

