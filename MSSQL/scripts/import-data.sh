#!/bin/bash

sleep 30s

FILES=/usr/src/sql/*.sql
for f in $FILES
do
	id=$(echo ${f##*/} | cut -d'_' -f 1)
	echo "Processing $f file..."
	# take action on each file. $f store current file name
	echo "Importing File: $f" | tee /usr/src/output/${f##*/}.log
	echo "-------------------------------------------------------" | tee -a /usr/src/output/${f##*/}.log
	if [ "$id" -eq "000" ] ; 
	then
		/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -d master -i $f -y 30 -Y 30 -s \| -w 2000 -e \
		 | tee -a /usr/src/output/${f##*/}.log
	else
		/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -d sem5 -i $f -y 30 -Y 30 -s \| -w 2000 -e \
		 | tee -a /usr/src/output/${f##*/}.log
	fi
done

while true ; do
	sleep 90s
done