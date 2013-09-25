#!/bin/bash

source ./config.sh

if [ -f jobid.txt ] 
then
   JOBID=`cat jobid.txt`
fi 

if [ "$1" != "" ] 
then
   if [ "$1" != "action" ]
   then
      JOBID=$1
   fi 
fi

if [ "$2" != "" ]
then 
   ACTIONID=$2
   JOBID="${JOBID}@${ACTIONID}"
fi

if [ "$JOBID" == "" ]
then
   echo "Usage ./status <jobid> <optional actionid>"
   exit
fi

if [ "$KERBEROS" != "false" ]
then
   OOZIE_COMMAND="oozie job -oozie $OOZIE_URL -auth KERBEROS -info $JOBID"
else
   OOZIE_COMMAND="oozie job -oozie $OOZIE_URL -info $JOBID"
fi

echo $OOZIE_COMMAND
echo "Status for JOBID: $JOBID"
$OOZIE_COMMAND
