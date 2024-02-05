#!/bin/bash

# Start Apache in the foreground
/usr/sbin/apache2ctl -D FOREGROUND &

# Start RethinkDB
rethinkdb --directory db &

# Setup the database
npm run setup_db &

# Start the application
node . &