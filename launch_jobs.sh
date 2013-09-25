#!/bin/bash

#- To setup, edit the following variables appopriately.
#  - HDFS_BASE: Set to match the location that you put pi_load_test.  Note that HDFS_BASE should not contain the words "pi_load_test".
#  - LAUNCH_HOME: Set to the location where you extracted this archive.
#  - MAPS: To the number of Pi maps you want to run.
#  - SAMPLES: To the number of Pi saamples you want to run.
#  - SLEEP_TIME: To the number of seconds to wait between spawning each workflow.
#  - TOTAL_JOBS: To the number of workflows you want to spawn total.

LAUNCH_HOME=/home/cconner/oozie_load_test
HDFS_BASE="/user/cconner"
MAPS="4"
SAMPLES="1000"
SLEEP_TIME="2"
TOTAL_JOBS="5"

LAUNCH_SCRIPT=$LAUNCH_HOME/run.sh
WORKFLOW_NAME="pi_load_test"
PROPERTIES_LOCATION="$LAUNCH_HOME/$WORKFLOW_NAME/job"
HDFS_LOCATION="$HDFS_BASE/$WORKFLOW_NAME"

for ((x=1;x<=$TOTAL_JOBS;x++))
do

   RAND_INPUT=$(( ( RANDOM % 99999999 )  + 1 ))
   $LAUNCH_SCRIPT $WORKFLOW_NAME $PROPERTIES_LOCATION $HDFS_LOCATION $RAND_INPUT $MAPS $SAMPLES
   echo "Launched Job:"
   cat jobid.txt
   echo "Sleeping $SLEEP_TIME"
   echo ""
   sleep $SLEEP_TIME 

done
