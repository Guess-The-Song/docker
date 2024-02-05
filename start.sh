#!/bin/bash

# Start RethinkDB
rethinkdb --directory db --bind all &
sleep 5
# Setup the database
npm run setup_db &
sleep 5
# Start the application
node . &
sleep 5
# Start Apache in the foreground
/usr/sbin/apache2ctl -D FOREGROUND 