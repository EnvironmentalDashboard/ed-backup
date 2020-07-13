. host.config
. config/dbs.config

for ((i = 0; i < ${#ips[@]}; ++i))
do
  ip=${ips[i]}
  port=${ports[i]}
  user=${users[i]}
  pass=${passes[i]}
  current_databases=${databases[i]}

  # An argument that may be needed with a mysqldump upgrade is:
  # --column-statistics=0
  mkdir -p "./public/backup/$ip/dbs"

  for db in $current_databases
  do
    ssh root@$host "mysqldump -h $ip -P $port -u $user --password=$pass --databases $db" > "./public/backup/$ip/dbs/$db-`date +%s`.sql"
  done
done
