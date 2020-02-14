#!/usr/bin/env sh

dockerRegistry='docker.aboydfd.com:32013'
imageName=jenkins_docker_spring
cd $(dirname $([ -L $0 ] && readlink -f $0 || echo $0))


set -x
docker login docker.aboydfd.com:32013 -u boydfd -p 123456
docker build -t "$dockerRegistry/$imageName" .
docker push "$dockerRegistry/$imageName"
set +x
cd -
