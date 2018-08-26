#!/usr/bin/env bash

script_directory=`dirname $(echo $0)`
fcgi_script="${script_directory}/fcgi_client.py"

if [[ $# -lt 2 ]]; then
  echo usage $0: URL HOST PORT [SOCKET]
  exit 0
fi

url=$1
host=$2
port=$3
socket=$4

echo "'$1' '$2' '$3' '$4'"

if [[ ! -x ${fcgi_script} ]]; then
  echo 'unable to find fast cgi client script' 1>&2
  exit 1
fi

if [[ -z $url ]]; then
  echo 'url is mandatory' 1>&2
  exit 1
else
  url="${url}?json&full"
fi

if [[ -n $socket ]]; then
  host_options="--socket ${socket}"
elif [[ -n ${host} && -n ${port} ]]; then
  host_options="--host ${host} --port ${port}"
else
  echo 'you must provide socket or host/port configuration' 1>&2
  exit 1
fi

${fcgi_script} --url "${url}" $host_options
