# Android Cripple

## Introduction

Android Cripple is a script that allows me to cripple my Android
based phone so that only certain applications have data access, while the
others are denied. In essence it turns it into a dumb phone with a few
useful apps enabled such as Google Maps, Calendars, MMS, etc.

## Dependencies

You must have ```adb``` installed

## Usage

To cripple:

```
$ ./android-cripple.sh
```

To uncripple:

```
$ ./android-uncripple.sh
```

## Adding new IP address or Apps to whitelist

Edit the file ```20fw```. (The "fw" stands for Firewall). 

I'd suggest connecting your phone, opening up the applications you want to whitelist and then running:

```
$ ps | grep u0
```

This should list something like:

```
u0_a40    2655  1899  514920 34280 ffffffff 400f5574 S com.android.systemui
u0_a94    2786  1899  523932 52100 ffffffff 400f5574 S com.nuance.swype.dtc
u0_a50    2796  1899  522680 23548 ffffffff 400f5574 S com.google.process.location
u0_a13    2822  1899  481124 14748 ffffffff 400f5574 S com.bel.android.dspmanager
u0_a44    2872  1899  578096 48824 ffffffff 400f5574 S com.cyanogenmod.trebuchet
u0_a50    2887  1899  526072 24480 ffffffff 400f5574 S com.google.process.gapps
u0_a49    2987  1899  481396 15768 ffffffff 400f5574 S com.android.smspush
u0_a94    3093  1899  496292 25964 ffffffff 400f5574 S com.nuance.swype.dtc:SwypeConnect
u0_a137   4153  1899  552800 35660 ffffffff 400f5574 S com.viber.voip
u0_a132   4221  1899  517528 24588 ffffffff 400f5574 S com.whatsapp
```

Then have a look for a package identifier that looks something like what you want to whitelist.
e.g. com.whatsapp is WhatsApp.

## Notes taken during development

### Remounting read-write so you can push the file

mount -o rw,remount /system

### A note on packages and user IDs

The following information I got from
http://www.all-things-android.com/content/deeper-look-android-application-permissions

------------

```
adb shell ls -l acct/uid | less

drwxrwxr-x root     root              2013-08-22 17:17 0
drwx------ root     system            2013-08-22 17:17 1000
drwx------ root     u0_a0             2013-08-22 17:18 10000
drwx------ root     u0_a1             2013-08-22 17:17 10001
drwx------ root     u0_a2             2013-08-22 17:17 10002
```

...

As the above listing shows, root is the only user account, and everything else
is a group account. The group account numbering scheme is as follows:

   * Group account 0 is root, which is standard.
   * Group accounts in the 1000 series are hard coded.
   * Group accounts in the  10000 series are installed applications. The group
     account number is dynamically generated at the time of application
      installation.
   * You can see what group account number is associated with a package by
     looking at /data/system/packages.list

------------
