pipeline {
	agent {
		docker {
			image 'rsmaxwell/go'
			label 'go'
		}
	}

	stages {
		stage('prepare') {
			steps {
				echo 'preparing the application'
				dir('src/github.com/rsmaxwell/jenkins-job-dsl-to-xml') {
					checkout([
						$class: 'GitSCM', 
						branches: [[name: '*/main']], 
						extensions: [], 
						userRemoteConfigs: [[url: 'https://github.com/rsmaxwell/jenkins-job-dsl-to-xml']]
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

