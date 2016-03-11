#!/bin/bash

set -eu

ROLE=${1:-server} # or "client"
ROOT_DIR=/opt/consul

mkdir -p ${ROOT_DIR}/{conf,conf.d,data,script,webui}
cp conf/${ROLE}.json ${ROOT_DIR}/conf/
cp script/run-${ROLE}.sh ${ROOT_DIR}/script/

touch /opt/consul/profile

cp systemd/consul-${ROLE}.service /etc/systemd/system/

systemctl enable consul-${ROLE}
systemctl start consul-${ROLE}
