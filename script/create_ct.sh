#/bin/bash

# Crée un fichier vide ou le vide si il est déjà créé
: > /root/penlab/.container/CT/name
: > /root/penlab/.container/CT/ip

pir=101
pen=201

for (( i=1; i<=$1; i++ ))
do
  pct clone 100 $pir --hostname pirate-${pir:1:2}
  pct clone 200 $pen --hostname pentester-${pen:1:2}

  pct start $pir
  pct start $pen

  echo "pirate-${pir:1:2}" >> /root/penlab/.container/CT/name
  echo "pentester-${pen:1:2}" >> /root/penlab/.container/CT/name

  while [[ -z $(lxc-info -n $pir | awk '$0 ~ /^IP/ { print $2 }') ]] || [[ -z $(lxc-info -n $pen | awk '$0 ~ /^IP/ { print $2 }') ]]
  do
    sleep 0.5
  done

  lxc-info -n $pir | awk '$0 ~ /^IP/ { print $2 }' >> /root/penlab/.container/CT/ip
  lxc-info -n $pen | awk '$0 ~ /^IP/ { print $2 }' >> /root/penlab/.container/CT/ip

  pct exec $pen -- bash -c "iptables -A INPUT -s $(lxc-info -n $pir | awk '$0 ~ /^IP/ { print $2 }') -p ICMP -j ACCEPT"
  pct exec $pen -- bash -c 'iptables -A INPUT -p ICMP -j DROP'

  ((pir++))
  ((pen++))
done

paste /root/penlab/.container/CT/name /root/penlab/.container/CT/ip | tee /root/penlab/.container/CT/list
