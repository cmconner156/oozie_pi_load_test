#!/bin/bash
#To use, specify the status you are interested in.  For example "./jobs_list.sh RUNNING"

source ./config.sh

FILTER="$1"

if [ "$FILTER" != "" ]
then
   FILTER="-filter status=$FILTER"
fi

if [ "$KERBEROS" != "false" ]
then
   OOZIE_COMMAND="oozie jobs -oozie $OOZIE_URL -auth KERBEROS $FILTER"
else
   OOZIE_COMMAND="oozie job -oozie $OOZIE_URL $FILTER"
fi

echo $OOZIE_COMMAND
echo "Running Jobs:"
$OOZIE_COMMAND
