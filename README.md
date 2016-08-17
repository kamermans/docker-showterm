# kamermans/showterm

This Docker image allows you to run a private instance of http://showterm.io/.

> Note: I am not the showterm developer, nor am I associated with Conrad Irwin, the developer.

## Running the showterm server
This is all it takes to get a showterm server up and running:
```
docker run -d \
    --name showterm \
    -v /opt/showterm_db:/data \
    -p3000:3000 \
    kamermans/showterm
```

### Showterm database
The data for showterm is stored in a SQLite3 database called `showterm.sqlite3` in `/data` inside the container.  In order to make this data persist across showterm restarts, the command above creates `/opt/showterm_db` on your local machine and mounts it to the container's `/data`.

If you want to use a different database (PostgreSQL is used on showterm.io), you must create a new `database.yml` config file and mount it into `/opt/showterm/config/database.yml`.  You should also start the container with `-e DB_INIT=false` to prevent the init system from seeding the stock SQLite DB.

## Configuring the showterm client
First, install the showterm client via the instructions on http://showterm.io/.

Next, you need to set the `SHOWTERM_SERVER` environment variable to the URL of your server:

```
export SHOWTERM_SERVER="http://myserver:3000/"
```

> Warning: If this step is skipped, your terminal will be copied to showterm.io and will be accessible on the public internet.

In order make showterm use your private server for all users on your system, you can add the variable to `/etc/environment` (at least on GNU/Linux):
```
echo 'SHOWTERM_SERVER="http://myserver:3000/"' | sudo tee -a /etc/environment > /dev/null
```

> Note: You will need to close your session and log back in before this change will affect you.

