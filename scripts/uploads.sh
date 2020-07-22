# pwd will be the project root
. config/uploads.config

for ip in ${ips[@]}
do
  mkdir -p "./public/backup/$ip/CV_Media"
  rsync -av root@$ip:/var/www/uploads/CV_Media/ "./public/backup/$ip/CV_Media"
done
