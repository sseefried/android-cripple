#!/bin/bash
FILES="/etc/init.d/20fw /etc/init.d/10crond"

adb root
adb shell mount -o rw,remount /system
adb shell mkdir -p /data/cron
adb shell mkdir -p /data/tmp
adb shell mkdir -p /system/local/bin

DNS_FOR="/system/local/bin/dns-for"
echo "[+] Installing dns-for"
adb push $(basename $DNS_FOR) $DNS_FOR
adb shell chmod 700 $DNS_FOR
echo "[+] Installing crontab"
adb push root.crontab /data/cron/root

for FILE in $FILES; do
  echo "Copying $FILE"
  adb push $(basename $FILE) $FILE
  adb shell chmod 755  $FILE
  adb shell chgrp shell $FILE # 2000 is "shell"
  adb shell $FILE
done