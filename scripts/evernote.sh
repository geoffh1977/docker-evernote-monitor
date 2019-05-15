#!/bin/bash

evernoteWatch=$1
evernoteEmail=${SMTP_TO_ADDRESS}
evernoteLog=/tmp/evernote.log
logDate=$(date "+%d-%b-%Y %H:%M:%S")


if ls "$evernoteWatch"/* &> /dev/null
then
  for FILE in $evernoteWatch/*
  do
    evernoteNotebook=$(basename "$(dirname "$FILE")")
    echo -n "[${logDate}] Sending Mail To $evernoteNotebook..." >> $evernoteLog
    if mailx -s "Scanned Document @"'!!'"INBOX #Scanned #$evernoteNotebook" -a "$FILE" $evernoteEmail < /dev/null 2>> $evernoteLog 1>> $evernoteLog
    then
      rm -f "$FILE" > /dev/null
      echo "Send Completed Successfully." >> $evernoteLog
    else
      echo "Send Failed." >> $evernoteLog
    fi
  done
fi
