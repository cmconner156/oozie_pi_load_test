#!/bin/bash

source ./config.sh

LAB=${1?Usage: $0 job}

PROPERTIES_LOCATION=$2
HDFS_LOCATION=$3
RAND_INPUT=$4
MAPS=$5
SAMPLES=$6
PROPERTIES=$PROPERTIES_LOCATION/job\.$RAND_INPUT\.properties
TEMPLATE=$PROPERTIES_LOCATION/job.properties.template

echo "Setting JT_URL and NN_URL in job.properties"
sed "s*JT_URL*$JT_URL*g" $TEMPLATE | sed "s*NN_URL*$NN_URL*g" | sed "s*MAPS*$MAPS*g" | sed "s*SAMPLES*$SAMPLES*g" | sed "s*HDFS_LOCATION*$HDFS_LOCATION*g" | sed "s*RAND_INPUT*$RAND_INPUT*g" > $PROPERTIES

echo "Executing Oozie command"
if [ "$KERBEROS" != "false" ]
then
   OOZIE_COMMAND="oozie job -oozie $OOZIE_URL -config $PROPERTIES -auth KERBEROS -run"
else
   OOZIE_COMMAND="oozie job -oozie $OOZIE_URL -config $PROPERTIES -run"
fi

echo $OOZIE_COMMAND
OOZIE_OUTPUT=`$OOZIE_COMMAND`

export JOBID=`echo $OOZIE_OUTPUT | grep job | awk '{print $2}'`
echo $JOBID > jobid.txt
echo $JOBID
