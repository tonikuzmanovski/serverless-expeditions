#!/bin/bash

if [ -z $STOP ]
then
  echo "Environment variable STOP is empty; Setting default value to true"
  STOP="true"
  echo $STOP
else
  echo "Environment variable STOP is set and it has value:"
  echo $STOP
fi

if [ $STOP = "true" ]
then
  # Disable autoscaling
  gcloud container clusters update $GKE \
      --no-enable-autoscaling \
      --node-pool=$NODEPOOLNAME \
      --zone=$ZONE \
      --project=$PROJECT

  # Print script results
  RESULT=$?
  if [ $RESULT -eq 0 ]
  then
    echo "--------------Disabling GKE autoscaling finished sucesfully---------------"
  else
    echo "Disabling GKE autoscaling finished with error: $RESULT"
    exit 1
  fi

  # Resize nodepool to 0
  gcloud container clusters resize -q $GKE \
      --node-pool $NODEPOOLNAME \
      --num-nodes 0 --zone=$ZONE \
      --project=$PROJECT

  # Print script results
  if [ $RESULT -eq 0 ]
  then
    echo "--------------Scaling GKE nodepool to 0 finished sucesfully---------------"
  else
    echo "Scaling GKE nodepool to 0 finished with error: $RESULT"
    exit 1
  fi
elif [ $STOP = "false" ]
then
  # Enable autoscaling
  gcloud container clusters update $GKE \
      --enable-autoscaling \
      --min-nodes 0 \
      --max-nodes 4 \
      --zone=$ZONE \
      --project=$PROJECT
      
  # Print script results
  RESULT=$?
  if [ $RESULT -eq 0 ]
  then
    echo "--------------Disabling GKE autoscaling finished sucesfully---------------"
  else
    echo "Disabling GKE autoscaling finished with error: $RESULT"
    exit 1
  fi
fi
