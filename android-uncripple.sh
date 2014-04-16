#!/bin/bash
FILES="/etc/init.d/20fw /etc/init.d/10crond"

KILL_CRON=/system/local/bin/kill-cron

adb root
adb shell mount -o rw,remount /system
adb shell mkdir -p /system/local/bin
adb push $(basename $KILL_CRON) $KILL_CRON
adb shell chmod 700 $KILL_CRON
adb shell $KILL_CRON
echo "[+] Flushing iptables"
adb shell iptables -F

for FILE in $FILES; do
  adb shell rm -f $FILE
done

echo "[+] Enabling Play Store"
adb shell chmod 644 /data/app/com.android.vending*.apk
