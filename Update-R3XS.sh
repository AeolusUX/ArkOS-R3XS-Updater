#!/bin/bash
clear
UPDATE_DATE="02062024"
LOG_FILE="/home/ark/update$UPDATE_DATE.log"
UPDATE_DONE="/home/ark/.config/.update$UPDATE_DATE"

if [ -f "$UPDATE_DONE" ]; then
	msgbox "No more updates available.  Check back later."
	rm -- "$0"
	exit 187
fi

if [ -f "$LOG_FILE" ]; then
	sudo rm "$LOG_FILE"
fi

LOCATION="https://raw.githubusercontent.com/AeolusUX/ArkOS-R3XS-Updater/main"
ISITCHINA="$(curl -s --connect-timeout 30 -m 60 http://demo.ip-api.com/json | grep -Po '"country":.*?[^\\]"')"

if [ "$ISITCHINA" = "\"country\":\"China\"" ]; then
  printf "\n\nSwitching to China server for updates.\n\n" | tee -a "$LOG_FILE"
  LOCATION="https://raw.githubusercontent.com/AeolusUX/ArkOS-R3XS-Updater/main"
fi

sudo msgbox "ONCE YOU PROCEED WITH THIS UPDATE SCRIPT, DO NOT STOP THIS SCRIPT UNTIL IT IS COMPLETED OR THIS DISTRIBUTION MAY BE LEFT IN A STATE OF UNUSABILITY.  Make sure you've created a backup of this sd card as a precaution in case something goes very wrong with this process.  You've been warned!  Type OK in the next screen to proceed."
my_var=`osk "Enter OK here to proceed." | tail -n 1`

echo "$my_var" | tee -a "$LOG_FILE"

if [ "$my_var" != "OK" ] && [ "$my_var" != "ok" ]; then
  sudo msgbox "You didn't type OK.  This script will exit now and no changes have been made from this process."
  printf "You didn't type OK.  This script will exit now and no changes have been made from this process." | tee -a "$LOG_FILE"
  exit 187
fi

c_brightness="$(cat /sys/devices/platform/backlight/backlight/backlight/brightness)"
sudo chmod 666 /dev/tty1
echo 255 > /sys/devices/platform/backlight/backlight/backlight/brightness
touch $LOG_FILE
tail -f $LOG_FILE >> /dev/tty1 &

if [ ! -f "/home/ark/.config/.update01272024-1" ]; then

	printf "\nFix Switch to SD2 script for RG351V and RG351MP units\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/01272024-1/arkosupdate01272024-1.zip -O /dev/shm/arkosupdate01272024-1.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate01272024-1.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate01272024-1.zip" ]; then
	  sudo unzip -X -o /dev/shm/arkosupdate01272024-1.zip -d / | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate* | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi

	if [ -f "/opt/system/Advanced/Switch to SD2 for Roms.sh" ]; then
	  cp -fv /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | tee -a "$LOG_FILE"
	  sudo chown -v ark:ark /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | tee -a "$LOG_FILE"
	fi

	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)" /usr/share/plymouth/themes/text.plymouth

	touch "/home/ark/.config/.update01272024-1"

fi

if [ ! -f "/home/ark/.config/.update02042024" ]; then

printf "\nAdd New Features by AeolusUX\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/02042024/arkosupdate02042024.zip -O /dev/shm/arkosupdate02042024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate02042024.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate02042024.zip" ]; then
	  sudo unzip -X -o /dev/shm/arkosupdate02042024.zip -d / | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate* | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi

	  cp -fv /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | tee -a "$LOG_FILE"
	  sudo chown -v ark:ark /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | tee -a "$LOG_FILE"
	
	  cp -fv /usr/local/bin/Read\ from\ SD1\ and\ SD2\ for\ Roms /opt/system/Advanced/Read\ from\ SD1\ and\ SD2\ for\ Roms | tee -a "$LOG_FILE"
      sudo chown -v ark:ark /opt/system/Advanced/Read\ from\ SD1\ and\ SD2\ for\ Roms | tee -a "$LOG_FILE"
	  sudo chmod -v 0777 "/opt/system/Advanced/Read from SD1 and SD2 for Roms" | tee -a "$LOG_FILE"
	  
	  cp -fv /usr/local/bin/es_systems.cfg.dual /etc/emulationstation/es_systems.cfg.dual | tee -a "$LOG_FILE"
      sudo chown -v ark:ark /opt/system/Advanced/Read\ from\ SD1\ and\ SD2\ for\ Roms | tee -a "$LOG_FILE"

	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)" /usr/share/plymouth/themes/text.plymouth

	touch "$/home/ark/.config/.update02042024"
	
fi

if [ ! -f "$UPDATE_DONE" ]; then

printf "\nFix for GlobalHotkeys and standalone-rice\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/02062024/arkosupdate02062024.zip -O /dev/shm/arkosupdate02062024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate02062024.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate02062024.zip" ]; then
	  sudo unzip -X -o /dev/shm/arkosupdate02062024.zip -d / | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate* | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi

	
	  sudo chmod -v 0755 "/opt/mupen64plus/mupen64plus-video-rice.so" | tee -a "$LOG_FILE"
	  sudo chmod -v 0777 "/usr/local/bin/pause.sh" | tee -a "$LOG_FILE"
	  sudo chmod -v 0777 "/usr/local/bin/finish.sh" | tee -a "$LOG_FILE"
	  sudo chmod -v 0777 "/usr/local/bin/doomkeydemon.py" | tee -a "$LOG_FILE"
	  sudo chmod -v 0777 "/usr/local/bin/drastickeydemon.py" | tee -a "$LOG_FILE"
	  sudo chmod -v 0777 "/usr/local/bin/openborkeydemon.py" | tee -a "$LOG_FILE"
	  sudo chmod -v 0777 "/usr/local/bin/pico8keydemon.py" | tee -a "$LOG_FILE"
	  sudo chmod -v 0777 "/usr/local/bin/ppssppkeydemon.py" | tee -a "$LOG_FILE"
	  sudo chmod -v 0777 "/usr/local/bin/scummvmkeydemon.py" | tee -a "$LOG_FILE"
	  sudo chmod -v 0777 "/usr/local/bin/singekeydemon.py" | tee -a "$LOG_FILE"
	  sudo chmod -v 0777 "/usr/local/bin/solarushotkeydemon.py" | tee -a "$LOG_FILE"
	  sudo chmod -v 0777 "/usr/local/bin/ti99keydemon.py" | tee -a "$LOG_FILE"

	 

	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)" /usr/share/plymouth/themes/text.plymouth

	touch "$UPDATE_DONE"	

	rm -v -- "$0" | tee -a "$LOG_FILE"
	printf "\033c" >> /dev/tty1
	msgbox "Updates have been completed.  System will now restart after you hit the A button to continue.  If the system doesn't restart after pressing A, just restart the system manually."
	echo $c_brightness > /sys/class/backlight/backlight/brightness
	sudo reboot
	exit 187
fi
