#!/usr/bin/env bash
sg=$(dmesg | grep scsi | tail -n 1 | sed -n -e 's/^.*CD-ROM //p')
password_file="password.bin"

if [ -f $password_file ]; then
	if [ ! -z "$sg" ]; then
		echo desbloqueando ${sg}...
		sudo sg_raw -s 40 -i "$password_file" /dev/${sg} c1 e1 00 00 00 00 00 00 28 00
		sudo partprobe
	else
		echo "there is no WD-MyPassport drive detected..."
	fi
else
	echo "there is no $password_file"
fi
