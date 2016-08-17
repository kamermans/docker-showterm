#!/bin/sh -e

if [ "$DB_INIT" != "false" ] && [ ! -f /data/showterm.sqlite3 ]; then
    echo "Creating the showterm database"
    bundle exec rake db:create db:migrate db:seed
fi

echo "Starting showterm"
exec rails s
