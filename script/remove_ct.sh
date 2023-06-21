#/bin/bash

pir=101
pen=201

nb=$(echo "$(wc -l /root/penlab/.container/CT/list | cut -d " " -f 1) / 2" | bc)

for (( i=1; i<=$nb; i++ ))
do
  pct shutdown $pir
  pct shutdown $pen

  pct destroy $pir
  pct destroy $pen

  ((pir++))
  ((pen++))
done
