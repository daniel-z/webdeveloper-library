#!/bin/bash
# an improvement of code from here:
# http://blog.knuthaugen.no/2012/09/headless-tests-with-buster-and-phantom/

function get_buster_server_pid(){
    echo `ps aux|grep buster-server|grep node|awk '{ print $2 }'`
}

function get_phantom_server_pid(){
    echo `ps aux|grep [p]hantomjs|head -1|awk '{ print $2 }'`
}

if [ "$1" == "start" ] ; then
  echo "starting server:";
  echo "starting buster-server and phantom browser...";
  buster-server &
  sleep 2
  phantomjs phantom.js &
  echo "running :)";
elif [ "$1" == "stop" ] ; then
  buster_pid=`get_buster_server_pid` ;
  phanthom_pid=`get_phantom_server_pid` ;

  if [ "$buster_pid" != "" ] ; then
    kill $buster_pid;
    echo "buster-server stoped. PIDs: $buster_pid"
  else
    echo "buster-server not found running"
  fi

  if [ "$phanthom_pid" != "" ] ; then
    kill $phanthom_pid;
    echo "phanthom browser PIDs: $phanthom_pid"
  else
    echo "phanthom browser not found running"
  fi
  
else
    echo "usage: ./test-server.sh [stop | start]";
fi