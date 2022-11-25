#!/bin/bash

echo "Environment variables list"
echo $GKE
echo $NODEPOOLNAME
echo $ZONE
echo $PROJECT

# Disable autoscaling
gcloud container clusters update $GKE \
    --no-enable-autoscaling \
    --node-pool=$NODEPOOLNAME \
    --zone=$ZONE \
    --project=$PROJECT

# Print script results
RESULT=$?
if [ $RESULT -eq 0 ]; then
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
if [ $RESULT -eq 0 ]; then
echo "--------------Scaling GKE nodepool to 0 finished sucesfully---------------"
else
  echo "Scaling GKE nodepool to 0 finished with error: $RESULT"
  exit 1
fi