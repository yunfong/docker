#!/bin/sh
#source ../venv/bin/activate
LOGS=./logs
mkdir -p ${LOGS}
DATE_FORMAT='+%Y-%m-%d_%H:%M:%S'
kill -9 `cat ${LOGS}/app.pid` >/dev/null 2>&1
sleep 2
echo "`date $DATE_FORMAT` Startup Analysis API"|tee -a ${LOGS}/app_console.log
python -u ./app.py $* >> ${LOGS}/app_console.log 2>&1 &
sleep 1
PID=`ps -ef|grep app.py|grep -v grep| awk '{print $2}'`
echo ${PID}>${LOGS}/app.pid
echo "PID: ${PID}"
echo "`date ${DATE_FORMAT}` app started!"
echo '--------------------------------'
echo ''>>${LOGS}/app_run.log
tail -f ${LOGS}/app_run.log
