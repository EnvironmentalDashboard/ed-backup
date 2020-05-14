. host.config
. config/dbs.config

for ((i = 0; i < ${#ips[@]}; ++i))
do
  ip=${ips[i]}
  port=${ports[i]}
  user=${users[i]}
  pass=${passes[i]}

  # An argument that may be needed with a mysqldump upgrade is:
  # --column-statistics=0
  mkdir -p "./$ip/dbs"

  for db in ${databases[@]}
  do
    ssh root@$host "mysqldump -h $ip -P $port -u $user --password=$pass --databases $db" > "./$ip/dbs/$db.sql"
  done
done
