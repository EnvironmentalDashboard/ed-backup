# pwd will be the project root
. config/uploads.config

echo $ips

for ip in ${ips[@]}
do
  rsync -av root@$ip:/var/www/uploads/CV_Media/ ./CV_Media
done
