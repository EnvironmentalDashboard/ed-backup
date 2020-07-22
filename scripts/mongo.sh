. host.config
. config/mongo.config

for ((i = 0; i < ${#uris[@]}; ++i))
do
  uri=${uris[i]}

  # Could get the IP from the URI, but not worth the trouble.
  name=${names[i]}

  mkdir -p "./public/backup/$name/mongo"
  ssh root@$host "mongodump --uri=$uri --gzip --archive" > "./public/backup/$name/mongo/`date +%s`.gz"
done
