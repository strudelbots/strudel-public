#!/bin/bash
set -x #echo on
echo "jump tag"
branch=$(git rev-parse --abbrev-ref HEAD)
echo "branch is: $branch"
if [ -z "$1" ]; then
  echo "No parameter provided!"
  exit 1
fi
if [ -z "$2" ]; then
  echo "No second parameter provided!"
  exit 1
fi
old_tag=$1
new_tag=$2
branch=$(git rev-parse --abbrev-ref HEAD)
echo "old tag is: $old_tag"
echo "new tag is: $new_tag"
cd ../.github/workflows
pwd
find . -name "*.yml" -exec sed -i s/$old_tag/$new_tag/g {} \;
git commit -am "Update tags in workflows" -m "$new_tag"
git tag $new_tag
git push --atomic origin  $branch $new_tag

