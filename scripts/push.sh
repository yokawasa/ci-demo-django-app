#!/usr/bin/env bash
set -x -e

cwd=`dirname "$0"`
expr "$0" : "/.*" > /dev/null || cwd=`(cd "$cwd" && pwd)`

if [ $# -ne 2 ]
then
    echo "$0 [dockerhub account] [dockerhub password]"
    exit
fi
echo "username=$1"
echo "docker account passwd=$2"

docker login -u "$1" -p "$2"
version=`cat $cwd/../VERSION`
tag="$version"
echo "tag=$tag"
docker tag django-app:$tag yoichikawasaki/django-app:$tag
docker push "$1"/django-app:$tag
docker logout
