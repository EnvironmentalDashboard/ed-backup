# ed-backup
A Docker container that can spawn a backup server that will backup all of our necessary ED server files

https://github.com/gimite/google-drive-ruby

## Building

You must specify a host that will be backed up by this machine.
For this, make a `host.config` file modeling the sample.
This server will only be given access to the host, and the host will then
be used for accessing other servers that may be being backed up.
