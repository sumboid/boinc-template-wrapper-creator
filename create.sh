#!/usr/bin/env bash

project=$1
projectname=$2

rm -rf "$project/apps"
rm -rf "$project/templates"
rm -f  "$project/project.xml"
rm -f  "$project/config.xml"

cp -r apps templates project.xml "$project"
cat config.xml | sed "s/example/$projectname/g" > "$project/config.xml"
echo "Ready!"
