#!/bin/bash

apt -y update && apt -y upgrade
apt install -y ansible sshpass

mkdir -p /root/penlab/.container/CT/ \
/root/penlab/.container/TPL/pirate/ \
/root/penlab/.container/TPL/pentester/ \
/root/penlab/.ansible/inventory/ \
/root/penlab/.ansible/playbook/

ssh-keygen -q -t rsa -b 1024 -f /root/.ssh/ansible -N ''
