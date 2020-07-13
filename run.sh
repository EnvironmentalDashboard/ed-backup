# Bind-mount public/backups on production.
docker run -dit -p 3016:4567 --restart unless-stopped -v $(pwd)/server.rb:/usr/src/app/server.rb -v $(pwd)/Gemfile:/usr/src/app/Gemfile -v $(pwd)/Gemfile.lock:/usr/src/app/Gemfile.lock -v $(pwd)/tree.rb:/usr/src/app/tree.rb -v $(pwd)/views:/usr/src/app/views -v $(pwd)/scripts:/usr/src/app/scripts -v $(pwd)/public/js:/usr/src/app/public/js -v $(pwd)/config:/usr/src/app/config -v $(pwd)/host.config:/usr/src/app/host.config --name ed-backup ed-backup
