if [ -d "/cloudpatrol/tmp/pids/" ]; then
  export pid=`cat /cloudpatrol/tmp/pids/server.pid`
  kill -9 $pid
fi