#!/bin/bash

echo "Environment variables list"
echo $GKE
echo $NODEPOOLNAME
echo $ZONE
echo $PROJECT

# Enable autoscaling
gcloud container clusters update $GKE \
    --enable-autoscaling \
    --min-nodes 0 \
    --max-nodes 4 \
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
