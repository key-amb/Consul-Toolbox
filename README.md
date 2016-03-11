# Consul-Toolbox

Configuration files and scripts and etc. for [consul.io](https://www.consul.io/).

## Contents

- [conf](conf/) ... Config JSON to be specified on agent's start-up.
- [script](script/) ... Scripts to start agent and bootstrap.
- [systemd](systemd/) ... Systemd unit files.

## Install

Below will set up for systemd environments.

```
wget https://releases.hashicorp.com/consul/0.6.3/consul_0.6.3_linux_amd64.zip
unzip consul_0.6.3_linux_amd64.zip
mv consul /usr/local/bin/

git clone https://github.com/key-amb/Consul-Toolbox.git
script/bootstrap.sh [client]
```
