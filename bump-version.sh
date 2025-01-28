#!/usr/bin/env bash

set -ex

version=$1
git branch -D  prep_release/$version || true
git checkout -b prep_release/$version || git checkout prep_release/$version || true
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
cat action.yml

sed -i "s/\(sh -s -- -t valint\) -D$/\1:$version/" action.yml

echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<"
cat action.yml


git add action.yml || true
git commit -m "bump version" || true
git fetch origin master

#echo "##########################"
#cat action.yml

git merge --no-edit -s ours origin/master || true
git push -f origin prep_release/$version || true
