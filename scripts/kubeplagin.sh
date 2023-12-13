#!/bin/bash

# Define command-line arguments
NAMESPACE=$1
RESOURCE_TYPE=$2

# Check if arguments are provided
if [ -z "$NAMESPACE" ] || [ -z "$RESOURCE_TYPE" ]; then
  echo "Usage: $0 <namespace> <resource_type>"
  exit 1
fi

# Retrieve resource usage statistics from Kubernetes
kubectl top $RESOURCE_TYPE -n $NAMESPACE | tail -n +2 | while read -r line; do
  # Extract CPU and memory usage from the output
  NAME=$(echo "$line" | awk '{print $1}')
  CPU=$(echo "$line" | awk '{print $2}')
  MEMORY=$(echo "$line" | awk '{print $3}')

  # Output the statistics to the console
  echo "$RESOURCE_TYPE, $NAMESPACE, $NAME, $CPU, $MEMORY"
done