#!/bin/bash

NAME="jenkins-job-dsl-to-xml"

REPOSITORY=releases
REPOSITORYID=releases

GROUPID=com.rsmaxwell.players
ARTIFACTID=${NAME}_amd64-linux
VERSION=${BUILD_ID}
PACKAGING=zip

URL=https://pluto.rsmaxwell.co.uk/archiva/repository/${REPOSITORY}

FILENAME=${ARTIFACTID}_${VERSION}.${PACKAGING}

rm -rf ~/workspace/${NAME}_main/deploy
mkdir -p ~/workspace/${NAME}_main/deploy

cd ~/workspace/${NAME}_main/bin
zip ../deploy/${FILENAME} *

cd ~/workspace/${NAME}_main/deploy
mvn --batch-mode deploy:deploy-file -DgroupId=${GROUPID} -DartifactId=${ARTIFACTID} -Dversion=${VERSION} -Dpackaging=${PACKAGING} -Dfile=${FILENAME} -DrepositoryId=${REPOSITORYID} -Durl=${URL} -DrepositoryId=${REPOSITORYID}

