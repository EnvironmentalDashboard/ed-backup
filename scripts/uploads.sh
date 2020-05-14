# pwd will be the project root
. host.config
. config/uploads.config

# For each upload IP, we will backup its CV_Media through our host.
# This way, we only have to make sure that our host has the necessary keys.
for ip in ${ips[@]}
do
  # https://stackoverflow.com/a/21787966/2397924
  # I wonder if a persistent tunnel may be more efficient?
  # Research for later.
  mkdir -p "./$ip/CV_Media"
  rsync -av -e "ssh -A root@$host ssh" root@$ip:/var/www/uploads/CV_Media/ "./$ip/CV_Media"
done
