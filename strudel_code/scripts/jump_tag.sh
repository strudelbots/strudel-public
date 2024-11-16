#!/bin/bash
echo "jump tag"
if [ -z "$1" ]; then
  echo "No parameter provided!"
  exit 1
fi
echo "tag is $1:"
#git log -1 $1

git push -d origin $1
git tag -d $1
#echo "new tag details:"
git tag $1
git push --tags origin
#git log -1 $1


