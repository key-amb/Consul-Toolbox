#!/bin/sh
exec 2>&1

### common preparation
run_file=$(readlink -f $0)
run_dir=${run_file%/*}
base_dir="${run_dir}/.."
consul_dir=/opt/consul

### daemon
daemon=/usr/local/bin/consul
consul_port=8300
config_file="${consul_dir}/conf/server.json"
config_dir="${consul_dir}/conf.d"
env_dir="${consul_dir}/env"

if [ ! -x "$daemon" ]; then
  echo "not executable: $daemon"
  exit 1
fi

. /opt/consul/profile

join_as_server() {
  echo 'Start and join existing cluster.'
  exec \
    $daemon agent \
      -config-file $config_file \
      -config-dir $config_dir \
      -join $CONSUL_SERVER
}

bootstrap() {
  echo 'Bootstrap and initialize cluster.'
  exec \
    $daemon agent \
      -config-file $config_file \
      -config-dir $config_dir
}

# open files
ulimit -n 32768
# disable OOM killing
echo -17 > /proc/$$/oom_adj

nmap -p $consul_port $CONSUL_SERVER | grep open > /dev/null
if [[ $? != 0 ]]; then
  bootstrap
else
  join_as_server
fi
