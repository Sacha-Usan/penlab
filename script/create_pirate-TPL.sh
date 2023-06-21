#!/bin/bash

pct shutdown 100
pct destroy 100

pct create 100 local:vztmpl/debian-11-standard_11.7-1_amd64.tar.zst --hostname pirate-TPL --password 'Pa$$w0rd' --rootfs local-lvm:2 --cores 1 --net0 name=eth0,bridge=vmbr0,firewall=1,ip=dhcp --unprivileged 1 --features nesting=1 --start 1
pct exec 100 -- bash -c 'sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config && systemctl restart ssh'
pct exec 100 -- bash -c 'mkdir -p /root/.ssh/'

while [[ -z $(lxc-info -n 100 | awk '$0 ~ /^IP/ { print $2 }') ]]
do
  sleep 0.5
done

lxc-info -n 100 | awk '$0 ~ /^IP/ { print $2 }' > /root/penlab/.container/TPL/pirate/ip
( cat /root/penlab/.container/TPL/pirate/ip ; echo ' ansible_user=root' ) | tr -d '\n' > /root/penlab/.ansible/inventory/pirate.cfg
echo -e '\r' >> /root/penlab/.ansible/inventory/pirate.cfg

$(( echo 'sshpass -p Pa$$w0rd ssh-copy-id -o StrictHostKeyChecking=no -i /root/.ssh/ansible.pub root@' ; cat /root/penlab/.container/TPL/pirate/ip ) | tr -d '\n')

ansible-playbook -i /root/penlab/.ansible/inventory/pirate.cfg /root/penlab/.ansible/playbook/pirate.yml --private-key /root/.ssh/ansible

pct shutdown 100
pct template 100
