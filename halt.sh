#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

echo "Backup MySQL"
#Mysql
for d in "/vagrant/db/"*
do
	f=$(basename "$d")
	mysqldump -uroot "$f" | gzip > /vagrant/db/"$f"/"$f"_$(date +%Y-%m-%d-%H.%M.%S).sql.gz	
done