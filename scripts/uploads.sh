# pwd will be the project root
. host.config
. config/uploads.config

# For each upload IP, we will backup its CV_Media through our host.
# This way, we only have to make sure that our host has the necessary keys.
for ip in ${ips[@]}
do
  mkdir "./$host"
  rsync -av -e "ssh -A root@$host ssh" root@$ip:/var/www/uploads/CV_Media/ "./$host/CV_Media"
done
