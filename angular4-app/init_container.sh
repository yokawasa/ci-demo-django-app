#!/usr/bin/env bash
service ssh start

touch /home/LogFiles/node_${WEBSITE_ROLE_INSTANCE_ID}_out.log
echo "$(date) Container started" >> /home/LogFiles/node_${WEBSITE_ROLE_INSTANCE_ID}_out.log

STARTUPCOMMAND="npm start"
echo "Running $STARTUPCOMMAND"
eval "exec $STARTUPCOMMAND"
