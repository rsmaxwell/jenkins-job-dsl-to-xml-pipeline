#!/bin/bash

echo "---[ deploy ]------------------------"
cd ${BASE}
echo "pwd = $(pwd)"

set -x 

echo "---[ /usr/bin ]------------"
ls -al /usr/bin
echo "---[ /usr/local ]------------"
ls -al /usr/local

mvn -version

REPOSITORY=releases
REPOSITORYID=releases

GROUPID=com.rsmaxwell.jenkins
ARTIFACTID=${NAME}_amd64-linux
VERSION=${BUILD_ID}
PACKAGING=zip

URL=https://pluto.rsmaxwell.co.uk/archiva/repository/${REPOSITORY}

FILENAME=${ARTIFACTID}_${VERSION}.${PACKAGING}

rm -rf ${WORKSPACE}/deploy
mkdir -p ${WORKSPACE}/deploy

cd ${WORKSPACE}/bin
zip ../deploy/${FILENAME} *

cd ${WORKSPACE}/deploy
mvn --batch-mode deploy:deploy-file -DgroupId=${GROUPID} -DartifactId=${ARTIFACTID} -Dversion=${VERSION} -Dpackaging=${PACKAGING} -Dfile=${FILENAME} -DrepositoryId=${REPOSITORYID} -Durl=${URL} -DrepositoryId=${REPOSITORYID}

