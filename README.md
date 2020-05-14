# ed-backup
A Docker container that can spawn a backup server that will backup all of our necessary ED server files

https://github.com/gimite/google-drive-ruby

## Building

You must specify a host---this is the computer that will be used to retrieve data from servers.
Each data retrieval command will SSH into host before making the data grab.
For this, make a `host.config` file modeling the sample.
This server will only be given access to the host, and the host will then
be used for accessing other servers that may be being backed up.
