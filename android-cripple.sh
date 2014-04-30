#!/bin/bash
FILES="/etc/init.d/20fw /etc/init.d/10crond"
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

adb root
adb shell mount -o rw,remount /system
adb shell mkdir -p /data/cron
adb shell mkdir -p /data/tmp
adb shell mkdir -p /system/local/bin

DNS_FOR="/system/local/bin/dns-for"
UFP="/system/local/bin/user-for-package"

echo "[+] Installing dns-for"
adb push "$THIS_DIR/$(basename $DNS_FOR)" $DNS_FOR
adb shell chmod 700 $DNS_FOR

echo "[+] Installing user-for-package"
adb push "$THIS_DIR/$(basename $UFP)" $UFP
adb shell chmod 700 $UFP

echo "[+] Installing crontab"
adb push "$THIS_DIR/root.crontab" /data/cron/root

for FILE in $FILES; do
  echo "[+] Copying $FILE"
  adb push "$THIS_DIR/$(basename $FILE)" $FILE
  adb shell chmod 755  $FILE
  adb shell chgrp shell $FILE # 2000 is "shell"
  echo "[+] Running $FILE"
  adb shell $FILE
done