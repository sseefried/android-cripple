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