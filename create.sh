#!/usr/bin/env bash

projectname=$1
project=~/projects/$projectname
projecthost=$2
scriptpwd=`pwd`

echo $scriptpwd

cd ~/boinc-master/tools
./make_project --delete_prev_inst --drop_db_first --url_base http://$projecthost --test_app $projectname
cd ~/projects/$projectname
su -c "cat ${projectname}.httpd.conf >> /etc/apache2/httpd.conf"
su -c "apache2ctl -k restart"
crontab ${projectname}.cronjob
cd $scriptpwd

rm -rf "$project/apps"
rm -rf "$project/templates"
rm -f  "$project/project.xml"
rm -f  "$project/config.xml"

cp -r apps templates project.xml "$project"
cat config.xml | sed "s/example/$projectname/g" > "$project/config.xml"
echo "Ready!"
