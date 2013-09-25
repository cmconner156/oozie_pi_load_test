#!/bin/bash

OOZIE_URL="http://`hostname`:11000/oozie"
JT_URL=`grep -A1 "mapred.job.tracker<\/name>" /etc/hadoop/conf/mapred-site.xml | tail -1 | awk -F\> '{print $2}' | awk -F\< '{print $1}'`
NN_URL=`grep -A1 fs.defaultFS /etc/hadoop/conf/core-site.xml | tail -1 | awk -F\> '{print $2}' | awk -F\< '{print $1}'`
SECURITY=`grep -A1 hadoop.security.authentication /etc/hadoop/conf/core-site.xml | tail -1 | awk -F\> '{print $2}' | awk -F\< '{print $1}'`
KERBEROS="false"
if [ "$SECURITY" = "kerberos" ]
then
   KERBEROS="true"
fi
