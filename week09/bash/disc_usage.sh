#!/bin/bash
THRESHOLD=80
USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

if [ "$USAGE" -gt "$THRESHOLD" ]; then
  echo "Alert: Disk usage is above ${THRESHOLD}% — Current: ${USAGE}%"
else
  echo "Disk usage is normal — Current: ${USAGE}%"
fi