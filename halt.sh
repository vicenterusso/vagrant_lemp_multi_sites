#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

echo "Backup MySQL"
#Mysql
for d in "/vagrant/db/"*
do
	f=$(basename "$d")
	mysqldump -uroot -p123 "$f" | p7zip > /vagrant/db/"$f"/"$f"_$(date +%Y-%m-%d-%H.%M.%S).sql.7z	
done