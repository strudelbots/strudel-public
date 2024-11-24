#!/bin/bash
echo "jump tag"
branch=$(git rev-parse --abbrev-ref HEAD)
echo "branch is: $branch"
if [ -z "$1" ]; then
  echo "No parameter provided!"
  exit 1
fi
echo "tag is $1:"

#git push origin $branch 

git push -d origin $1
git tag -d $1
git tag $1
git push --tags origin $branch


