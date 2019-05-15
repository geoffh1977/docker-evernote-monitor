#!/bin/bash

echo "Starting Evernote Monitor..."

cd /opt/evernote/ || exit

while true
do
   for dataDir in $(find /data -maxdepth 1 -type d | grep -wv "^/data$")
   do
     ./evernote.sh "${dataDir}"
   done
  sleep 60
done
