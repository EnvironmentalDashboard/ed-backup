. host.config

docker build -t ed-backup . --build-arg HOST=$host --build-arg SSH_KEY="$(cat ~/.ssh/id_rsa)"
