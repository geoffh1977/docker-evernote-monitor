#!/bin/bash

# Write Out Config File
cat << EOF > "/${HOME}/.mailrc"

set smtp-use-starttls
set nss-config-dir=/opt/evernote/certs
set ssl-verify=ignore
set smtp=smtp://${SMTP_EMAIL}:${SMTP_PORT}
set smtp-auth=login
set smtp-auth-user=${SMTP_AUTH_USER}
set smtp-auth-password=${SMTP_AUTH_PASSWORD}
set from="${SMTP_FROM_ADDRESS}"

EOF

# Create Empty Log FIle
touch /tmp/evernote.log

# Start Monitor
/opt/evernote/evernote_monitor.sh &

# Tail Output
tail -f /tmp/evernote.log
