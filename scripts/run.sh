#!/bin/sh

cwd=`dirname "$0"`
expr "$0" : "/.*" > /dev/null || cwd=`(cd "$cwd" && pwd)`

version=`cat $cwd/../VERSION`
tag="$version"
echo "tag=$tag"

echo "Running the container..."
docker run -d -p 8080:8080 django-app:$tag

echo "Accessing localhost..."
curl localhost:8080
