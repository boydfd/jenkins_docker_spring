#!/usr/bin/env sh

dockerRegistry='192.168.42.10:5000'
imageName=jenkins_docker_spring
cd $(dirname $([ -L $0 ] && readlink -f $0 || echo $0))


set -x
docker build -t "$dockerRegistry/$imageName" .
docker push "$dockerRegistry/$imageName"
set +x
cd -
