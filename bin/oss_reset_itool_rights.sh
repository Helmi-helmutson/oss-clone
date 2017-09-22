#!/bin/bash
sysadmins_gn=`wbinfo -n sysadmins | awk '{print "wbinfo -S "$1}'| bash`
workstations_gn=`wbinfo -n workstations | awk '{print "wbinfo -S "$1}'| bash`
chmod     755      /srv/itool
chgrp -R $sysadmins_gn /srv/itool
chmod    2755      /srv/itool/config
chmod    2775      /srv/itool/hwinfo
setfacl -m g:$workstations_gn:rwx  /srv/itool/hwinfo
chmod -R 2775      /srv/itool/images
setfacl -m g:$sysadmins_gn:rwx  /srv/itool/images
chmod -R 755       /srv/itool/ROOT
/usr/sbin/oss_setup_pxe_enviroment.sh &> /dev/null
DATE=`date +%Y-%m-%d:%H-%M`
if [ -e /etc/xinetd.d/tftp ]
then
  cp /etc/xinetd.d/tftp /etc/xinetd.d/tftp.$DATE
fi
cp /etc/xinetd.d/tftp.in /etc/xinetd.d/tftp
if [ ! -e /usr/share/oss/templates/pxeboot ]
then
    cp /usr/share/oss/templates/pxeboot.in /usr/share/oss/templates/pxeboot
fi
if [ ! -e /usr/share/oss/templates/eliloboot ]
then
    cp /usr/share/oss/templates/eliloboot.in /usr/share/oss/templates/eliloboot
fi