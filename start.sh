#!/bin/bash

# Start RethinkDB
rethinkdb --directory db &

# Setup the database
npm run setup_db &

# Start the application
node . &

# Start Apache in the foreground
/usr/sbin/apache2ctl -D FOREGROUND 