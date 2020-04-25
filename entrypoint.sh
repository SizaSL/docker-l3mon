#!/bin/bash
set -e

# if [ ! -f "$FILE"]; 
#    cd /\
# 	&& wget -c https://github.com/D3VL/L3MON/releases/download/1.1.0/L3MON-v1.1.0.zip \
# 	&& unzip -o L3MON-v1.1.0.zip -d $FOLDER
# 	cd $FOLDER && npm install
# 

cd ${L3MON_HOME} && npm install
cd ${L3MON_HOME} && pm2 start --no-daemon index.js && pm2 startup && pm2 stop index

echo "Updating user name and password."
python ${SCRIPT_PATH}/update_user_pass.py -f ${L3MON_HOME}/maindb.json -u "${L3MON_USER}" -p "${L3MON_PASS}"
echo "Restarting L3MON server..."
cd ${L3MON_HOME} && pm2 restart all

