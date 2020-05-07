docker run -dit -p 3016:4567 --restart unless-stopped -v $(pwd):/usr/src/app --name ed-backup ed-backup
