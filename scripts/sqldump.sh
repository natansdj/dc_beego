#!/bin/bash
PASSWORD=pwddc123!@#
HOST=127.0.0.1
PORT=6033
USER=dbproduser
DATABASE=ddcprod01
DB_FILE=ddcprod01.sql.gz
EXCLUDED_TABLES=(
stock_opnames
shippings
log_activities
ddc_app_log
v2_orders
branch_distances
change_order_statuses   
)

IGNORED_TABLES_STRING=''
for TABLE in "${EXCLUDED_TABLES[@]}"
do :
   IGNORED_TABLES_STRING+=" --ignore-table=${DATABASE}.${TABLE}"
done

echo "Dump structure"
echo "mysqldump -h ${HOST} -u ${USER} -p -P${PORT} --single-transaction --no-data --routines ${DATABASE} | gzip > ${DB_FILE}"

echo "Dump content"
echo "mysqldump --no-create-db=true -h ${HOST} -u ${USER} -p -P${PORT} --no-create-info --skip-triggers ${IGNORED_TABLES_STRING} ${DATABASE} | gzip >> ${DB_FILE}"
