#!/bin/sh
IFS=$'
'
dn="$1"
for entry in $(dig +short srv $dn | awk '{print $NF}')
do
  ip=$(dig srv +noanswer $dn | grep "$entry" | awk '{print $NF}')
  res="${res}${ip}:$(dig +short srv $dn | grep "$entry" | awk '{print $(NF-1)}'),";
done
[ -z "$res" ] || echo ${res%","}