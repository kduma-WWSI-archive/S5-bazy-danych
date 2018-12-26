#!/bin/bash

php /usr/src/data/Sources/BuildTool/build /usr/src/data/Sources/SQL /usr/src/data/skrypt_tworzacy_obiekty_w_bazie_danych.sql  /usr/src/data/skrypt_usuwajacy_obiekty_z_bazy.sql


sleep 30s

/opt/mssql-tools/bin/sqlcmd \
	-S localhost \
	-U sa \
	-P "$SA_PASSWORD" \
	-d master \
	-i /usr/src/scripts/create_database.sql \
	-y 30 \
	-Y 30 \
	-s \| \
	-w 2000 \
	-e \
	| tee -a /usr/src/output/create_database.sql.log

/opt/mssql-tools/bin/sqlcmd \
	-S localhost \
	-U sa \
	-P "$SA_PASSWORD" \
	-d projekt \
	-i /usr/src/data/skrypt_tworzacy_obiekty_w_bazie_danych.sql \
	-y 30 \
	-Y 30 \
	-s \| \
	-w 2000 \
	-e \
	| tee -a /usr/src/output/skrypt_tworzacy_obiekty_w_bazie_danych.sql.log

/opt/mssql-tools/bin/sqlcmd \
	-S localhost \
	-U sa \
	-P "$SA_PASSWORD" \
	-d projekt \
	-i /usr/src/data/skrypt_usuwajacy_obiekty_z_bazy.sql \
	-y 30 \
	-Y 30 \
	-s \| \
	-w 2000 \
	-e \
	| tee -a /usr/src/output/skrypt_usuwajacy_obiekty_z_bazy.sql.log

/opt/mssql-tools/bin/sqlcmd \
	-S localhost \
	-U sa \
	-P "$SA_PASSWORD" \
	-d projekt \
	-i /usr/src/data/skrypt_tworzacy_obiekty_w_bazie_danych.sql \
	-y 30 \
	-Y 30 \
	-s \| \
	-w 2000 \
	-e \
	| tee -a /usr/src/output/skrypt_tworzacy_obiekty_w_bazie_danych.sql-second.log

#FILES=/usr/src/sql/*.sql
#for f in $FILES
#do
#	id=$(echo ${f##*/} | cut -d'_' -f 1)
#	echo "Processing $f file..."
#	# take action on each file. $f store current file name
#	echo "Importing File: $f" | tee /usr/src/output/${f##*/}.log
#	echo "-------------------------------------------------------" | tee -a /usr/src/output/${f##*/}.log
#	if [ "$id" -eq "000" ] ; 
#	then
#		/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -d master -i $f -y 30 -Y 30 -s \| -w 2000 -e \
#		 | tee -a /usr/src/output/${f##*/}.log
#	else
#		/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -d sem5 -i $f -y 30 -Y 30 -s \| -w 2000 -e \
#		 | tee -a /usr/src/output/${f##*/}.log
#	fi
#done

while true ; do
	sleep 90s
done