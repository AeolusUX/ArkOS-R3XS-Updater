#!/bin/bash
clear
UPDATE_DATE="02092025"
LOG_FILE="/home/ark/update$UPDATE_DATE.log"
UPDATE_DONE="/home/ark/.config/.update$UPDATE_DATE"

if [ -f "$UPDATE_DONE" ]; then
	msgbox "No more updates available.  Check back later."
	rm -- "$0"
	exit 187
fi

if [ -f "$LOG_FILE" ]; then
	sudo rm "$LOG_FILE"
	sudo rm "$LOG_FILE"
fi

LOCATION="https://raw.githubusercontent.com/AeolusUX/ArkOS-R3XS-Updater/main"
ISITCHINA="$(curl -s --connect-timeout 30 -m 60 http://demo.ip-api.com/json | grep -Po '"country":.*?[^\\]"')"

if [ "$ISITCHINA" = "\"country\":\"China\"" ]; then
  printf "\n\nSwitching to China server for updates.\n\n" | tee -a "$LOG_FILE"
  LOCATION="https://raw.githubusercontent.com/AeolusUX/ArkOS-R3XS-Updater/main"
fi

sudo msgbox "MAKE SURE YOU SWITCHED TO MAIN SD FOR ROMS BEFORE YOU RUN THIS UPDATE. ONCE YOU PROCEED WITH THIS UPDATE SCRIPT, DO NOT STOP THIS SCRIPT UNTIL IT IS COMPLETED OR THIS DISTRIBUTION MAY BE LEFT IN A STATE OF UNUSABILITY.  Make sure you've created a backup of this sd card as a precaution in case something goes very wrong with this process.  You've been warned!  Type OK in the next screen to proceed."
my_var=`osk "Enter OK here to proceed." | tail -n 1`

#sudo msgbox "UPDATER IS CURRENTLY UNAVAILABLE. IT WILL BE BACK AGAIN, SOON."
#my_var=`osk "TRY AGAIN LATER" | tail -n 1`

echo "$my_var" | tee -a "$LOG_FILE"

#if [ "$my_var" != "test" ] && [ "$my_var" != "TEST" ]; then
if [ "$my_var" != "ok" ] && [ "$my_var" != "OK" ]; then

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
	
	

	if [ -f "/opt/system/Advanced/Switch to SD2 for Roms.sh" ]; then
	  cp -fv /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | tee -a "$LOG_FILE"
	  sudo chown -v ark:ark /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | tee -a "$LOG_FILE"
	else
	  cp -fv /usr/local/bin/Switch\ to\ main\ SD\ for\ Roms.sh /usr/local/bin/Switch\ to\ main\ SD\ for\ Roms.sh | tee -a "$LOG_FILE"
	  sudo chown -v ark:ark /opt/system/Advanced/Switch\ to\ main\ SD\ for\ Roms.sh | tee -a "$LOG_FILE"
	fi
	  cp -fv /usr/local/bin/Read\ from\ SD1\ and\ SD2\ for\ Roms /opt/system/Advanced/Read\ from\ SD1\ and\ SD2\ for\ Roms | tee -a "$LOG_FILE"
      sudo chown -v ark:ark /opt/system/Advanced/Read\ from\ SD1\ and\ SD2\ for\ Roms | tee -a "$LOG_FILE"
	  sudo chmod -v 0777 "/opt/system/Advanced/Read from SD1 and SD2 for Roms" | tee -a "$LOG_FILE"
	  
	  cp -fv /usr/local/bin/es_systems.cfg.dual /etc/emulationstation/es_systems.cfg.dual | tee -a "$LOG_FILE"
      sudo chown -v ark:ark /opt/system/Advanced/Read\ from\ SD1\ and\ SD2\ for\ Roms | tee -a "$LOG_FILE"

	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)" /usr/share/plymouth/themes/text.plymouth

	touch "/home/ark/.config/.update02042024"
	
fi

	if [ ! -f "/home/ark/.config/.update02062024" ]; then

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
	  sudo chmod -v 0777 "/usr/local/bin/ogage" | tee -a "$LOG_FILE"

	 

	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)" /usr/share/plymouth/themes/text.plymouth

	touch "/home/ark/.config/.update02062024"	
fi

	if [ ! -f "/home/ark/.config/.update02232024" ]; then

	printf "\nFix PPSSPP exit hotkey demon from last update\nFixed left justification of ALG games\nUpdate PPSSPP to version 1.17.1\nUpdated XRoar emulator\nFix standalone-duckstation script\nUpdate retroarch and retroarch32 to 1.17\nUpdate retroarch and retroarch32 launch scripts\nUpdated USB DAC control script\nUpdate Emulationstation to fix crash with editing metadata for options\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/02232024/arkosupdate02232024.zip -O /dev/shm/arkosupdate02232024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate02232024.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate02232024.zip" ]; then
		if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
		  if [ ! -z "$(grep "RGB30" /home/ark/.config/.DEVICE | tr -d '\0')" ]; then
            sudo unzip -X -o /dev/shm/arkosupdate02232024.zip -d / | tee -a "$LOG_FILE"
		  else
            sudo unzip -X -o /dev/shm/arkosupdate02232024.zip -x usr/local/bin/rgb30versioncheck.bat "usr/local/bin/rgb30dtbs/*" -d / | tee -a "$LOG_FILE"
		  fi
		else
          sudo unzip -X -o /dev/shm/arkosupdate02232024.zip -x usr/local/bin/ppssppkeydemon.py -d / | tee -a "$LOG_FILE"
		fi
	    sudo rm -fv /dev/shm/arkosupdate02232024.zip | tee -a "$LOG_FILE"
	else
		printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
		sudo rm -fv /dev/shm/arkosupdate02232024.z* | tee -a "$LOG_FILE"
		sleep 3
		echo $c_brightness > /sys/class/backlight/backlight/brightness
		exit 1
	fi
	
	  cp -fv /usr/local/bin/es_systems.cfg.dual /etc/emulationstation/es_systems.cfg.dual | tee -a "$LOG_FILE"
	  
	if [ -f "/opt/system/Advanced/Switch to SD2 for Roms.sh" ]; then
	  if test -z "$(cat /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | grep videopac | tr -d '\0')"
	  then
		sudo chown -v ark:ark /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | tee -a "$LOG_FILE"
		sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/videopac\/" ]\; then\n      sudo mkdir \/roms2\/videopac\n  fi\n  sudo pkill filebrowser/' /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh
	  else
		printf "\nvideopac is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	  fi
	fi
	if [ -f "/usr/local/bin/Switch to SD2 for Roms.sh" ]; then
	  if test -z "$(cat /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh | grep videopac | tr -d '\0')"
	  then
		sudo sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/videopac\/" ]\; then\n      sudo mkdir \/roms2\/videopac\n  fi\n  sudo pkill filebrowser/' /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh
	  else
		printf "\nvideopac is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	  fi
	fi
	rm -fv /home/ark/add_videopac.txt | tee -a "$LOG_FILE"

	printf "\nCopy correct PPSSPPSDL for device\n" | tee -a "$LOG_FILE"
	if [ -f "/boot/rk3566.dtb" ]; then
      rm -fv /opt/ppsspp/PPSSPPSDL.rk3326 | tee -a "$LOG_FILE"
    else
      mv -fv /opt/ppsspp/PPSSPPSDL.rk3326 /opt/ppsspp/PPSSPPSDL | tee -a "$LOG_FILE"
	fi

	printf "\nCopy correct Retroarches depending on device\n" | tee -a "$LOG_FILE"
	if [ -f "/boot/rk3326-r33s-linux.dtb" ] || [ -f "/boot/rk3326-r35s-linux.dtb" ] || [ -f "/boot/rk3326-r36s-linux.dtb" ] || [ -f "/boot/rk3326-rg351v-linux.dtb" ] || [ -f "/boot/rk3326-rg351mp-linux.dtb" ] || [ -f "/boot/rk3326-gameforce-linux.dtb" ]; then
	  cp -fv /opt/retroarch/bin/retroarch32.rk3326.unrot /opt/retroarch/bin/retroarch32 | tee -a "$LOG_FILE"
	  cp -fv /opt/retroarch/bin/retroarch.rk3326.unrot /opt/retroarch/bin/retroarch | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch.* | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch32.* | tee -a "$LOG_FILE"
	  cp -Rfv /home/ark/retroarch_filters/filters.rk3326/ /home/ark/.config/retroarch/
	  cp -Rfv /home/ark/retroarch_filters/filters32.rk3326/ /home/ark/.config/retroarch32/
	  rm -rfv /home/ark/retroarch_filters/ | tee -a "$LOG_FILE"
	elif [ -f "/boot/rk3326-odroidgo2-linux.dtb" ] || [ -f "/boot/rk3326-odroidgo2-linux-v11.dtb" ] || [ -f "/boot/rk3326-odroidgo3-linux.dtb" ]; then
	  cp -fv /opt/retroarch/bin/retroarch32.rk3326.rot /opt/retroarch/bin/retroarch32 | tee -a "$LOG_FILE"
	  cp -fv /opt/retroarch/bin/retroarch.rk3326.rot /opt/retroarch/bin/retroarch | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch.* | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch32.* | tee -a "$LOG_FILE"
	  cp -Rfv /home/ark/retroarch_filters/filters.rk3326/ /home/ark/.config/retroarch/
	  cp -Rfv /home/ark/retroarch_filters/filters32.rk3326/ /home/ark/.config/retroarch32/
	  rm -rfv /home/ark/retroarch_filters/ | tee -a "$LOG_FILE"
	else
	  rm -fv /opt/retroarch/bin/retroarch.* | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch32.* | tee -a "$LOG_FILE"
	  cp -Rfv /home/ark/retroarch_filters/filters/ /home/ark/.config/retroarch/
	  cp -Rfv /home/ark/retroarch_filters/filters32/ /home/ark/.config/retroarch32/
	  rm -rfv /home/ark/retroarch_filters/ | tee -a "$LOG_FILE"
	fi

#	echo "\nUpdate glibc and libstdc++\n" | tee -a "$LOG_FILE"
#	echo 'deb http://ports.ubuntu.com/ubuntu-ports focal main universe' | sudo tee -a /etc/apt/sources.list
#	echo 'libc6 libraries/restart-without-asking boolean true' | sudo debconf-set-selections
#	sudo apt -y update && sudo apt -y install libc6 libstdc++6 | tee -a "$LOG_FILE"
#	sudo sed -i '/focal/d' /etc/apt/sources.list
#	echo 'deb http://ports.ubuntu.com/ubuntu-ports jammy main universe' | sudo tee -a /etc/apt/sources.list
#	sudo apt -y update && sudo apt -y install libc6 libstdc++6 | tee -a "$LOG_FILE"
#	sudo ln -sfv /usr/lib/aarch64-linux-gnu/libSDL2-2.0.so.0.2800.2 /usr/lib/aarch64-linux-gnu/libSDL2.so | tee -a "$LOG_FILE"
#	sudo ln -sfv /usr/lib/arm-linux-gnueabihf/libSDL2-2.0.so.0.2800.2 /usr/lib/arm-linux-gnueabihf/libSDL2.so | tee -a "$LOG_FILE"
#	sudo sed -i '/jammy/d' /etc/apt/sources.list
#	sudo apt -y update | tee -a "$LOG_FILE"

	if [ ! -z "$(grep "RGB30" /home/ark/.config/.DEVICE | tr -d '\0')" ]; then
	  printf "\nAdd V1 and V2 detection to fix performance issues for the RGB30 units\n" | tee -a "$LOG_FILE"
	  if test -z "$(sudo crontab -l | grep 'rgb30versioncheck.sh' | tr -d '\0')"
	  then
	    echo "@reboot /usr/local/bin/rgb30versioncheck.sh &" | sudo tee -a /var/spool/cron/crontabs/root | tee -a "$LOG_FILE"
	    if test ! -z "$(dmesg | grep -Eo 'cpu[0-9] policy NULL' | head -n 1 | tr -d '\0')"
	    then
	      if [ ! -f "/home/ark/.config/.V2DTBLOADED" ]; then
		    sudo cp -f /usr/local/bin/rgb30dtbs/rk3566-rgb30.dtb.v2 /boot/rk3566-OC.dtb
	        touch /home/ark/.config/.V2DTBLOADED
	      else
		    sudo cp -f /usr/local/bin/rgb30dtbs/rk3566-rgb30.dtb.v1 /boot/rk3566-OC.dtb
		    rm -f /home/ark/.config/.V2DTBLOADED
	      fi
	    fi
	  else
	    printf "  No need to add this feature as it already exists.\n" | tee -a "$LOG_FILE"
	  fi
	fi

	printf "\nAdd exit hotkey daemon for ecwolf standalone\n" | tee -a "$LOG_FILE"
	sudo cp -fv /usr/local/bin/ti99keydemon.py /usr/local/bin/ecwolfsakeydemon.py | tee -a "$LOG_FILE"
	sudo chmod 777 /usr/local/bin/ecwolfsakeydemon.py
	sudo sed -i 's/ti99sim-sdl/ecwolf/' /usr/local/bin/ecwolfsakeydemon.py

	if test -z "$(cat /etc/fstab | grep roms2 | tr -d '\0')"
	then
	  if [ ! -f "/boot/rk3326-rg351v-linux.dtb" ]; then
	    printf "\nFixing standalone-duckstation loading for single card setup\n" | tee -a "$LOG_FILE"
	    sed -i '/\/roms2\//s//\/roms\//g' /home/ark/.config/duckstation/settings.ini
	  else
	    printf "\nThis seems to be a RG351V unit so skipping standalone-duckstation fix since it's not available for this unit\n" | tee -a "$LOG_FILE"
	  fi
	fi

	if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
	  printf "\nFix audio performance issues for the mednafen standalone emulator\n" | tee -a "$LOG_FILE"
	  sudo cp -fv /usr/share/alsa/alsa.conf /usr/share/alsa/alsa.conf.mednafen | tee -a "$LOG_FILE"
	  sudo sed -i '/\"\~\/.asoundrc\"/s//\"\~\/.asoundrc.mednafen\"/' /usr/share/alsa/alsa.conf.mednafen
	fi

	if [ -f "/boot/rk3326-r33s-linux.dtb" ] || [ -f "/boot/rk3326-r35s-linux.dtb" ] || [ -f "/boot/rk3326-r36s-linux.dtb" ] || [ -f "/boot/rk3326-rg351mp-linux.dtb" ]; then
	  printf "\nFix mednafen standalone emulator controls\n" | tee -a "$LOG_FILE"
	  sed -i '/0x0019484b110001000004001000000000/s//0x0019484b110001000004001100000000/g' /home/ark/.mednafen/mednafen.cfg
	fi

	printf "\nCopy correct emulationstation depending on device\n" | tee -a "$LOG_FILE"
	if [ -f "/boot/rk3326-r33s-linux.dtb" ] || [ -f "/boot/rk3326-r35s-linux.dtb" ] || [ -f "/boot/rk3326-r36s-linux.dtb" ] || [ -f "/boot/rk3326-rg351v-linux.dtb" ] || [ -f "/boot/rk3326-rg351mp-linux.dtb" ] || [ -f "/boot/rk3326-gameforce-linux.dtb" ]; then
	  sudo mv -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	elif [ -f "/boot/rk3326-odroidgo2-linux.dtb" ] || [ -f "/boot/rk3326-odroidgo2-linux-v11.dtb" ] || [ -f "/boot/rk3326-odroidgo3-linux.dtb" ]; then
	  test=$(stat -c %s "/usr/bin/emulationstation/emulationstation")
	  if [ "$test" = "3367776" ]; then
	    sudo cp -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  elif [ -f "/home/ark/.config/.DEVICE" ]; then
		sudo cp -fv /home/ark/emulationstation.rgb10max /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  else
	    sudo cp -fv /home/ark/emulationstation.header /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  fi
	  if [ -f "/home/ark/.config/.DEVICE" ]; then
	    sudo cp -fv /home/ark/emulationstation.rgb10max /usr/bin/emulationstation/emulationstation.header | tee -a "$LOG_FILE"
	  else
	    sudo cp -fv /home/ark/emulationstation.header /usr/bin/emulationstation/emulationstation.header | tee -a "$LOG_FILE"
	  fi
	  sudo cp -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation.fullscreen | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	elif [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
	  sudo mv -fv /home/ark/emulationstation.503 /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	fi

	printf "\nCopy correct libretro yabasanshiro core for retroarch depending on device\n" | tee -a "$LOG_FILE"
	if [ ! -f "/boot/rk3566.dtb" ] && [ ! -f "/boot/rk3566-OC.dtb" ]; then
	  mv -fv /home/ark/.config/retroarch/cores/yabasanshiro_libretro.so.rk3326 /home/ark/.config/retroarch/cores/yabasanshiro_libretro.so | tee -a "$LOG_FILE"
	else
	  rm -fv /home/ark/.config/retroarch/cores/yabasanshiro_libretro.so.rk3326 | tee -a "$LOG_FILE"
	fi

	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth

	touch "/home/ark/.config/.update02232024"	
fi

	if [ ! -f "/home/ark/.config/.update02252024" ]; then

	printf "\nAdd J2ME Support\nby Jamerson and Joanilson. youtube.com/@joanilson41" | tee -a "$LOG_FILE"
	sleep 3
	sudo rm -rf /dev/shm/*
	tmp_mem_size=$(df -h /dev/shm | grep shm | awk '{print $2}' | cut -d 'M' -f1)
	if [ ${tmp_mem_size} -lt 450 ]; then
	  printf "\nTemporarily raising temp memory storage for this large update\n" | tee -a "$LOG_FILE"
	  sudo mount -o remount,size=450M /dev/shm
	fi
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/02252024/arkosupdate02252024.zip -O /dev/shm/arkosupdate02252024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate02252024.zip | tee -a "$LOG_FILE"
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/02252024/arkosupdate02252024.z01 -O /dev/shm/arkosupdate02252024.z01 -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate02252024.z01 | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate02252024.zip" ] && [ -f "/dev/shm/arkosupdate02252024.z01" ]; then
	  zip -FF /dev/shm/arkosupdate02252024.zip --out /dev/shm/arkosupdate.zip -fz | tee -a "$LOG_FILE"
	  sudo unzip -X -o /dev/shm/arkosupdate.zip -d / | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate* | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi
	
	  echo "Adding J2ME Cores"
	  sleep 3
	  sudo mv "/usr/local/bin/freej2me_libretro.so" "/home/ark/.config/retroarch/cores/freej2me_libretro.so" | tee -a "$LOG_FILE"
	  sudo mv "/usr/local/bin/freej2me_libretro.info" "/home/ark/.config/retroarch/cores/freej2me_libretro.info" | tee -a "$LOG_FILE"
	  echo "Adding BIOS File"
	  sleep 3
	  sudo mv "/usr/local/bin/freej2me-lr.jar" "/roms/bios/freej2me-lr.jar" | tee -a "$LOG_FILE"
	  echo "Installing JDK package" 
	  sleep 3
	  sudo mkdir -p "/roms/j2me/" | tee -a "$LOG_FILE"
	  sudo dpkg -i "/usr/local/bin/java-common.deb" >> "$LOG_FILE" 2>&1
	  sudo dpkg -i "/usr/local/bin/zulu21.32.17-ca-jdk21.0.2-linux_arm64.deb" >> "$LOG_FILE" 2>&1
	  echo "Copying asound.conf file"
	  sleep 3
	  sudo mv "/usr/local/bin/asound.conf" "/roms/tools/PortMaster/libs/" | tee -a "$LOG_FILE"
	  
	  
	  
	  echo "Removing zulu21.32.17-ca-jdk21.0.2-linux_arm64.deb and java-common.deb files"
      sleep 3
	  sudo rm -fv /usr/local/bin/java-common.deb | tee -a "$LOG_FILE"
	  sudo rm -fv /usr/local/bin/zulu21.32.17-ca-jdk21.0.2-linux_arm64.deb | tee -a "$LOG_FILE"

	  cp -fv /usr/local/bin/es_systems.cfg.dual /etc/emulationstation/es_systems.cfg.dual | tee -a "$LOG_FILE"

	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth

	touch "/home/ark/.config/.update02252024"	
fi

if [ ! -f "/home/ark/.config/.update03292024" ]; then

	printf "\nAdd .neo and .NEO extension support for Neo Geo\nUpdate n64.sh launch script\nUpdate retroarches\nUpdate XRoar to 1.5.5\nUpdate Kodi to 20.5\nUpdate singe.sh launch script\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
	  sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/03292024/arkosupdate-kodi03292024.zip -O /dev/shm/arkosupdate-kodi03292024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate-kodi03292024.zip | tee -a "$LOG_FILE"
	  sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/03292024/arkosupdate-kodi03292024.z01 -O /dev/shm/arkosupdate-kodi03292024.z01 -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate-kodi03292024.z01 | tee -a "$LOG_FILE"
	  if [ -f "/dev/shm/arkosupdate-kodi03292024.zip" ] && [ -f "/dev/shm/arkosupdate-kodi03292024.z01" ]; then
	    zip -FF /dev/shm/arkosupdate-kodi03292024.zip --out /dev/shm/arkosupdate03292024.zip -fz | tee -a "$LOG_FILE"
		sudo rm -fv /dev/shm/arkosupdate-kodi03292024.z* | tee -a "$LOG_FILE"
	  else
		printf "\nThe update couldn't complete because the packages did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
		sudo rm -fv /dev/shm/arkosupdate* | tee -a "$LOG_FILE"
		sleep 3
		echo $c_brightness > /sys/class/backlight/backlight/brightness
		exit 1
	  fi
	else
	  sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/03292024/arkosupdate03292024.zip -O /dev/shm/arkosupdate03292024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate03292024.zip | tee -a "$LOG_FILE"
	fi
	if [ -f "/dev/shm/arkosupdate03292024.zip" ]; then
		if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
		  rm -rfv /opt/kodi/lib/kodi/addons/* /opt/kodi/share/kodi/addons/* /opt/kodi/lib/addons/* /opt/kodi/lib/pkgconfig/* /opt/kodi/lib/libdumb.a | tee -a "$LOG_FILE"
		fi
		cp -v /etc/emulationstation/es_systems.cfg /etc/emulationstation/es_systems.cfg.update03292024.bak
		sudo unzip -X -o /dev/shm/arkosupdate03292024.zip -d / | tee -a "$LOG_FILE"
		if [ "$(cat ~/.config/.DEVICE)" = "RG353M" ] || [ "$(cat ~/.config/.DEVICE)" = "RG353V" ] || [ "$(cat ~/.config/.DEVICE)" = "RK2023" ] || [ "$(cat ~/.config/.DEVICE)" = "RGB30" ]; then
		  sed -i '/<res width\="1920" height\="1440" aspect\="4:3"/s//<res width\="1623" height\="1180" aspect\="4:3"/g' /opt/kodi/share/kodi/addons/skin.estuary/addon.xml
		fi
		sudo rm -fv /dev/shm/arkosupdate03292024.zip | tee -a "$LOG_FILE"
	else
		printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
		sudo rm -fv /dev/shm/arkosupdate03292024.z* | tee -a "$LOG_FILE"
		sleep 3
		echo $c_brightness > /sys/class/backlight/backlight/brightness
		exit 1
	fi

	if test -z "$(cat /etc/emulationstation/es_systems.cfg | grep 'apple2' | tr -d '\0')"
	then
	  printf "\nAdd apple2 emulation support\n" | tee -a "$LOG_FILE"
	  sed -i -e '/<theme>amstradcpc<\/theme>/{r /home/ark/add_apple2.txt' -e 'd}' /etc/emulationstation/es_systems.cfg
	fi
	if [ ! -d "/roms/apple2" ]; then
	  mkdir -v /roms/apple2 | tee -a "$LOG_FILE"
	  if test ! -z "$(cat /etc/fstab | grep roms2 | tr -d '\0')"
	  then
		if [ ! -d "/roms2/apple2" ]; then
		  mkdir -v /roms2/apple2 | tee -a "$LOG_FILE"
		  sed -i '/<path>\/roms\/apple2/s//<path>\/roms2\/apple2/g' /etc/emulationstation/es_systems.cfg
		fi
	  fi
	fi
	if [ -f "/opt/system/Advanced/Switch to SD2 for Roms.sh" ]; then
	  if test -z "$(cat /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | grep apple2 | tr -d '\0')"
	  then
		sudo chown -v ark:ark /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | tee -a "$LOG_FILE"
		sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/apple2\/" ]\; then\n      sudo mkdir \/roms2\/apple2\n  fi\n  sudo pkill filebrowser/' /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh
	  else
		printf "\napple2 is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	  fi
	fi
	if [ -f "/usr/local/bin/Switch to SD2 for Roms.sh" ]; then
	  if test -z "$(cat /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh | grep apple2 | tr -d '\0')"
	  then
		sudo sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/apple2\/" ]\; then\n      sudo mkdir \/roms2\/apple2\n  fi\n  sudo pkill filebrowser/' /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh
	  else
		printf "\napple2 is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	  fi
	fi
	rm -fv /home/ark/add_apple2.txt | tee -a "$LOG_FILE"

	if [ -f "/boot/rk3326-r33s-linux.dtb" ] || [ -f "/boot/rk3326-r35s-linux.dtb" ] || [ -f "/boot/rk3326-r36s-linux.dtb" ] || [ -f "/boot/rk3326-rg351v-linux.dtb" ] || [ -f "/boot/rk3326-rg351mp-linux.dtb" ] || [ -f "/boot/rk3326-gameforce-linux.dtb" ] || [ -f "/boot/rk3326-odroidgo2-linux.dtb" ] || [ -f "/boot/rk3326-odroidgo2-linux-v11.dtb" ] || [ -f "/boot/rk3326-odroidgo3-linux.dtb" ]; then
	  printf "\nCopy updated Retroarch filters for rk3326 devices\n" | tee -a "$LOG_FILE"
	  cp -Rfv /home/ark/.config/retroarch/filters.rk3326/* /home/ark/.config/retroarch/filters/ | tee -a "$LOG_FILE"
	  cp -Rfv /home/ark/.config/retroarch32/filters32.rk3326/* /home/ark/.config/retroarch32/filters/ | tee -a "$LOG_FILE"
	  sudo rm -Rfv /home/ark/.config/retroarch32/filters32.rk3326/ | tee -a "$LOG_FILE"
	  sudo rm -Rfv /home/ark/.config/retroarch/filters.rk3326/ | tee -a "$LOG_FILE"
	  printf "\nRemove RGB30 related items accidentally added from the 02232024 update\n" | tee -a "$LOG_FILE"
	  sudo rm -rfv /usr/local/bin/rgb30versioncheck.sh /usr/local/bin/rgb30dtbs/ | tee -a "$LOG_FILE"
	fi

	if [ -f /home/ark/.config/.DEVICE ] && [ -z "$(grep "RGB30" /home/ark/.config/.DEVICE | tr -d '\0')" ]; then
	  printf "\nRemove RGB30 related items accidentally added from the 02232024 update\n" | tee -a "$LOG_FILE"
	  sudo rm -rfv /usr/local/bin/rgb30versioncheck.sh | tee -a "$LOG_FILE"
	fi

	if test -z "$(grep 'geolith' /etc/emulationstation/es_systems.cfg | tr -d '\0')"
	then
	  printf "\nAdd geolith libretro core for Neo Geo\n" | tee -a "$LOG_FILE"
	  sed -i -r '/<name>neogeo<\/name>/,/<core>mame2003_plus<\/core>/ s|<core>mame2003_plus<\/core>|<core>mame2003_plus<\/core>\n\t\t\t  <core>geolith<\/core>|' /etc/emulationstation/es_systems.cfg
	  sed -i -r '/<name>neogeo<\/name>/,/<extension>.zip .ZIP .7z .7Z .cue .CUE/ s|<extension>.zip .ZIP .7z .7Z .cue .CUE|<extension>.7z .7Z .cue .CUE .neo .NEO .zip .ZIP|' /etc/emulationstation/es_systems.cfg
	  printf "\nCopy correct libretro geolith core depending on device\n" | tee -a "$LOG_FILE"
	  if [ ! -f "/boot/rk3566.dtb" ] && [ ! -f "/boot/rk3566-OC.dtb" ]; then
	    mv -fv /home/ark/.config/retroarch/cores/geolith_libretro.so.rk3326 /home/ark/.config/retroarch/cores/geolith_libretro.so | tee -a "$LOG_FILE"
	  else
	    rm -fv /home/ark/.config/retroarch/cores/geolith_libretro.so.rk3326 | tee -a "$LOG_FILE"
	  fi
	fi

	if test -z "$(grep 'DoubleCherryGB' /etc/emulationstation/es_systems.cfg | tr -d '\0')"
	then
	  printf "\nAdd DoubleCherryGB libretro core for GameBoy and GameBoy Color\n" | tee -a "$LOG_FILE"
	  sed -i '/<core>tgbdual<\/core>/c\\t\t\t  <core>DoubleCherryGB<\/core>\n\t\t\t  <core>tgbdual<\/core>' /etc/emulationstation/es_systems.cfg
	fi

	printf "\nAdd stella libretro emulator for Atari 2600\n" | tee -a "$LOG_FILE"
	if test -z "$(cat /etc/emulationstation/es_systems.cfg | grep -w 'stella' | tr -d '\0')"
	then
	  sed -i -e '/cores\/stella2014_libretro.so/{r /home/ark/add_stella.txt' -e 'd}' /etc/emulationstation/es_systems.cfg
	  rm -fv /home/ark/add_stella.txt | tee -a "$LOG_FILE"
	else
	  rm -fv /home/ark/add_stella.txt | tee -a "$LOG_FILE"
	fi

	printf "\nCopy correct Retroarches depending on device\n" | tee -a "$LOG_FILE"
	if [ -f "/boot/rk3326-r33s-linux.dtb" ] || [ -f "/boot/rk3326-r35s-linux.dtb" ] || [ -f "/boot/rk3326-r36s-linux.dtb" ] || [ -f "/boot/rk3326-rg351v-linux.dtb" ] || [ -f "/boot/rk3326-rg351mp-linux.dtb" ] || [ -f "/boot/rk3326-gameforce-linux.dtb" ]; then
	  cp -fv /opt/retroarch/bin/retroarch32.rk3326.unrot /opt/retroarch/bin/retroarch32 | tee -a "$LOG_FILE"
	  cp -fv /opt/retroarch/bin/retroarch.rk3326.unrot /opt/retroarch/bin/retroarch | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch.* | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch32.* | tee -a "$LOG_FILE"
	elif [ -f "/boot/rk3326-odroidgo2-linux.dtb" ] || [ -f "/boot/rk3326-odroidgo2-linux-v11.dtb" ] || [ -f "/boot/rk3326-odroidgo3-linux.dtb" ]; then
	  cp -fv /opt/retroarch/bin/retroarch32.rk3326.rot /opt/retroarch/bin/retroarch32 | tee -a "$LOG_FILE"
	  cp -fv /opt/retroarch/bin/retroarch.rk3326.rot /opt/retroarch/bin/retroarch | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch.* | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch32.* | tee -a "$LOG_FILE"
	else
	  rm -fv /opt/retroarch/bin/retroarch.* | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch32.* | tee -a "$LOG_FILE"
	fi

	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth

	printf "\nUpdate older PortMaster install to address a possible update bug\n" | tee -a "$LOG_FILE"
	# Only update if our version is a possibly bugged version.
	chmod +x /home/ark/Install.PortMaster.sh
	touch /home/ark/no_es_restart
	/home/ark/Install.PortMaster.sh | tee -a "$LOG_FILE"
	# Delete the installer
	rm -fv /home/ark/Install.PortMaster.sh | tee -a "$LOG_FILE"

	touch "/home/ark/.config/.update03292024"

fi

if [ ! -f "/home/ark/.config/.update03302024" ]; then

	printf "\nFix retroarch32 rotation\nFix missing saves from last retroarch update\nFix PPSSPP 1.17.1 gui size\nUpdated apple2.sh script\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/03302024/arkosupdate03302024.zip -O /dev/shm/arkosupdate03302024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate03302024.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate03302024.zip" ]; then
      sudo unzip -X -o /dev/shm/arkosupdate03302024.zip -d / | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate03302024.zip | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate03302024.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi

	printf "\nCopy correct Retroarches depending on device\n" | tee -a "$LOG_FILE"
	if [ -f "/boot/rk3326-r33s-linux.dtb" ] || [ -f "/boot/rk3326-r35s-linux.dtb" ] || [ -f "/boot/rk3326-r36s-linux.dtb" ] || [ -f "/boot/rk3326-rg351v-linux.dtb" ] || [ -f "/boot/rk3326-rg351mp-linux.dtb" ] || [ -f "/boot/rk3326-gameforce-linux.dtb" ]; then
	  cp -fv /opt/retroarch/bin/retroarch32.rk3326.unrot /opt/retroarch/bin/retroarch32 | tee -a "$LOG_FILE"
	  cp -fv /opt/retroarch/bin/retroarch.rk3326.unrot /opt/retroarch/bin/retroarch | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch.* | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch32.* | tee -a "$LOG_FILE"
	elif [ -f "/boot/rk3326-odroidgo2-linux.dtb" ] || [ -f "/boot/rk3326-odroidgo2-linux-v11.dtb" ] || [ -f "/boot/rk3326-odroidgo3-linux.dtb" ]; then
	  cp -fv /opt/retroarch/bin/retroarch32.rk3326.rot /opt/retroarch/bin/retroarch32 | tee -a "$LOG_FILE"
	  cp -fv /opt/retroarch/bin/retroarch.rk3326.rot /opt/retroarch/bin/retroarch | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch.* | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch32.* | tee -a "$LOG_FILE"
	else
	  rm -fv /opt/retroarch/bin/retroarch.* | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch32.* | tee -a "$LOG_FILE"
	fi

	printf "\nCopy correct PPSSPPSDL for device\n" | tee -a "$LOG_FILE"
	if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
      rm -fv /opt/ppsspp/PPSSPPSDL.rk3326 | tee -a "$LOG_FILE"
    else
      mv -fv /opt/ppsspp/PPSSPPSDL.rk3326 /opt/ppsspp/PPSSPPSDL | tee -a "$LOG_FILE"
	fi

	if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
	  printf "\nAdd .rvz as supported extension for gamecube\n" | tee -a "$LOG_FILE"
	  sed -i '/<extension>.elf .ELF .gcz .GCZ .iso .ISO .m3u .M3U .wad .WAD .wbfs .WBFS .wia .WIA/s//<extension>.elf .ELF .gcz .GCZ .iso .ISO .m3u .M3U .rvz .RVZ .wad .WAD .wbfs .WBFS .wia .WIA/' /etc/emulationstation/es_systems.cfg
	fi
	echo "@reboot /home/ark/.config/imageshift.sh &" | sudo tee -a /var/spool/cron/crontabs/root
	sudo mkdir -v /boot/BMPs | tee -a "$LOG_FILE"
	cp -fv /usr/local/bin/es_systems.cfg.single /etc/emulationstation/es_systems.cfg | tee -a "$LOG_FILE"
	cp -fv /usr/local/bin/es_systems.cfg.dual /etc/emulationstation/es_systems.cfg.dual | tee -a "$LOG_FILE"

	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth
	
	touch "/home/ark/.config/.update03302024"
	
fi

if [ ! -f "/home/ark/.config/.update04022024" ]; then

	printf "\nFix for es_systems.cfg for dual sd card setup\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/04022024/arkosupdate04022024.zip -O /dev/shm/arkosupdate04022024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate04022024.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate04022024.zip" ]; then
      sudo unzip -X -o /dev/shm/arkosupdate04022024.zip -d / | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate04022024.zip | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate04022024.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi

	sudo rm -fv /etc/emulationstation/es_systems.cfg.single | tee -a "$LOG_FILE"
	sudo rm -fv /etc/emulationstation/es_systems.cfg.dual | tee -a "$LOG_FILE"
	cp -fv /usr/local/bin/es_systems.cfg /etc/emulationstation/es_systems.cfg | tee -a "$LOG_FILE"
	cp -fv /usr/local/bin/es_systems.cfg.dual /etc/emulationstation/es_systems.cfg.dual | tee -a "$LOG_FILE"

	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth
	
	touch "/home/ark/.config/.update04022024"
fi
if [ ! -f "/home/ark/.config/.update04112024" ]; then

	printf "\nAdd Change Time Script \nRename Change LED to Blue instead of Green \nAdd Support for Animated Launch Images \nReplace Kernel Drivers for WiFi from AmberElec \nAdded J2ME Support on es_systems.cfg \nFix Restore Scripts" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/04112024/arkosupdate04112024.zip -O /dev/shm/arkosupdate04112024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate04112024.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate04112024.zip" ]; then
	  sudo unzip -X -o /dev/shm/arkosupdate04112024.zip -d / | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate* | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate04112024.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi

		sudo rm -fv /etc/emulationstation/es_systems.cfg.single | tee -a "$LOG_FILE"
		sudo rm -fv "/usr/local/bin/Change LED to Green.sh" | tee -a "$LOG_FILE"
		sudo rm -fv "/opt/system/Change LED to Red.sh" | tee -a "$LOG_FILE"
		
		cp -fv /usr/local/bin/es_systems.cfg /etc/emulationstation/es_systems.cfg | tee -a "$LOG_FILE"
		
		sudo chown -v ark:ark /opt/system/Advanced/Restore\ Default\ GZdoom\ Settings.sh | tee -a "$LOG_FILE"
		sudo chown -v ark:ark /opt/system/Advanced/Restore\ Default\ LZdoom\ Settings.sh | tee -a "$LOG_FILE"
		sudo chown -v ark:ark /opt/system/Advanced/Restore\ Default\ PPSSPP\ Controls.sh | tee -a "$LOG_FILE"
		
	if [ -f "/opt/system/Change LED to Blue.sh" ]; then
		cp -fv "/usr/local/bin/Change LED to Blue.sh" "/opt/system/Change LED to Blue.sh" | tee -a "$LOG_FILE"
		sudo chmod -v 0777 "/opt/system/Change LED to Blue.sh" | tee -a "$LOG_FILE"
		sudo chown -v ark:ark "/opt/system/Change LED to Blue.sh" | tee -a "$LOG_FILE"
	else
		cp -fv "/usr/local/bin/Change LED to Red.sh" "/opt/system/Change LED to Red.sh" | tee -a "$LOG_FILE"
		sudo chmod -v 0777 "/opt/system/Change LED to Red.sh" | tee -a "$LOG_FILE"
		sudo chown -v ark:ark "/opt/system/Change LED to Red.sh" | tee -a "$LOG_FILE"
	fi

	
	    sudo chmod -v 0755 "/usr/local/bin/Switch Launchimage to gif.sh" | tee -a "$LOG_FILE"
		sudo chmod -v 0755 "/usr/local/bin/Switch Launchimage to jpg.sh" | tee -a "$LOG_FILE"
		sudo chmod -v 0755 "/usr/local/bin/Switch Launchimage to ascii.sh" | tee -a "$LOG_FILE"
		sudo chmod -v 0755 "/usr/local/bin/Change LED to Red.sh" | tee -a "$LOG_FILE"
		sudo chmod -v 0755 "/usr/local/bin/Change LED to Blue.sh" | tee -a "$LOG_FILE"
		sudo chmod -v 0777 "/usr/local/bin/perfnorm.pgif" | tee -a "$LOG_FILE"
		sudo chmod -v 0777 "/usr/local/bin/perfmax.pgif" | tee -a "$LOG_FILE"
		sudo chmod -v 0755 "/opt/system/Switch Launchimage to gif.sh" | tee -a "$LOG_FILE"
		sudo chmod -v 0755 "/opt/system/Change Time.sh" | tee -a "$LOG_FILE"
		sudo chown -v ark:ark "/opt/system/Change Time.sh" | tee -a "$LOG_FILE"
		sudo chown -v ark:ark "/usr/local/bin/perfmax.pgif" | tee -a "$LOG_FILE"
		sudo depmod
		
	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth
	
	touch "/home/ark/.config/.update04112024"
	fi
	
	if [ ! -f "/home/ark/.config/.update04242024" ]; then

	printf "\nUpdate apple2.sh script\nUpdate ppsspp-2021 to fix gui\nAdd fix audio tool for rk3566 devices only\nUpdate usbdac script for rk3566 devices\nAdd input tester tool\nUpdate Mednafen standalone to 1.32.1\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/04242024/arkosupdate04242024.zip -O /dev/shm/arkosupdate04242024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate04242024.zip | tee -a "$LOG_FILE"
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/04242024/arkosupdate04242024.z01 -O /dev/shm/arkosupdate04242024.z01 -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate04242024.z01 | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate04242024.zip" ] && [ -f "/dev/shm/arkosupdate04242024.z01" ]; then
	  zip -FF /dev/shm/arkosupdate04242024.zip --out /dev/shm/arkosupdate.zip -fz | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate04242024.z* | tee -a "$LOG_FILE"
	  if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
        sudo unzip -X -o /dev/shm/arkosupdate.zip -d / | tee -a "$LOG_FILE"
	  else
        sudo unzip -X -o /dev/shm/arkosupdate.zip -x opt/system/Advanced/Fix\ Audio.sh -d / | tee -a "$LOG_FILE"
	  fi
	  sudo rm -fv /dev/shm/arkosupdate.zip | tee -a "$LOG_FILE"
	  cp -v /etc/emulationstation/es_systems.cfg /etc/emulationstation/es_systems.cfg.update04242024.bak
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate04242024.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi

	printf "\nInstall inputs python3 module via pip3\n" | tee -a "$LOG_FILE"
	sudo apt update -y | tee -a "$LOG_FILE"
	sudo apt -y install python3-pip | tee -a "$LOG_FILE"
	pip3 --retries 10 -v install inputs | tee -a "$LOG_FILE"
	if [ $? != 0 ]; then
	  printf "\nThe update couldn't complete because the inputs python package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sleep 3
	  exit 1
	fi
	sudo systemctl daemon-reload

	printf "\nAdd MESS core as additional core for Apple2\n" | tee -a "$LOG_FILE"
	sed -i '/<core>applewin<\/core>/s//<core>applewin<\/core>\n\t           <core>mess<\/core>/' /etc/emulationstation/es_systems.cfg
	if test ! -z "$(cat /etc/fstab | grep roms2 | tr -d '\0')"
	then
	  mkdir -pv /roms2/bios/mame/hash | tee -a "$LOG_FILE"
	  cp -fv /roms/bios/mame/hash/apple2* /roms2/bios/mame/hash/ | tee -a "$LOG_FILE"
	fi

	printf "\nCopy correct PPSSPPSDL-2021 for device\n" | tee -a "$LOG_FILE"
	if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
      rm -fv /opt/ppsspp-2021/PPSSPPSDL.rk3326 | tee -a "$LOG_FILE"
    else
      mv -fv /opt/ppsspp-2021/PPSSPPSDL.rk3326 /opt/ppsspp-2021/PPSSPPSDL | tee -a "$LOG_FILE"
	fi

	printf "\nCopy correct scummvm for device\n" | tee -a "$LOG_FILE"
	if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
      rm -fv /opt/scummvm/scummvm.rk3326 | tee -a "$LOG_FILE"
    else
      mv -fv /opt/scummvm/scummvm.rk3326 /opt/scummvm/scummvm | tee -a "$LOG_FILE"
	fi

	printf "\nCopy correct emulationstation depending on device\n" | tee -a "$LOG_FILE"
	if [ -f "/boot/rk3326-r33s-linux.dtb" ] || [ -f "/boot/rk3326-r35s-linux.dtb" ] || [ -f "/boot/rk3326-r36s-linux.dtb" ] || [ -f "/boot/rk3326-rg351v-linux.dtb" ] || [ -f "/boot/rk3326-rg351mp-linux.dtb" ] || [ -f "/boot/rk3326-gameforce-linux.dtb" ]; then
	  sudo mv -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	  sudo chmod -v 755 /opt/ppsspp-2021/PPSSPPSDL*
	  sudo depmod
	elif [ -f "/boot/rk3326-odroidgo2-linux.dtb" ] || [ -f "/boot/rk3326-odroidgo2-linux-v11.dtb" ] || [ -f "/boot/rk3326-odroidgo3-linux.dtb" ]; then
	  test=$(stat -c %s "/usr/bin/emulationstation/emulationstation")
	  if [ "$test" = "3416928" ]; then
	    sudo cp -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  elif [ -f "/home/ark/.config/.DEVICE" ]; then
		sudo cp -fv /home/ark/emulationstation.rgb10max /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  else
	    sudo cp -fv /home/ark/emulationstation.header /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  fi
	  if [ -f "/home/ark/.config/.DEVICE" ]; then
	    sudo cp -fv /home/ark/emulationstation.rgb10max /usr/bin/emulationstation/emulationstation.header | tee -a "$LOG_FILE"
	  else
	    sudo cp -fv /home/ark/emulationstation.header /usr/bin/emulationstation/emulationstation.header | tee -a "$LOG_FILE"
	  fi
	  sudo cp -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation.fullscreen | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	elif [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
	  sudo mv -fv /home/ark/emulationstation.503 /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	fi

	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth

	touch "/home/ark/.config/.update04242024"
fi
if [ ! -f "/home/ark/.config/.update05242024" ]; then

	printf "\nUpdate RGB30 v2 dtb file to fix potential reboot after shutdown issue\nUpdate Mupen64plus Standalone\nUpdate Fix Audio tool\nUpdate Wifi.sh\nUpdate gamecontrollerdb.txt for inttools\nFix SD2 when used with JELOS and ROCKNIX\nUpdated filebrowser to 2.30.0\nUpdate Xbox Series X Controller profile\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/05242024/arkosupdate05242024.zip -O /dev/shm/arkosupdate05242024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate05242024.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate05242024.zip" ]; then
	  if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
	    if [ ! -z "$(grep "RGB30" /home/ark/.config/.DEVICE | tr -d '\0')" ]; then
          sudo unzip -X -o /dev/shm/arkosupdate05242024.zip -d / | tee -a "$LOG_FILE"
	      if [ -f "/home/ark/.config/.V2DTBLOADED" ]; then
	        printf "\nThis seems to be a RGB30 V2 unit.  Copying the updated V2 dtb to the boot partition.\n" | tee -a "$LOG_FILE"
		    sudo cp -fv /usr/local/bin/rgb30dtbs/rk3566-rgb30.dtb.v2 /boot/rk3566-OC.dtb | tee -a "$LOG_FILE"
		  fi
	    else
		  sudo unzip -X -o /dev/shm/arkosupdate05242024.zip -x usr/local/bin/rgb30dtbs/rk3566-rgb30.dtb.v2 -d / | tee -a "$LOG_FILE"
	    fi
	  else
		sudo unzip -X -o /dev/shm/arkosupdate05242024.zip -x usr/local/bin/rgb30dtbs/rk3566-rgb30.dtb.v2 opt/system/Advanced/Fix\ Audio.sh usr/local/bin/round_end.wav home/ark/.config/retroarch32/autoconfig/udev/Xbox\ Series\ X\ Controller.cfg home/ark/.config/retroarch/autoconfig/udev/Xbox\ Series\ X\ Controller.cfg -d / | tee -a "$LOG_FILE"
	  fi
	  if [ -f "/usr/local/bin/Switch to SD2 for Roms.sh" ]; then
	    printf "\nFix Switch to SD2 for Roms script in /usr/local/bin\n" | tee -a "$LOG_FILE"
	    sudo sed -i '/sudo rm -rf/s//#sudo rm -rf/g' /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh
	    sudo sed -i '/sudo tar -xvkf/s//sudo tar --strip-components=1 -xvkf/g' /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh
	    sudo sed -i '/sudo mv -v -f -n/s//#sudo mv -v -f -n/g' /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh
	  fi
	  if [ -f "/opt/system/Advanced/Switch to SD2 for Roms.sh" ]; then
	    printf "\nFix Switch to SD2 for Roms script in /opt/system/Advanced\n" | tee -a "$LOG_FILE"
	    sudo sed -i '/sudo rm -rf/s//#sudo rm -rf/g' /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh
	    sudo sed -i '/sudo tar -xvkf/s//sudo tar --strip-components=1 -xvkf/g' /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh
	    sudo sed -i '/sudo mv -v -f -n/s//#sudo mv -v -f -n/g' /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh
	  fi
	  sudo rm -fv /dev/shm/arkosupdate05242024.zip | tee -a "$LOG_FILE"
	  cp -v /etc/emulationstation/es_systems.cfg /etc/emulationstation/es_systems.cfg.update04242024.bak
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate05242024.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi
	
	if [ -f "/opt/system/Advanced/Switch to SD2 for Roms.sh" ]; then
		sudo mv "/opt/system/Advanced/Read from SD1 and SD2 for Roms.sh" "/opt/system/Advanced/Read from SD1 and SD2 for Roms"
	else
		echo "File 'Switch to SD2 for Roms.sh' not found. No action taken."
	fi
	
	printf "\nUpdate port launching in es_systems.cfg to support alternate SDL versions\n" | tee -a "$LOG_FILE"
	sed -i '/nice -n -19 %ROM%/s//nice -n -19 \/usr\/local\/bin\/AltSDL.sh %ROM%/g' /etc/emulationstation/es_systems.cfg

	printf "\nAdd support for game launch images using scraped images\n" | tee -a "$LOG_FILE"
sed -i 's/sudo perfmax \%GOVERNOR\%;/sudo perfmax \%GOVERNOR\% \%ROM\%;/' /etc/emulationstation/es_systems.cfg

if [ -f "/opt/system/Switch Launchimage to ascii.sh" ] && [ -f "/opt/system/Switch Launchimage to pic.sh" ]; then
  touch /home/ark/.config/.GameLoadingIModeGIF
  echo "<string name=\"GameLoadingIMode\" value=\"gif\" />" >> /home/ark/.emulationstation/es_settings.cfg
elif [ -f "/opt/system/Switch Launchimage to ascii.sh" ] && [ -f "/opt/system/Switch Launchimage to gif.sh" ]; then
  touch /home/ark/.config/.GameLoadingIModePIC
  echo "<string name=\"GameLoadingIMode\" value=\"pic\" />" >> /home/ark/.emulationstation/es_settings.cfg
elif [ -f "/opt/system/Switch Launchimage to gif.sh" ] && [ -f "/opt/system/Switch Launchimage to pic.sh" ]; then
  touch /home/ark/.config/.GameLoadingIModeASCII
  echo "<string name=\"GameLoadingIMode\" value=\"ascii\" />" >> /home/ark/.emulationstation/es_settings.cfg
fi

rm -fv /opt/system/Switch\ Launchimage\ to* | tee -a "$LOG_FILE"

	printf "\nInstall and link new SDL 2.0.3000.3 (aka SDL 2.0.30.3)\n" | tee -a "$LOG_FILE"
	if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
	  sudo mv -f -v /home/ark/sdl2-64/libSDL2-2.0.so.0.3000.3.rk3566 /usr/lib/aarch64-linux-gnu/libSDL2-2.0.so.0.3000.3 | tee -a "$LOG_FILE"
	  sudo mv -f -v /home/ark/sdl2-32/libSDL2-2.0.so.0.3000.3.rk3566 /usr/lib/arm-linux-gnueabihf/libSDL2-2.0.so.0.3000.3 | tee -a "$LOG_FILE"
	  sudo rm -rfv /home/ark/sdl2-32 | tee -a "$LOG_FILE"
	  sudo rm -rfv /home/ark/sdl2-64 | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/aarch64-linux-gnu/libSDL2.so /usr/lib/aarch64-linux-gnu/libSDL2-2.0.so.0 | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/aarch64-linux-gnu/libSDL2-2.0.so.0.3000.3 /usr/lib/aarch64-linux-gnu/libSDL2.so | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/arm-linux-gnueabihf/libSDL2.so /usr/lib/arm-linux-gnueabihf/libSDL2-2.0.so.0 | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/arm-linux-gnueabihf/libSDL2-2.0.so.0.3000.3 /usr/lib/arm-linux-gnueabihf/libSDL2.so | tee -a "$LOG_FILE"
	elif [ -f "/boot/rk3326-rg351v-linux.dtb" ] || [ -f "/boot/rk3326-rg351mp-linux.dtb" ] || [ -f "/boot/rk3326-r33s-linux.dtb" ] || [ -f "/boot/rk3326-r35s-linux.dtb" ] || [ -f "/boot/rk3326-r36s-linux.dtb" ] || [ -f "/boot/rk3326-gameforce-linux.dtb" ]; then
	  sudo mv -f -v /home/ark/sdl2-64/libSDL2-2.0.so.0.3000.3.rk3326 /usr/lib/aarch64-linux-gnu/libSDL2-2.0.so.0.3000.3 | tee -a "$LOG_FILE"
	  sudo mv -f -v /home/ark/sdl2-32/libSDL2-2.0.so.0.3000.3.rk3326 /usr/lib/arm-linux-gnueabihf/libSDL2-2.0.so.0.3000.3 | tee -a "$LOG_FILE"
	  sudo rm -rfv /home/ark/sdl2-32 | tee -a "$LOG_FILE"
	  sudo rm -rfv /home/ark/sdl2-64 | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/aarch64-linux-gnu/libSDL2.so /usr/lib/aarch64-linux-gnu/libSDL2-2.0.so.0 | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/aarch64-linux-gnu/libSDL2-2.0.so.0.3000.3 /usr/lib/aarch64-linux-gnu/libSDL2.so | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/arm-linux-gnueabihf/libSDL2.so /usr/lib/arm-linux-gnueabihf/libSDL2-2.0.so.0 | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/arm-linux-gnueabihf/libSDL2-2.0.so.0.3000.3 /usr/lib/arm-linux-gnueabihf/libSDL2.so | tee -a "$LOG_FILE"
	else
	  sudo mv -f -v /home/ark/sdl2-64/libSDL2-2.0.so.0.3000.3.rotated /usr/lib/aarch64-linux-gnu/libSDL2-2.0.so.0.3000.3 | tee -a "$LOG_FILE"
	  sudo mv -f -v /home/ark/sdl2-32/libSDL2-2.0.so.0.3000.3.rotated /usr/lib/arm-linux-gnueabihf/libSDL2-2.0.so.0.3000.3 | tee -a "$LOG_FILE"
	  sudo rm -rfv /home/ark/sdl2-64 | tee -a "$LOG_FILE"
	  sudo rm -rfv /home/ark/sdl2-32 | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/aarch64-linux-gnu/libSDL2.so /usr/lib/aarch64-linux-gnu/libSDL2-2.0.so.0 | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/aarch64-linux-gnu/libSDL2-2.0.so.0.3000.3 /usr/lib/aarch64-linux-gnu/libSDL2.so | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/arm-linux-gnueabihf/libSDL2.so /usr/lib/arm-linux-gnueabihf/libSDL2-2.0.so.0 | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/arm-linux-gnueabihf/libSDL2-2.0.so.0.3000.3 /usr/lib/arm-linux-gnueabihf/libSDL2.so | tee -a "$LOG_FILE"
	fi

	printf "\nCopy correct mupen64plus standalone for the chipset and adjust some GlideN64 related settings\n" | tee -a "$LOG_FILE"

	printf "\nCopy correct Hypseus-Singe for device\n" | tee -a "$LOG_FILE"

	printf "\nCopy correct emulationstation depending on device\n" | tee -a "$LOG_FILE"
	if [ -f "/boot/rk3326-r33s-linux.dtb" ] || [ -f "/boot/rk3326-r35s-linux.dtb" ] || [ -f "/boot/rk3326-r36s-linux.dtb" ] || [ -f "/boot/rk3326-rg351v-linux.dtb" ] || [ -f "/boot/rk3326-rg351mp-linux.dtb" ] || [ -f "/boot/rk3326-gameforce-linux.dtb" ]; then
	  sudo mv -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	elif [ -f "/boot/rk3326-odroidgo2-linux.dtb" ] || [ -f "/boot/rk3326-odroidgo2-linux-v11.dtb" ] || [ -f "/boot/rk3326-odroidgo3-linux.dtb" ]; then
	  test=$(stat -c %s "/usr/bin/emulationstation/emulationstation")
	  if [ "$test" = "3416928" ]; then
	    sudo cp -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  elif [ -f "/home/ark/.config/.DEVICE" ]; then
		sudo cp -fv /home/ark/emulationstation.rgb10max /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  else
	    sudo cp -fv /home/ark/emulationstation.header /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  fi
	  if [ -f "/home/ark/.config/.DEVICE" ]; then
	    sudo cp -fv /home/ark/emulationstation.rgb10max /usr/bin/emulationstation/emulationstation.header | tee -a "$LOG_FILE"
	  else
	    sudo cp -fv /home/ark/emulationstation.header /usr/bin/emulationstation/emulationstation.header | tee -a "$LOG_FILE"
	  fi
	  sudo cp -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation.fullscreen | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	elif [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
	  sudo mv -fv /home/ark/emulationstation.503 /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	fi

	printf "\nInstall Freeglut3 for Yabasanshiro\n \n Fix permissions and dependency modules\n" | tee -a "$LOG_FILE"
	apt-get install freeglut3
	sudo chown -R ark:ark /home/ark && sudo chmod -R 755 /home/ark | tee -a "$LOG_FILE"
	sudo chown -R ark:ark /opt && sudo chmod -R 755 /opt | tee -a "$LOG_FILE"
	sudo chmod -R 755 /usr/local/bin/ | tee -a "$LOG_FILE"
	sudo chmod -v 0755 "/opt/system/Set Launchimage to gif.sh" | tee -a "$LOG_FILE"
	sudo chmod -v 0755 "/opt/system/Set Launchimage to vid.sh" | tee -a "$LOG_FILE"
	sudo depmod
	
	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth

	touch "/home/ark/.config/.update05242024"
	fi
	
	if [ ! -f "/home/ark/.config/.update06272024" ]; then

	printf "\nUpdate Retroarch and Retroarch32 to 1.19.1\nUpdate Emulationstation\nUpdate Ondemand cpu governor threshold and sampling factor\nFix ALG no longer launching since last update\nAdd Ardens libreto core for Arduboy\nAdd japanese translation for ES\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/06272024/arkosupdate06272024.zip -O /dev/shm/arkosupdate06272024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate06272024.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate06272024.zip" ]; then
	  sudo unzip -X -o /dev/shm/arkosupdate06272024.zip -d / | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate06272024.zip | tee -a "$LOG_FILE"
	  cp -v /etc/emulationstation/es_systems.cfg /etc/emulationstation/es_systems.cfg.update06272024.bak
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate06272024.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi

	printf "\nCopy Retroarches\n" | tee -a "$LOG_FILE"
	  cp -fv /opt/retroarch/bin/retroarch32.rk3326.unrot /opt/retroarch/bin/retroarch32 | tee -a "$LOG_FILE"
	  cp -fv /opt/retroarch/bin/retroarch.rk3326.unrot /opt/retroarch/bin/retroarch | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch.* | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch32.* | tee -a "$LOG_FILE"

	printf "\nRemove MS-DOS and PS1 extension changing scripts\n" | tee -a "$LOG_FILE"
	if [ -f "/opt/system/PS1 - Show only m3u games.sh" ]; then
	  sudo rm -fv /opt/system/PS1\ -\ Show\ only\ m3u\ games.sh | tee -a "$LOG_FILE"
	  sudo rm -rf /usr/local/bin/PS1\ -\ Show\ only\ m3u\ games.sh | tee -a "$LOG_FILE"
	  sudo rm -fv /usr/local/bin/PS1\ -\ Show\ all\ games.sh | tee -a "$LOG_FILE"
	else
	  sed -i '/<extension>.m3u .M3U<\/extension>/s//<extension>.cue .CUE .img .IMG .mdf .MDF .pbp .PBP .toc .TOC .cbn .CBN .m3u .M3U .ccd .CCD .chd .CHD .zip .ZIP .7z .7Z .iso .ISO<\/extension>/' /etc/emulationstation/es_systems.cfg
	  sudo rm -fv /opt/system/PS1\ -\ Show\ all\ games.sh | tee -a "$LOG_FILE"
	  sudo rm -rf /usr/local/bin/PS1\ -\ Show\ only\ m3u\ games.sh | tee -a "$LOG_FILE"
	  sudo rm -fv /usr/local/bin/PS1\ -\ Show\ all\ games.sh | tee -a "$LOG_FILE"
	fi
	if [ -f "/opt/system/MSDOS - Hide zip games.sh" ]; then
	  sudo rm -fv /opt/system/MSDOS\ -\ Hide\ zip\ games.sh | tee -a "$LOG_FILE"
	  sudo rm -fv /usr/local/bin/MSDOS\ -\ Show\ zip\ games.sh | tee -a "$LOG_FILE"
	  sudo rm -fv /usr/local/bin/MSDOS\ -\ Hide\ zip\ games.sh | tee -a "$LOG_FILE"
	else
	  sed -i '/<extension>.exe .EXE .com .COM .bat .BAT .conf .CONF .cue .CUE .iso .ISO .m3u .M3U .dosz .DOSZ<\/extension>/s//<extension>.exe .EXE .com .COM .bat .BAT .conf .CONF .cue .CUE .iso .ISO .zip .ZIP .m3u .M3U .dosz .DOSZ<\/extension>/' /etc/emulationstation/es_systems.cfg
	  sudo rm -fv /opt/system/MSDOS\ -\ Show\ zip\ games.sh
	  sudo rm -fv /usr/local/bin/MSDOS\ -\ Show\ zip\ games.sh | tee -a "$LOG_FILE"
	  sudo rm -fv /usr/local/bin/MSDOS\ -\ Hide\ zip\ games.sh | tee -a "$LOG_FILE"
	fi

	printf "\nAdd .7z .7Z .zip and .ZIP as supported extensions for N64\n" | tee -a "$LOG_FILE"

	if [ -f "/usr/local/bin/Switch to SD2 for Roms.sh" ]; then
    sudo rm -fv /etc/emulationstation/es_systems.cfg.single | tee -a "$LOG_FILE"
	sudo rm -fv /etc/emulationstation/es_systems.cfg.dual | tee -a "$LOG_FILE"
	cp -fv /usr/local/bin/es_systems.cfg /etc/emulationstation/es_systems.cfg | tee -a "$LOG_FILE"
	cp -fv /usr/local/bin/es_systems.cfg.dual /etc/emulationstation/es_systems.cfg.dual | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because you didn't switch to main sd first before updating. You should really read the warning beforehand." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate06272024.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi

	sudo apt -y update && sudo apt -y install p7zip-full | tee -a "$LOG_FILE"

	printf "\nAdd ardens as additional emulator for arduboy\n" | tee -a "$LOG_FILE"
	sed -i 's/<command>sudo perfmax \%GOVERNOR\% \%ROM\%; nice -n -19 \/usr\/local\/bin\/retroarch -L \/home\/ark\/.config\/retroarch\/cores\/arduous_libretro.so \%ROM\%; sudo perfnorm<\/command>/<command>sudo perfmax \%GOVERNOR\% \%ROM\%; nice -n -19 \/usr\/local\/bin\/\%EMULATOR\% -L \/home\/ark\/.config\/\%EMULATOR\%\/cores\/\%CORE\%_libretro.so \%ROM\%; sudo perfnorm<\/command>\n\t\t   <emulators>\n\t\t      <emulator name=\"retroarch\">\n\t\t \t<cores>\n\t\t \t  <core>ardens<\/core>\n\t\t \t  <core>arduous<\/core>\n\t\t \t<\/cores>\n\t\t      <\/emulator>\n\t\t   <\/emulators>/' /etc/emulationstation/es_systems.cfg

	printf "\nCopy correct emulationstation depending on device\n" | tee -a "$LOG_FILE"
	  sudo mv -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	  
	printf "\nFix Permissions\n" | tee -a "$LOG_FILE"
	  sudo chmod -R 755 /usr/local/bin/ | tee -a "$LOG_FILE"
	  sudo chmod -v 755 /opt/mupen64plus/InputAutoCfg.ini | tee -a "$LOG_FILE"
	  sudo chmod -v 755 /opt/mupen64plus/mupen64plus.ini | tee -a "$LOG_FILE"
	  
	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth

	touch "/home/ark/.config/.update06272024"
fi

if [ ! -f "/home/ark/.config/.update07042024" ]; then

	printf "\nFix slow loading of ES when many ports are loaded and game count when filtering extensions\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/07042024/arkosupdate07042024.zip -O /dev/shm/arkosupdate07042024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate07042024.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate07042024.zip" ]; then
	  sudo unzip -X -o /dev/shm/arkosupdate07042024.zip -d / | tee -a "$LOG_FILE"
	  cp -v /etc/emulationstation/es_systems.cfg /etc/emulationstation/es_systems.cfg.update07042024.bak
	  sudo rm -fv /dev/shm/arkosupdate07042024.zip | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate07042024.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi

	if test -z "$(cat /etc/emulationstation/es_systems.cfg | grep 'km_fbneo_xtreme_amped' | tr -d '\0')"
	then
	  printf "\nAdd fbneo xtreme core as an optional core wherever fbneo is currently available\n" | tee -a "$LOG_FILE"
	  sed -i '/<core>fbneo<\/core>/c\\t\t\t  <core>fbneo<\/core>\n\t\t\t  <core>km_fbneo_xtreme_amped<\/core>' /etc/emulationstation/es_systems.cfg
	fi

	printf "\nCopy correct emulationstation depending on device\n" | tee -a "$LOG_FILE"
	
	  sudo mv -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	

	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth

	touch "/home/ark/.config/.update07042024"
	fi

if [ ! -f "/home/ark/.config/.update07312024" ]; then

	printf "\nUpdate French translation for Emulationstation\nUpdate Korean translation for Emulationstation\nUpdate Spanish translation for Emulationstation\nUpdate Portuguese translation for Emulationstation\nUpdate emulationstation to fix translation for gamelist option video\nAdd Sharp-Shimmerless-Shader for retroarch and retroarch32\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/07312024/arkosupdate07312024.zip -O /dev/shm/arkosupdate07312024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate07312024.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate07312024.zip" ]; then
		if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
		  sudo unzip -X -o /dev/shm/arkosupdate07312024.zip -d / | tee -a "$LOG_FILE"
		else
		  sudo unzip -X -o /dev/shm/arkosupdate07312024.zip -x opt/mupen64plus/mupen64plus-video-rice.so -d / | tee -a "$LOG_FILE"
		fi
	  sudo rm -fv /dev/shm/arkosupdate07312024.zip | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate07312024.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi
	
	if test -z "$(grep "chimerasnes" /etc/emulationstation/es_systems.cfg | tr -d '\0')"
	then
		cp -v /etc/emulationstation/es_systems.cfg /etc/emulationstation/es_systems.cfg.update07312024.bak | tee -a "$LOG_FILE"
		sed -i '/<core>snes9x2010<\/core>/c\\t\t\t  <core>snes9x2010<\/core>\n\t\t\t  <core>chimerasnes<\/core>' /etc/emulationstation/es_systems.cfg
	fi

	if [ ! -z "$(grep "RGB30" /home/ark/.config/.DEVICE | tr -d '\0')" ]; then
		if test -z "$(grep "VerticalOffset" /home/ark/.config/mupen64plus/mupen64plus.cfg | tr -d '\0')"
		then
		  printf "\nAdd vertical offset setting for Mupen64plus standalone for RGB30\n" | tee -a "$LOG_FILE"
		  sed -i "/\[Video-Rice\]/c\\[Video-Rice\]\n\n\# Hack to adjust vertical offset for screens like on the RGB30\nVerticalOffset \= \"125\"" /home/ark/.config/mupen64plus/mupen64plus.cfg
		fi
	fi

	printf "\nCopy correct emulationstation depending on device\n" | tee -a "$LOG_FILE"
	  sudo mv -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"

	if [ ! -z "$(cat /etc/emulationstation/es_input.cfg | grep "190000004b4800000010000001010000" | tr -d '\0')" ]; then
		printf "\nUpdate option 9 description in BaRT to include V10\n" | tee -a "$LOG_FILE"
		sudo sed -i "/RGB10 mode/s//RGB10\/V10 mode/" /usr/bin/emulationstation/emulationstation.sh*
	fi

	sudo chmod -R 755 /usr/local/bin/ | tee -a "$LOG_FILE"
	
	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth

	touch "/home/ark/.config/.update07312024"
fi

if [ ! -f "/home/ark/.config/.update08232024" ]; then

	printf "\nAdd vmac emulator\nAdd emuscv emulator\nAdd piemu emulator\nAdd minivmac emulator\nUpdate nes-box theme\nUpdate singe.sh file to support reading game.commands file\nUpdate Fake-08 emulator\nAdd smsplus-gx libretro core\nAdd hatarib libretro core\nUpdate nes-box theme\nUpdate wifi script\nFix Backup and Restore ArkOS settings funciton in BaRT\nUpdated apple2.sh script to support .hdv and .HDV\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
	  sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/08232024/arkosupdate-kodi08232024.zip -O /dev/shm/arkosupdate-kodi08232024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate-kodi08232024.zip | tee -a "$LOG_FILE"
	  sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/08232024/arkosupdate-kodi08232024.z01 -O /dev/shm/arkosupdate-kodi08232024.z01 -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate-kodi08232024.z01 | tee -a "$LOG_FILE"
	  if [ -f "/dev/shm/arkosupdate-kodi08232024.zip" ] && [ -f "/dev/shm/arkosupdate-kodi08232024.z01" ]; then
	    zip -FF /dev/shm/arkosupdate-kodi08232024.zip --out /dev/shm/arkosupdate08232024.zip -fz | tee -a "$LOG_FILE"
		sudo rm -fv /dev/shm/arkosupdate-kodi08232024.z* | tee -a "$LOG_FILE"
	  else
		printf "\nThe update couldn't complete because the packages did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
		sudo rm -fv /dev/shm/arkosupdate* | tee -a "$LOG_FILE"
		sleep 3
		echo $c_brightness > /sys/class/backlight/backlight/brightness
		exit 1
	  fi
	else
	  sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/08232024/arkosupdate08232024.zip -O /dev/shm/arkosupdate08232024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate08232024.zip | tee -a "$LOG_FILE"
	fi
	if [ -f "/dev/shm/arkosupdate08232024.zip" ]; then
	  if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
	    rm -rf /opt/kodi/lib/kodi/addons/* /opt/kodi/share/kodi/addons/* /opt/kodi/lib/addons/* /opt/kodi/lib/pkgconfig/* /opt/kodi/lib/libdumb.a | tee -a "$LOG_FILE"
	    sudo unzip -X -o /dev/shm/arkosupdate08232024.zip -d / | tee -a "$LOG_FILE"
		if [ "$(cat ~/.config/.DEVICE)" = "RG353M" ] || [ "$(cat ~/.config/.DEVICE)" = "RG353V" ] || [ "$(cat ~/.config/.DEVICE)" = "RK2023" ] || [ "$(cat ~/.config/.DEVICE)" = "RGB30" ]; then
		  sed -i '/<res width\="1920" height\="1440" aspect\="4:3"/s//<res width\="1623" height\="1180" aspect\="4:3"/g' /opt/kodi/share/kodi/addons/skin.estuary/addon.xml
		fi
		sed -i '/skin.estouchy/d' /opt/kodi/share/kodi/system/addon-manifest.xml
	  else
	    sudo unzip -X -o /dev/shm/arkosupdate08232024.zip -d / | tee -a "$LOG_FILE"
	  fi
	  printf "\nAdd piece emulator\n" | tee -a "$LOG_FILE"
	  if test -z "$(cat /etc/emulationstation/es_systems.cfg | grep 'piece' | tr -d '\0')"
	  then
	    cp -v /etc/emulationstation/es_systems.cfg /etc/emulationstation/es_systems.cfg.update08232024.bak | tee -a "$LOG_FILE"
	    sed -i -e '/<theme>palm<\/theme>/{r /home/ark/add_piece.txt' -e 'd}' /etc/emulationstation/es_systems.cfg
	  fi
	  if [ ! -d "/roms/piece" ]; then
	    mkdir -v /roms/piece | tee -a "$LOG_FILE"
	    if test ! -z "$(cat /etc/fstab | grep roms2 | tr -d '\0')"
	    then
		  if [ ! -d "/roms2/piece" ]; then
		    mkdir -v /roms2/piece | tee -a "$LOG_FILE"
		    sed -i '/<path>\/roms\/piece/s//<path>\/roms2\/piece/g' /etc/emulationstation/es_systems.cfg
		  fi
	    fi
	  fi
	  if [ -f "/opt/system/Advanced/Switch to SD2 for Roms.sh" ]; then
	    if test -z "$(cat /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | grep piece | tr -d '\0')"
	    then
		  sudo chown -v ark:ark /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | tee -a "$LOG_FILE"
		  sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/piece\/" ]\; then\n      sudo mkdir \/roms2\/piece\n  fi\n  sudo pkill filebrowser/' /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh
	    else
		  printf "\npiece is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	    fi
	  fi
	  if [ -f "/usr/local/bin/Switch to SD2 for Roms.sh" ]; then
	    if test -z "$(cat /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh | grep piece | tr -d '\0')"
	    then
		  sudo sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/piece\/" ]\; then\n      sudo mkdir \/roms2\/piece\n  fi\n  sudo pkill filebrowser/' /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh
	    else
		  printf "\npiece is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	    fi
	  fi
	  printf "\nAdd Super Cassette Vision emulator\n" | tee -a "$LOG_FILE"
	  if test -z "$(cat /etc/emulationstation/es_systems.cfg | grep 'emuscv' | tr -d '\0')"
	  then
	    cp -v /etc/emulationstation/es_systems.cfg /etc/emulationstation/es_systems.cfg.update08232024-1.bak | tee -a "$LOG_FILE"
	    sed -i -e '/<theme>easyrpg<\/theme>/{r /home/ark/add_emuscv.txt' -e 'd}' /etc/emulationstation/es_systems.cfg
	  fi
	  if [ ! -d "/roms/scv" ]; then
	    mkdir -v /roms/scv | tee -a "$LOG_FILE"
	    if test ! -z "$(cat /etc/fstab | grep roms2 | tr -d '\0')"
	    then
		  if [ ! -d "/roms2/scv" ]; then
		    mkdir -v /roms2/scv | tee -a "$LOG_FILE"
		    sed -i '/<path>\/roms\/scv/s//<path>\/roms2\/scv/g' /etc/emulationstation/es_systems.cfg
		  fi
	    fi
	  fi
	  if [ -f "/opt/system/Advanced/Switch to SD2 for Roms.sh" ]; then
	    if test -z "$(cat /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | grep scv | tr -d '\0')"
	    then
		  sudo chown -v ark:ark /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | tee -a "$LOG_FILE"
		  sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/scv\/" ]\; then\n      sudo mkdir \/roms2\/scv\n  fi\n  sudo pkill filebrowser/' /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh
	    else
		  printf "\nSuper Cassette Vision is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	    fi
	  fi
	  if [ -f "/usr/local/bin/Switch to SD2 for Roms.sh" ]; then
	    if test -z "$(cat /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh | grep scv | tr -d '\0')"
	    then
		  sudo sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/scv\/" ]\; then\n      sudo mkdir \/roms2\/scv\n  fi\n  sudo pkill filebrowser/' /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh
	    else
		  printf "\nSuper Cassette Vision is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	    fi
	  fi
	  printf "\nAdd Macintosh emulator\n" | tee -a "$LOG_FILE"
	  if test -z "$(cat /etc/emulationstation/es_systems.cfg | grep 'vmac' | tr -d '\0')"
	  then
	    cp -v /etc/emulationstation/es_systems.cfg /etc/emulationstation/es_systems.cfg.update08232024-2.bak | tee -a "$LOG_FILE"
	    sed -i -e '/<theme>apple2<\/theme>/{r /home/ark/add_vmac.txt' -e 'd}' /etc/emulationstation/es_systems.cfg
	  fi
	  if [ ! -d "/roms/vmac" ]; then
	    mkdir -v /roms/vmac | tee -a "$LOG_FILE"
	    if test ! -z "$(cat /etc/fstab | grep roms2 | tr -d '\0')"
	    then
		  if [ ! -d "/roms2/vmac" ]; then
		    mkdir -v /roms2/vmac | tee -a "$LOG_FILE"
		    sed -i '/<path>\/roms\/vmac/s//<path>\/roms2\/vmac/g' /etc/emulationstation/es_systems.cfg
		  fi
	    fi
	  fi
	  if [ -f "/opt/system/Advanced/Switch to SD2 for Roms.sh" ]; then
	    if test -z "$(cat /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | grep vmac | tr -d '\0')"
	    then
		  sudo chown -v ark:ark /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | tee -a "$LOG_FILE"
		  sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/vmac\/" ]\; then\n      sudo mkdir \/roms2\/vmac\n  fi\n  sudo pkill filebrowser/' /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh
	    else
		  printf "\nvmac is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	    fi
	  fi
	  if [ -f "/usr/local/bin/Switch to SD2 for Roms.sh" ]; then
	    if test -z "$(cat /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh | grep vmac | tr -d '\0')"
	    then
		  sudo sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/vmac\/" ]\; then\n      sudo mkdir \/roms2\/vmac\n  fi\n  sudo pkill filebrowser/' /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh
	    else
		  printf "\nvmac is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	    fi
	  fi
	  sudo rm -fv /dev/shm/arkosupdate08232024.zip | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/add_piece.txt | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/add_emuscv.txt | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/add_vmac.txt | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate08232024.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi

	if test -z "$(grep 'smsplus' /etc/emulationstation/es_systems.cfg | tr -d '\0')"
	then
	  printf "\nAdd smsplus-gx libreto for mastersystem and gamegear to ES\n" | tee -a "$LOG_FILE"
	  sed -i '/<core>gearsystem<\/core>/c\\t\t\t  <core>gearsystem<\/core>\n\t\t\t  <core>smsplus<\/core>' /etc/emulationstation/es_systems.cfg
	fi

	printf "\nAdd hatarib libretro emulator for Atari ST\n" | tee -a "$LOG_FILE"
	if test -z "$(cat /etc/emulationstation/es_systems.cfg | grep -w 'hatarib' | tr -d '\0')"
	then
	  sed -i -e '/cores\/hatari_libretro.so/{r /home/ark/add_hatarib.txt' -e 'd}' /etc/emulationstation/es_systems.cfg
	  rm -fv /home/ark/add_hatarib.txt | tee -a "$LOG_FILE"
	  if test ! -z "$(cat /etc/fstab | grep roms2 | tr -d '\0')"
	  then
	    sudo cp -fv /roms/bios/etos192us.img /roms2/bios/etos192us.img | tee -a "$LOG_FILE"
	  fi
	  echo 'hatarib_borders = "0"' | tee -a /home/ark/.config/retroarch/retroarch-core-options.cfg
	  echo 'hatarib_pad1_select = "0"' | tee -a /home/ark/.config/retroarch/retroarch-core-options.cfg
	  echo 'hatarib_pad2_select = "0"' | tee -a /home/ark/.config/retroarch/retroarch-core-options.cfg
	  echo 'hatarib_pad3_select = "0"' | tee -a /home/ark/.config/retroarch/retroarch-core-options.cfg
	  echo 'hatarib_pad4_select = "0"' | tee -a /home/ark/.config/retroarch/retroarch-core-options.cfg
	  echo 'hatarib_pause_osk = "0"' | tee -a /home/ark/.config/retroarch/retroarch-core-options.cfg
	  echo 'hatarib_samplerate = "44100"' | tee -a /home/ark/.config/retroarch/retroarch-core-options.cfg
	  echo 'hatarib_statusbar = "0"' | tee -a /home/ark/.config/retroarch/retroarch-core-options.cfg
	  echo 'hatarib_tos = "<etos192us>"' | tee -a /home/ark/.config/retroarch/retroarch-core-options.cfg
	  echo 'hatarib_borders = "0"' | tee -a /home/ark/.config/retroarch/retroarch-core-options.cfg.bak
	  echo 'hatarib_pad1_select = "0"' | tee -a /home/ark/.config/retroarch/retroarch-core-options.cfg.bak
	  echo 'hatarib_pad2_select = "0"' | tee -a /home/ark/.config/retroarch/retroarch-core-options.cfg.bak
	  echo 'hatarib_pad3_select = "0"' | tee -a /home/ark/.config/retroarch/retroarch-core-options.cfg.bak
	  echo 'hatarib_pad4_select = "0"' | tee -a /home/ark/.config/retroarch/retroarch-core-options.cfg.bak
	  echo 'hatarib_pause_osk = "0"' | tee -a /home/ark/.config/retroarch/retroarch-core-options.cfg.bak
	  echo 'hatarib_samplerate = "44100"' | tee -a /home/ark/.config/retroarch/retroarch-core-options.cfg.bak
	  echo 'hatarib_statusbar = "0"' | tee -a /home/ark/.config/retroarch/retroarch-core-options.cfg.bak
	  echo 'hatarib_tos = "<etos192us>"' | tee -a /home/ark/.config/retroarch/retroarch-core-options.cfg.bak
	else
	  rm -fv /home/ark/add_hatarib.txt | tee -a "$LOG_FILE"
	fi

	printf "\nAdd quit hotkey daemon configuration for piemu\n" | tee -a "$LOG_FILE"
	sudo cp -fv /usr/local/bin/ti99keydemon.py /usr/local/bin/piemukeydemon.py | tee -a "$LOG_FILE"
	sudo chmod 777 /usr/local/bin/piemukeydemon.py
	sudo sed -i 's/pkill ti99sim-sdl/sudo kill -9 \$(pidof piemu)/' /usr/local/bin/piemukeydemon.py

		sudo chmod -v 0755 "/opt/system/Advanced/Restore Default Drastic Settings.sh" | tee -a "$LOG_FILE"
		sudo chown -v ark:ark "/opt/system/Advanced/Restore Default Drastic Settings.sh" | tee -a "$LOG_FILE"

	printf "\nCopy correct fake08 for device\n" | tee -a "$LOG_FILE"

      mv -fv /opt/fake08/fake08.rk3326 /opt/fake08/fake08 | tee -a "$LOG_FILE"
      rm -fv /opt/fake08/fake08.rk3566 | tee -a "$LOG_FILE"


	if test -z "$(cat /usr/bin/emulationstation/emulationstation.sh | grep '/opt/system/Advanced/"Backup ArkOS Settings.sh' | tr -d '\0')"
	then
	  printf "\nFix Backup and Restore ArkOS settings function in BaRT\n" | tee -a "$LOG_FILE"
	  sudo sed -i "/\"8)\") sudo reboot/s//\"6)\") sudo kill -9 \$(pidof boot_controls)\n                                \/opt\/system\/Advanced\/\"Backup ArkOS Settings.sh\" 2>\&1 > \/dev\/tty1\n                                sudo .\/boot_controls none \$param_device \&\n                                ;;\n                          \"7)\") sudo kill -9 \$(pidof boot_controls)\n                                \/opt\/system\/Advanced\/\"Restore ArkOS Settings.sh\" 2>\&1 > \/dev\/tty1\n                                sudo .\/boot_controls none \$param_device \&\n                                ;;\n                          \"8)\") sudo reboot/" /usr/bin/emulationstation/emulationstation.sh /usr/bin/emulationstation/emulationstation.sh.ra /usr/bin/emulationstation/emulationstation.sh.es
	fi
	
	printf "\nUpdate es_systems.cfg and es_systems.cfg.dual files for Read from Both Script\n" | tee -a "$LOG_FILE"
	sudo chmod -R 755 /opt/system/Advanced/ | tee -a "$LOG_FILE"
	sudo chmod -R 755 /usr/local/bin/ | tee -a "$LOG_FILE"
	sudo cp -fv /usr/local/bin/es_systems.cfg.dual /etc/emulationstation/es_systems.cfg.dual | tee -a "$LOG_FILE"
	sudo cp -fv /usr/local/bin/es_systems.cfg.single /etc/emulationstation/es_systems.cfg | tee -a "$LOG_FILE"
	sudo chmod -R 755 /opt/system/Wifi.sh | tee -a "$LOG_FILE"	


	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth

	touch "/home/ark/.config/.update08232024"
fi

if [ ! -f "/home/ark/.config/.update08232024-1" ]; then

	printf "\nFix Read from SD1 and SD2 for ROMS script and Permissions update for Wifi.sh for people that updated early.\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/08232024-1/arkosupdate08232024-1.zip -O /dev/shm/arkosupdate08232024-1.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate01272024-1.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate08232024-1.zip" ]; then
	  sudo unzip -X -o /dev/shm/arkosupdate08232024-1.zip -d / | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate* | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi

	printf "\nUpdate es_systems.cfg and es_systems.cfg.dual files for Read from Both Script\n" | tee -a "$LOG_FILE"
	sudo chmod -R 755 /opt/system/Wifi.sh | tee -a "$LOG_FILE"	
	sudo chmod -R 755 /opt/system/Advanced/ | tee -a "$LOG_FILE"
	sudo chmod -R 755 /usr/local/bin/ | tee -a "$LOG_FILE"
	sudo rm -f /etc/emulationstation/es_systems.cfg.dual | tee -a "$LOG_FILE"
	sudo rm -f /etc/emulationstation/es_systems.cfg | tee -a "$LOG_FILE"
	sudo cp -fv /usr/local/bin/es_systems.cfg.dual /etc/emulationstation/es_systems.cfg.dual | tee -a "$LOG_FILE"
	sudo cp -fv /usr/local/bin/es_systems.cfg.single /etc/emulationstation/es_systems.cfg | tee -a "$LOG_FILE"
	
#	printf "\nChange the default videoplayer to MPV\n" | tee -a "$LOG_FILE"
#	sudo apt-get install mpv socat --no-install-recommends -y | tee -a "$LOG_FILE"


	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth

	touch "/home/ark/.config/.update08232024-1"

fi
if [ ! -f "/home/ark/.config/.update09272024" ]; then

	printf "\nChange netplay check frame setting to 10 for rk3326 devices\nUpdate singe.sh to include -texturestream setting\nUpdate daphne.sh to include -texturestream setting\nUpdate netplay.sh\nOptimize hostapd.conf\nAdd Restore ECWolf joystick control tool\nUpdate Backup and Restore ArkOS Settings tools\nUpdate ES to add scraping for vircon32\nUpdate XRoar emulator to version 1.6.5\nFix Kodi 21 crash playing large movies\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/09272024/arkosupdate09272024.zip -O /dev/shm/arkosupdate09272024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate09272024.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate09272024.zip" ]; then
	  if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
		sudo unzip -X -o /dev/shm/arkosupdate09272024.zip -d / | tee -a "$LOG_FILE"
	    sudo rm -f /usr/lib/aarch64-linux-gnu/libass.so.9
	    sudo ln -sfv /usr/lib/aarch64-linux-gnu/libass.so.9.2.1 /usr/lib/aarch64-linux-gnu/libass.so.9
	  else
		sudo unzip -X -o /dev/shm/arkosupdate09272024.zip -x usr/lib/aarch64-linux-gnu/libass.so.9.2.1 -d / | tee -a "$LOG_FILE"
	  fi
	  printf "\nAdd PuzzleScript emulator\n" | tee -a "$LOG_FILE"
	  if test -z "$(cat /etc/emulationstation/es_systems.cfg | grep 'puzzlescript' | tr -d '\0')"
	  then
	    cp -v /etc/emulationstation/es_systems.cfg /etc/emulationstation/es_systems.cfg.update09272024.bak | tee -a "$LOG_FILE"
	    sed -i -e '/<theme>piece<\/theme>/{r /home/ark/add_puzzlescript.txt' -e 'd}' /etc/emulationstation/es_systems.cfg
	  fi
	  if [ ! -d "/roms/puzzlescript" ]; then
	    mkdir -v /roms/puzzlescript | tee -a "$LOG_FILE"
	    if test ! -z "$(cat /etc/fstab | grep roms2 | tr -d '\0')"
	    then
		  if [ ! -d "/roms2/puzzlescript" ]; then
		    mkdir -v /roms2/puzzlescript | tee -a "$LOG_FILE"
		    sed -i '/<path>\/roms\/puzzlescript/s//<path>\/roms2\/puzzlescript/g' /etc/emulationstation/es_systems.cfg
		  fi
	    fi
	  fi
	  if [ -f "/opt/system/Advanced/Switch to SD2 for Roms.sh" ]; then
	    if test -z "$(cat /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | grep puzzlescript | tr -d '\0')"
	    then
		  sudo chown -v ark:ark /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | tee -a "$LOG_FILE"
		  sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/puzzlescript\/" ]\; then\n      sudo mkdir \/roms2\/puzzlescript\n  fi\n  sudo pkill filebrowser/' /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh
	    else
		  printf "\npuzzlescript is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	    fi
	  fi
	  if [ -f "/usr/local/bin/Switch to SD2 for Roms.sh" ]; then
	    if test -z "$(cat /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh | grep puzzlescript | tr -d '\0')"
	    then
		  sudo sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/puzzlescript\/" ]\; then\n      sudo mkdir \/roms2\/puzzlescript\n  fi\n  sudo pkill filebrowser/' /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh
	    else
		  printf "\npuzzlescript is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	    fi
	  fi
	  printf "\nAdd Vircon32 emulator\n" | tee -a "$LOG_FILE"
	  if test -z "$(cat /etc/emulationstation/es_systems.cfg | grep 'vircon32' | tr -d '\0')"
	  then
	    cp -v /etc/emulationstation/es_systems.cfg /etc/emulationstation/es_systems.cfg.update09272024.bak | tee -a "$LOG_FILE"
	    sed -i -e '/<theme>tvc<\/theme>/{r /home/ark/add_vircon32.txt' -e 'd}' /etc/emulationstation/es_systems.cfg
	  fi
	  if [ ! -d "/roms/vircon32" ]; then
	    mkdir -v /roms/vircon32 | tee -a "$LOG_FILE"
	    if test ! -z "$(cat /etc/fstab | grep roms2 | tr -d '\0')"
	    then
		  if [ ! -d "/roms2/vircon32" ]; then
		    mkdir -v /roms2/vircon32 | tee -a "$LOG_FILE"
		    sed -i '/<path>\/roms\/vircon32/s//<path>\/roms2\/vircon32/g' /etc/emulationstation/es_systems.cfg
		  fi
	    fi
	  fi
	  if [ -f "/opt/system/Advanced/Switch to SD2 for Roms.sh" ]; then
	    if test -z "$(cat /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | grep vircon32 | tr -d '\0')"
	    then
		  sudo chown -v ark:ark /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | tee -a "$LOG_FILE"
		  sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/vircon32\/" ]\; then\n      sudo mkdir \/roms2\/vircon32\n  fi\n  sudo pkill filebrowser/' /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh
	    else
		  printf "\nVircon32 is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	    fi
	  fi
	  if [ -f "/usr/local/bin/Switch to SD2 for Roms.sh" ]; then
	    if test -z "$(cat /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh | grep vircon32 | tr -d '\0')"
	    then
		  sudo sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/vircon32\/" ]\; then\n      sudo mkdir \/roms2\/vircon32\n  fi\n  sudo pkill filebrowser/' /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh
	    else
		  printf "\nVircon32 is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	    fi
	  fi
	  sudo rm -fv /home/ark/add_vircon32.txt | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/add_puzzlescript.txt | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate09272024.zip | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate09272024.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi

	printf "\nAdd .m3u and .M3U to supported extensions for Amiga and Amiga CD32\n" | tee -a "$LOG_FILE"
	sed -i '/<extension>.adf .ADF .hdf .HDF .ipf .IPF .lha .LHA .zip .ZIP/s//<extension>.adf .ADF .hdf .HDF .ipf .IPF .lha .LHA .m3u .M3U .zip .ZIP/' /etc/emulationstation/es_systems.cfg
	sed -i '/<extension>.chd .CHD .cue .CUE .ccd .CCD .lha .LHA .nrg .NRG .mds .MDS .iso .ISO/s//<extension>.ccd .CCD .chd .CHD .cue .CUE .iso .ISO .lha .LHA .m3u .M3U .mds .MDS .nrg .NRG/' /etc/emulationstation/es_systems.cfg

	printf "\nCopy correct libretro puzzlescript core depending on device\n" | tee -a "$LOG_FILE"
	if [ ! -f "/boot/rk3566.dtb" ] && [ ! -f "/boot/rk3566-OC.dtb" ]; then
	  mv -fv /home/ark/.config/retroarch/cores/puzzlescript_libretro.so.rk3326 /home/ark/.config/retroarch/cores/puzzlescript_libretro.so | tee -a "$LOG_FILE"
	else
	  rm -fv /home/ark/.config/retroarch/cores/puzzlescript_libretro.so.rk3326 | tee -a "$LOG_FILE"
	fi

	if [ ! -f "/boot/rk3566.dtb" ] && [ ! -f "/boot/rk3566-OC.dtb" ]; then
	  printf "\nChange default netplay check frame setting to 10\n" | tee -a "$LOG_FILE"
	  sed -i '/netplay_check_frames \=/c\netplay_check_frames \= "10"' /home/ark/.config/retroarch/retroarch.cfg
	  sed -i '/netplay_check_frames \=/c\netplay_check_frames \= "10"' /home/ark/.config/retroarch32/retroarch.cfg
	  sed -i '/netplay_check_frames \=/c\netplay_check_frames \= "10"' /home/ark/.config/retroarch/retroarch.cfg.bak
	  sed -i '/netplay_check_frames \=/c\netplay_check_frames \= "10"' /home/ark/.config/retroarch32/retroarch.cfg.bak
	fi

	printf "\nCopy correct emulationstation depending on device\n" | tee -a "$LOG_FILE"
	if [ -f "/boot/rk3326-r33s-linux.dtb" ] || [ -f "/boot/rk3326-r35s-linux.dtb" ] || [ -f "/boot/rk3326-r36s-linux.dtb" ] || [ -f "/boot/rk3326-rg351v-linux.dtb" ] || [ -f "/boot/rk3326-rg351mp-linux.dtb" ] || [ -f "/boot/rk3326-gameforce-linux.dtb" ]; then
	  sudo mv -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	elif [ -f "/boot/rk3326-odroidgo2-linux.dtb" ] || [ -f "/boot/rk3326-odroidgo2-linux-v11.dtb" ] || [ -f "/boot/rk3326-odroidgo3-linux.dtb" ]; then
	  test=$(stat -c %s "/usr/bin/emulationstation/emulationstation")
	  if [ "$test" = "3416928" ]; then
	    sudo cp -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  elif [ -f "/home/ark/.config/.DEVICE" ]; then
		sudo cp -fv /home/ark/emulationstation.rgb10max /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  else
	    sudo cp -fv /home/ark/emulationstation.header /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  fi
	  if [ -f "/home/ark/.config/.DEVICE" ]; then
	    sudo cp -fv /home/ark/emulationstation.rgb10max /usr/bin/emulationstation/emulationstation.header | tee -a "$LOG_FILE"
	  else
	    sudo cp -fv /home/ark/emulationstation.header /usr/bin/emulationstation/emulationstation.header | tee -a "$LOG_FILE"
	  fi
	  sudo cp -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation.fullscreen | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	elif [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
	  sudo mv -fv /home/ark/emulationstation.503 /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	fi

	printf "\nInstall and link new SDL 2.0.3000.7 (aka SDL 2.0.30.7)\n" | tee -a "$LOG_FILE"
	  sudo mv -f -v /home/ark/sdl2-64/libSDL2-2.0.so.0.3000.7.rk3326 /usr/lib/aarch64-linux-gnu/libSDL2-2.0.so.0.3000.7 | tee -a "$LOG_FILE"
	  sudo mv -f -v /home/ark/sdl2-32/libSDL2-2.0.so.0.3000.7.rk3326 /usr/lib/arm-linux-gnueabihf/libSDL2-2.0.so.0.3000.7 | tee -a "$LOG_FILE"
	  sudo rm -rfv /home/ark/sdl2-32 | tee -a "$LOG_FILE"
	  sudo rm -rfv /home/ark/sdl2-64 | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/aarch64-linux-gnu/libSDL2.so /usr/lib/aarch64-linux-gnu/libSDL2-2.0.so.0 | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/aarch64-linux-gnu/libSDL2-2.0.so.0.3000.7 /usr/lib/aarch64-linux-gnu/libSDL2.so | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/arm-linux-gnueabihf/libSDL2.so /usr/lib/arm-linux-gnueabihf/libSDL2-2.0.so.0 | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/arm-linux-gnueabihf/libSDL2-2.0.so.0.3000.7 /usr/lib/arm-linux-gnueabihf/libSDL2.so | tee -a "$LOG_FILE"


	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth
	
	touch "/home/ark/.config/.update09272024"

fi

if [ ! -f "/home/ark/.config/.update09292024" ]; then

	printf "\nFix SDL 2.30.7 builtin joystick detection issue\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/09292024/arkosupdate09292024.zip -O /dev/shm/arkosupdate09292024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate09292024.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate09292024.zip" ]; then
	  sudo unzip -X -o /dev/shm/arkosupdate09292024.zip -x home/ark/ogage-gameforce-chi -d / | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate09292024.zip | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate09292024.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi

	printf "\nInstall and link new SDL 2.0.3000.7 (aka SDL 2.0.30.7)\n" | tee -a "$LOG_FILE"

	  sudo mv -f -v /home/ark/sdl2-64/libSDL2-2.0.so.0.3000.7.rk3326 /usr/lib/aarch64-linux-gnu/libSDL2-2.0.so.0.3000.7 | tee -a "$LOG_FILE"
	  sudo mv -f -v /home/ark/sdl2-32/libSDL2-2.0.so.0.3000.7.rk3326 /usr/lib/arm-linux-gnueabihf/libSDL2-2.0.so.0.3000.7 | tee -a "$LOG_FILE"
	  sudo rm -rfv /home/ark/sdl2-32 | tee -a "$LOG_FILE"
	  sudo rm -rfv /home/ark/sdl2-64 | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/aarch64-linux-gnu/libSDL2.so /usr/lib/aarch64-linux-gnu/libSDL2-2.0.so.0 | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/aarch64-linux-gnu/libSDL2-2.0.so.0.3000.7 /usr/lib/aarch64-linux-gnu/libSDL2.so | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/arm-linux-gnueabihf/libSDL2.so /usr/lib/arm-linux-gnueabihf/libSDL2-2.0.so.0 | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/arm-linux-gnueabihf/libSDL2-2.0.so.0.3000.7 /usr/lib/arm-linux-gnueabihf/libSDL2.so | tee -a "$LOG_FILE"
	  sudo chmod -R 755 /opt/system/Advanced/ | tee -a "$LOG_FILE"
	  sudo chmod -R 755 /opt/system/DeviceType/ | tee -a "$LOG_FILE"
	  sudo chown -Rv  ark:ark /opt/system/DeviceType/ | tee -a "$LOG_FILE"
		
	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth
	touch "/home/ark/.config/.update09292024"

fi

if [ ! -f "/home/ark/.config/.update10252024" ]; then

	printf "\nUpdate emulationstation to exclude menu.scummvm from scraping\nUpdate DS4 Controller config for retroarches\nUpdate Hypseus-Singe to 2.11.3\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/10252024/arkosupdate10252024.zip -O /dev/shm/arkosupdate10252024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate10252024.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate10252024.zip" ]; then
	  sudo unzip -X -o /dev/shm/arkosupdate10252024.zip -d / | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate10252024.zip | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate10252024.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi

	printf "\nCopy correct Hypseus-Singe for device\n" | tee -a "$LOG_FILE"
	if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
      rm -fv /opt/hypseus-singe/hypseus-singe.rk3326 | tee -a "$LOG_FILE"
    else
      mv -fv /opt/hypseus-singe/hypseus-singe.rk3326 /opt/hypseus-singe/hypseus-singe | tee -a "$LOG_FILE"
	fi

	printf "\nCopy correct emulationstation depending on device\n" | tee -a "$LOG_FILE"
	if [ -f "/boot/rk3326-r33s-linux.dtb" ] || [ -f "/boot/rk3326-r35s-linux.dtb" ] || [ -f "/boot/rk3326-r36s-linux.dtb" ] || [ -f "/boot/rk3326-rg351v-linux.dtb" ] || [ -f "/boot/rk3326-rg351mp-linux.dtb" ] || [ -f "/boot/rk3326-gameforce-linux.dtb" ]; then
	  sudo mv -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	elif [ -f "/boot/rk3326-odroidgo2-linux.dtb" ] || [ -f "/boot/rk3326-odroidgo2-linux-v11.dtb" ] || [ -f "/boot/rk3326-odroidgo3-linux.dtb" ]; then
	  test=$(stat -c %s "/usr/bin/emulationstation/emulationstation")
	  if [ "$test" = "3416928" ]; then
	    sudo cp -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  elif [ -f "/home/ark/.config/.DEVICE" ]; then
		sudo cp -fv /home/ark/emulationstation.rgb10max /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  else
	    sudo cp -fv /home/ark/emulationstation.header /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  fi
	  if [ -f "/home/ark/.config/.DEVICE" ]; then
	    sudo cp -fv /home/ark/emulationstation.rgb10max /usr/bin/emulationstation/emulationstation.header | tee -a "$LOG_FILE"
	  else
	    sudo cp -fv /home/ark/emulationstation.header /usr/bin/emulationstation/emulationstation.header | tee -a "$LOG_FILE"
	  fi
	  sudo cp -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation.fullscreen | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	elif [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
	  sudo mv -fv /home/ark/emulationstation.503 /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	fi

	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth
	touch "/home/ark/.config/.update10252024"
fi

if [ ! -f "/home/ark/.config/.update11272024" ]; then

	printf "\nUpdate GZDoom to 4.13.1\nUpdate PPSSPP to 1.18.1\nUpdated Mupen64plus standalone\nUpdate XRoar to 1.7.1\nFix ScummVM single sd card setup\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/11272024/arkosupdate11272024.zip -O /dev/shm/arkosupdate11272024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate11272024.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate11272024.zip" ]; then
	  sudo unzip -X -o /dev/shm/arkosupdate11272024.zip -d / | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate11272024.zip | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate11272024.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi

	printf "\nCopy correct gzdoom depending on device\n" | tee -a "$LOG_FILE"
	  cp -fv /opt/gzdoom/gzdoom.rk3326 /opt/gzdoom/gzdoom | tee -a "$LOG_FILE"
	  sudo rm -fv /opt/gzdoom/gzdoom.* | tee -a "$LOG_FILE"

	printf "\nCopy correct mupen64plus standalone for the chipset\n" | tee -a "$LOG_FILE"
	  cp -fv /opt/mupen64plus/mupen64plus-video-GLideN64.so.rk3326 /opt/mupen64plus/mupen64plus-video-GLideN64.so | tee -a "$LOG_FILE"
	  cp -fv /opt/mupen64plus/mupen64plus-video-glide64mk2.so.rk3326 /opt/mupen64plus/mupen64plus-video-glide64mk2.so | tee -a "$LOG_FILE"
	  cp -fv /opt/mupen64plus/mupen64plus-video-rice.so.rk3326 /opt/mupen64plus/mupen64plus-video-rice.so | tee -a "$LOG_FILE"
	  cp -fv /opt/mupen64plus/mupen64plus-audio-sdl.so.rk3326 /opt/mupen64plus/mupen64plus-audio-sdl.so | tee -a "$LOG_FILE"
	  cp -fv /opt/mupen64plus/mupen64plus.rk3326 /opt/mupen64plus/mupen64plus | tee -a "$LOG_FILE"
	  cp -fv /opt/mupen64plus/libmupen64plus.so.2.0.0.rk3326 /opt/mupen64plus/libmupen64plus.so.2.0.0 | tee -a "$LOG_FILE"
	  cp -fv /opt/mupen64plus/mupen64plus-rsp-hle.so.rk3326 /opt/mupen64plus/mupen64plus-rsp-hle.so | tee -a "$LOG_FILE"
	  cp -fv /opt/mupen64plus/mupen64plus-input-sdl.so.rk3326 /opt/mupen64plus/mupen64plus-input-sdl.so | tee -a "$LOG_FILE"
	  rm -fv /opt/mupen64plus/*.rk3326 | tee -a "$LOG_FILE"
	  
	printf "\nCopy correct PPSSPPSDL for device\n" | tee -a "$LOG_FILE"
	if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
      rm -fv /opt/ppsspp/PPSSPPSDL.rk3326 | tee -a "$LOG_FILE"
    else
      mv -fv /opt/ppsspp/PPSSPPSDL.rk3326 /opt/ppsspp/PPSSPPSDL | tee -a "$LOG_FILE"
	fi

	printf "\nUpdate exfat kernel module\n" | tee -a "$LOG_FILE"
	sudo install -m644 -b -D -v /home/ark/exfat.ko.351 /lib/modules/4.4.189/kernel/fs/exfat/exfat.ko | tee -a "$LOG_FILE"

	sudo depmod -a
	sudo modprobe -v exfat | tee -a "$LOG_FILE"
	sudo rm -fv /home/ark/exfat.ko.* | tee -a "$LOG_FILE"

	printf "\nRemove some unneeded files since this is not a RG351MP/RGB10X unit\n" | tee -a "$LOG_FILE"
	sudo rm -fv /home/ark/emulationstation.351v | tee -a "$LOG_FILE"
	sudo rm -fv /usr/local/bin/ogage.351mp | tee -a "$LOG_FILE"

	if [ -f "/opt/system/Advanced/Switch to SD2 for Roms.sh" ]; then
	  printf "\nFix ScummVM saving issue for Single card SD setup\n" | tee -a "$LOG_FILE"
	  sed -i '/roms2\//s//roms\//g' /home/ark/.config/scummvm/scummvm.ini
	fi

	if [ ! -f "/boot/rk3566.dtb" ] && [ ! -f "/boot/rk3566-OC.dtb" ]; then
	  if test -z "$(cat /boot/boot.ini | grep 'vt.global_cursor_default')"
	  then
	    printf "\nDisabling blinking cursor when entering and exiting Emulationstation\n" | tee -a "$LOG_FILE"
		sudo sed -i '/consoleblank\=0/s//consoleblank\=0 vt.global_cursor_default\=0/g' /boot/boot.ini
	  fi
	fi

	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth

	touch "/home/ark/.config/.update11272024"
fi	
	
	if [ ! -f "/home/ark/.config/.update12242024" ]; then

	printf "\nRevert exfat kernel module update to previous version\nUpdate ScummVM to 2.9.0\nUpdate SDL to 2.30.10\nUpdate Change Ports SDL tool\nUpdate Filebrowser to 2.31.2\nUpdate enable_vibration script\nUpdate daphne.sh and single.sh scripts for RGB30 Unit\nAdd j2me to nes-box and sagabox themes\nUpdate coco.sh to accomodate alternate default controls\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/12242024/arkosupdate12242024.zip -O /dev/shm/arkosupdate12242024.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate12242024.zip | tee -a "$LOG_FILE"
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/12242024/arkosupdate12242024.z01 -O /dev/shm/arkosupdate12242024.z01 -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate12242024.z01 | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate12242024.zip" ] && [ -f "/dev/shm/arkosupdate12242024.z01" ]; then
	  zip -FF /dev/shm/arkosupdate12242024.zip --out /dev/shm/arkosupdate.zip -fz | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate12242024.z* | tee -a "$LOG_FILE"
	  if test ! -z $(tr -d '\0' < /proc/device-tree/compatible | grep rk3566)
	  then
	    if [ ! -z "$(grep "RGB30" /home/ark/.config/.DEVICE | tr -d '\0')" ]; then
	      sudo unzip -X -o /dev/shm/arkosupdate.zip -x home/ark/sd_fuse/* roms/themes/es-theme-nes-box/* -d / | tee -a "$LOG_FILE"
		else
	      sudo unzip -X -o /dev/shm/arkosupdate.zip -x home/ark/sd_fuse/* roms/themes/es-theme-sagabox/* -d / | tee -a "$LOG_FILE"
		fi
	  else
	    sudo unzip -X -o /dev/shm/arkosupdate.zip -x usr/local/bin/enable_vibration.sh roms/themes/es-theme-sagabox/* -d / | tee -a "$LOG_FILE"
	  fi
	  printf "\nAdd j2me emulator\n" | tee -a "$LOG_FILE"
	  if test -z "$(cat /etc/emulationstation/es_systems.cfg | grep 'j2me' | tr -d '\0')"
	  then
	    cp -v /etc/emulationstation/es_systems.cfg /etc/emulationstation/es_systems.cfg.update09272024.bak | tee -a "$LOG_FILE"
	    sed -i -e '/<theme>puzzlescript<\/theme>/{r /home/ark/add_j2me.txt' -e 'd}' /etc/emulationstation/es_systems.cfg
	  fi
	  if [ ! -d "/roms/j2me" ]; then
	    mkdir -v /roms/j2me | tee -a "$LOG_FILE"
	    if test ! -z "$(cat /etc/fstab | grep roms2 | tr -d '\0')"
	    then
		  if [ ! -d "/roms2/j2me" ]; then
		    mkdir -v /roms2/j2me | tee -a "$LOG_FILE"
		    sed -i '/<path>\/roms\/j2me/s//<path>\/roms2\/j2me/g' /etc/emulationstation/es_systems.cfg
		  fi
	    fi
	  fi
	  if [ -f "/opt/system/Advanced/Switch to SD2 for Roms.sh" ]; then
	    if test -z "$(cat /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | grep j2me | tr -d '\0')"
	    then
		  sudo chown -v ark:ark /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | tee -a "$LOG_FILE"
		  sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/j2me\/" ]\; then\n      sudo mkdir \/roms2\/j2me\n  fi\n  sudo pkill filebrowser/' /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh
	    else
		  printf "\nj2me is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	    fi
	  fi
	  if [ -f "/usr/local/bin/Switch to SD2 for Roms.sh" ]; then
	    if test -z "$(cat /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh | grep j2me | tr -d '\0')"
	    then
		  sudo sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/j2me\/" ]\; then\n      sudo mkdir \/roms2\/j2me\n  fi\n  sudo pkill filebrowser/' /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh
	    else
		  printf "\nj2me is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	    fi
	  fi
	  sudo rm -fv /home/ark/add_j2me.txt | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate.zip | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate12242024.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi


	if test ! -z $(tr -d '\0' < /proc/device-tree/compatible | grep rk3566)
	then
      kernel_ver="4.19.172"
	else
      kernel_ver="4.4.189"
	fi
	if [ ! -f "/lib/modules/${kernel_ver}/kernel/fs/exfat/exfat.ko.newer" ]; then
	  printf "\nReverting to previous exfat kernel module\n" | tee -a "$LOG_FILE"
	  sudo cp -fv /lib/modules/${kernel_ver}/kernel/fs/exfat/exfat.ko /lib/modules/${kernel_ver}/kernel/fs/exfat/exfat.ko.newer | tee -a "$LOG_FILE"
	  sudo cp -fv /lib/modules/${kernel_ver}/kernel/fs/exfat/exfat.ko~ /lib/modules/${kernel_ver}/kernel/fs/exfat/exfat.ko | tee -a "$LOG_FILE"
	  sudo depmod -a
	  sudo modprobe -v exfat | tee -a "$LOG_FILE"
	fi

	if test ! -z $(tr -d '\0' < /proc/device-tree/compatible | grep rk3566)
	then
	  printf "\nDownloading Kodi 20.5 to revert Kodi 21.1 to older version to fix streaming addon issues\n" | tee -a "$LOG_FILE"
	  attempt=0
	  while [ ! -f "/dev/shm/Kodi-20.5.tar.xz" ]; do
	    if [ $attempt != 2 ]; then
	     sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/12242024/Kodi-20.5.tar.xz -O /dev/shm/Kodi-20.5.tar.xz -a "$LOG_FILE" || sudo rm -f /dev/shm/Kodi-20.5.tar.xz | tee -a "$LOG_FILE"
	     attempt=$((attempt+1))
		else
	     printf "\nCan't download older Kodi 20.5 for some reason.  Skipping this part of the update.  This can be applied in the future if wanted...\n" | tee -a "$LOG_FILE"
	     sudo rm -f /dev/shm/Kodi-20.5.tar.xz
	     break
		fi
	  done
	  if [ -f "/dev/shm/Kodi-20.5.tar.xz" ]; then
	    printf "  Removing existing Kodi version installed but keeping existing addons and settings in place.\n" | tee -a "$LOG_FILE"
	    rm -rf /opt/kodi/lib/kodi/addons/* /opt/kodi/share/kodi/addons/*
	    printf "  Installing Kodi 20.5.  Please wait...\n" | tee -a "$LOG_FILE"
	    tar xf /dev/shm/Kodi-20.5.tar.xz -C /
	    if [ "$(cat ~/.config/.DEVICE)" != "RG503" ]; then
	      sed -i '/<res width\="1920" height\="1440" aspect\="4:3"/s//<res width\="1623" height\="1180" aspect\="4:3"/g' /opt/kodi/share/kodi/addons/skin.estuary/addon.xml
	    fi
	    printf "  Done!\n" | tee -a "$LOG_FILE"
	  fi
	fi

	printf "\nInstall and link new SDL 2.0.3000.10 (aka SDL 2.0.30.10)\n" | tee -a "$LOG_FILE"
	  sudo mv -f -v /home/ark/sdl2-64/libSDL2-2.0.so.0.3000.10.rk3326 /usr/lib/aarch64-linux-gnu/libSDL2-2.0.so.0.3000.10 | tee -a "$LOG_FILE"
	  sudo mv -f -v /home/ark/sdl2-32/libSDL2-2.0.so.0.3000.10.rk3326 /usr/lib/arm-linux-gnueabihf/libSDL2-2.0.so.0.3000.10 | tee -a "$LOG_FILE"
	  sudo rm -rfv /home/ark/sdl2-32 | tee -a "$LOG_FILE"
	  sudo rm -rfv /home/ark/sdl2-64 | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/aarch64-linux-gnu/libSDL2.so /usr/lib/aarch64-linux-gnu/libSDL2-2.0.so.0 | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/aarch64-linux-gnu/libSDL2-2.0.so.0.3000.10 /usr/lib/aarch64-linux-gnu/libSDL2.so | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/arm-linux-gnueabihf/libSDL2.so /usr/lib/arm-linux-gnueabihf/libSDL2-2.0.so.0 | tee -a "$LOG_FILE"
	  sudo ln -sfv /usr/lib/arm-linux-gnueabihf/libSDL2-2.0.so.0.3000.10 /usr/lib/arm-linux-gnueabihf/libSDL2.so | tee -a "$LOG_FILE"


	printf "\nAdd R36H on Device Types and add configuration files for it.\n" | tee -a "$LOG_FILE"


	  
  	  sudo mv -f -v /home/ark/ra/retroarch.r36h /home/ark/.config/retroarch/retroarch.r36h | tee -a "$LOG_FILE"
	  sudo mv -f -v /home/ark/ra/retroarch.r36s /home/ark/.config/retroarch/retroarch.r36s | tee -a "$LOG_FILE"
	  sudo mv -f -v /home/ark/ra32/retroarch32.r36h /home/ark/.config/retroarch32/retroarch.r36h | tee -a "$LOG_FILE"
	  sudo mv -f -v /home/ark/ra32/retroarch32.r36s /home/ark/.config/retroarch32/retroarch.r36s | tee -a "$LOG_FILE"
	  sudo rm -rfv /home/ark/ra | tee -a "$LOG_FILE"
	  sudo rm -rfv /home/ark/ra32 | tee -a "$LOG_FILE"
	  sudo rm -fv /opt/system/DeviceType/R33S.sh | tee -a "$LOG_FILE"
	  sudo chmod -R +x /opt/system/*

	printf "\nCopy correct scummvm for device\n" | tee -a "$LOG_FILE"

      mv -fv /opt/scummvm/scummvm.rk3326 /opt/scummvm/scummvm | tee -a "$LOG_FILE"


	if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ] || [ -f "/boot/rk3326-rg351v-linux.dtb" ] || [ -f "/boot/rk3326-rg351mp-linux.dtb" ] || [ -f "/boot/rk3326-r33s-linux.dtb" ] || [ -f "/boot/rk3326-r35s-linux.dtb" ] || [ -f "/boot/rk3326-r36s-linux.dtb" ]; then
	  printf "\nFixing fail booting when second sd card is not found or not in the expected format.\n" | tee -a "$LOG_FILE"
	  if [ -f "/opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh" ]; then
		sudo chown -R ark:ark /opt
	    sed -i '/noatime,uid\=1002/s//noatime,nofail,x-systemd.device-timeout\=7,uid\=1002/' /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh
	    sed -i '/defaults 0 1/s//defaults,nofail,x-systemd.device-timeout\=7 0 1/' /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh
	    sudo sed -i '/none bind/s//none nofail,x-systemd.device-timeout\=7,bind/' /etc/fstab
	  else
        sudo sed -i '/noatime,uid\=1002/s//noatime,nofail,x-systemd.device-timeout\=7,uid\=1002/' /etc/fstab
	    sudo sed -i '/defaults 0 1/s//defaults,nofail,x-systemd.device-timeout\=7 0 1/' /etc/fstab
	    sudo sed -i '/none bind/s//none nofail,x-systemd.device-timeout\=7,bind/' /etc/fstab
	    sudo systemctl daemon-reload && sudo systemctl restart local-fs.target
	  fi
	  sudo sed -i '/noatime,uid\=1002/s//noatime,nofail,x-systemd.device-timeout\=7,uid\=1002/' /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh
	  sudo sed -i '/defaults 0 1/s//defaults,nofail,x-systemd.device-timeout\=7 0 1/' /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh
	  printf "  Done.\n" | tee -a "$LOG_FILE"
	fi

	if [ -e "/dev/input/by-path/platform-odroidgo2-joypad-joystick" ] && [ ! -e "/dev/input/by-path/platform-ff300000.usb-usb-0:1.2:1.0-event-joystick" ]; then
	  printf "\nUpdating uboot to remove uboot version info drawing over boot logo\n" | tee -a "$LOG_FILE"
	  cd /home/ark/sd_fuse
	  sudo dd if=idbloader.img of=/dev/mmcblk0 conv=notrunc bs=512 seek=64 | tee -a "$LOG_FILE"
	  sudo dd if=uboot.img of=/dev/mmcblk0 conv=notrunc bs=512 seek=16384 | tee -a "$LOG_FILE"
	  sudo dd if=trust.img of=/dev/mmcblk0 conv=notrunc bs=512 seek=24576 | tee -a "$LOG_FILE"
	  sync
	  cd /home/ark
	  rm -rfv /home/ark/sd_fuse | tee -a "$LOG_FILE"
	else
	  printf "\nThis is not an oga1.1/rgb10/v10 unit.  No uboot flash needed.\n" | tee -a "$LOG_FILE"
	  if [ -d "/home/ark/sd_fuse" ]; then
	    rm -rfv /home/ark/sd_fuse | tee -a "$LOG_FILE"
	  fi
	fi

	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth

	touch "/home/ark/.config/.update12242024"
fi
	

if [ ! -f "/home/ark/.config/.update01312025" ]; then

	printf "\nUpdate Retroarch and Retroarch32 to 1.20.0\nUpdate rk3566 kernel with battery reading fix and native rumble support\nUpdate Hypseus-singe to 2.11.4\nUpdate pico8.sh to fix offline carts play via splore\nFix bad freej2me-lr.jar and freej2me-plus-lr.jar files\nAdd vibration support for RK2023\nUpdate Emulationstation\nUpdate batt_life_verbal_warning.py\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/01312025/arkosupdate01312025.zip -O /dev/shm/arkosupdate01312025.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate01312025.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate01312025.zip" ]; then
		if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
		  if [ ! -z "$(grep "RGB30" /home/ark/.config/.DEVICE | tr -d '\0')" ] || [ ! -z "$(grep "RK2023" /home/ark/.config/.DEVICE | tr -d '\0')" ]; then
			if [ ! -z "$(grep "RGB30" /home/ark/.config/.DEVICE | tr -d '\0')" ]; then
		      sudo unzip -X -o /dev/shm/arkosupdate01312025.zip -x roms/themes/es-theme-nes-box/* -d / | tee -a "$LOG_FILE"
			else
		      sudo unzip -X -o /dev/shm/arkosupdate01312025.zip -x roms/themes/es-theme-sagabox/* -d / | tee -a "$LOG_FILE"
			fi
		  else
		    sudo unzip -X -o /dev/shm/arkosupdate01312025.zip -x usr/local/bin/enable_vibration.sh roms/themes/es-theme-sagabox/* -d / | tee -a "$LOG_FILE"
		  fi
		else
		  sudo unzip -X -o /dev/shm/arkosupdate01312025.zip -x usr/local/bin/enable_vibration.sh roms/themes/es-theme-sagabox/* home/ark/.kodi/addons/script.module.urllib3/* home/ark/rk3566-kernel/* -d / | tee -a "$LOG_FILE"
		fi
	    printf "\nAdd Cave Story emulator\n" | tee -a "$LOG_FILE"
	    if test -z "$(cat /etc/emulationstation/es_systems.cfg | grep 'cavestory' | tr -d '\0')"
	    then
	      cp -v /etc/emulationstation/es_systems.cfg /etc/emulationstation/es_systems.cfg.update01312025.bak | tee -a "$LOG_FILE"
	      sed -i -e '/<theme>apple2<\/theme>/{r /home/ark/add_cavestory.txt' -e 'd}' /etc/emulationstation/es_systems.cfg
	    fi
	    if [ ! -d "/roms/cavestory" ]; then
	      mkdir -v /roms/cavestory | tee -a "$LOG_FILE"
	      if test ! -z "$(cat /etc/fstab | grep roms2 | tr -d '\0')"
	      then
		    if [ ! -d "/roms2/cavestory" ]; then
		      mkdir -v /roms2/cavestory | tee -a "$LOG_FILE"
		      sed -i '/<path>\/roms\/cavestory/s//<path>\/roms2\/cavestory/g' /etc/emulationstation/es_systems.cfg
		    fi
	      fi
	    fi
	    if [ -f "/opt/system/Advanced/Switch to SD2 for Roms.sh" ]; then
	      if test -z "$(cat /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | grep cavestory | tr -d '\0')"
	      then
		    sudo chown -v ark:ark /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | tee -a "$LOG_FILE"
		    sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/cavestory\/" ]\; then\n      sudo mkdir \/roms2\/cavestory\n  fi\n  sudo pkill filebrowser/' /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh
	      else
		    printf "\ncavestory is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	      fi
	    fi
	    if [ -f "/usr/local/bin/Switch to SD2 for Roms.sh" ]; then
	      if test -z "$(cat /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh | grep cavestory | tr -d '\0')"
	      then
		    sudo sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/cavestory\/" ]\; then\n      sudo mkdir \/roms2\/cavestory\n  fi\n  sudo pkill filebrowser/' /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh
	      else
		    printf "\ncavestory is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	      fi
	    fi
	    sudo rm -fv /home/ark/add_cavestory.txt | tee -a "$LOG_FILE"
	    sudo rm -fv /dev/shm/arkosupdate01312025.zip | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate01312025.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi

    if [ ! -z "$(grep "RGB30" /home/ark/.config/.DEVICE | tr -d '\0')" ]; then
      sudo rm -rf roms/themes/es-theme-nes-box/cavestory/ -d / | tee -a "$LOG_FILE"
	fi

	printf "\nCopy correct Retroarches depending on device\n" | tee -a "$LOG_FILE"
	if [ -f "/boot/rk3326-r33s-linux.dtb" ] || [ -f "/boot/rk3326-r35s-linux.dtb" ] || [ -f "/boot/rk3326-r36s-linux.dtb" ] || [ -f "/boot/rk3326-rg351v-linux.dtb" ] || [ -f "/boot/rk3326-rg351mp-linux.dtb" ] || [ -f "/boot/rk3326-gameforce-linux.dtb" ]; then
	  cp -fv /opt/retroarch/bin/retroarch32.rk3326.unrot /opt/retroarch/bin/retroarch32 | tee -a "$LOG_FILE"
	  cp -fv /opt/retroarch/bin/retroarch.rk3326.unrot /opt/retroarch/bin/retroarch | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch.* | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch32.* | tee -a "$LOG_FILE"
	elif [ -f "/boot/rk3326-odroidgo2-linux.dtb" ] || [ -f "/boot/rk3326-odroidgo2-linux-v11.dtb" ] || [ -f "/boot/rk3326-odroidgo3-linux.dtb" ]; then
	  cp -fv /opt/retroarch/bin/retroarch32.rk3326.rot /opt/retroarch/bin/retroarch32 | tee -a "$LOG_FILE"
	  cp -fv /opt/retroarch/bin/retroarch.rk3326.rot /opt/retroarch/bin/retroarch | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch.* | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch32.* | tee -a "$LOG_FILE"
	else
	  rm -fv /opt/retroarch/bin/retroarch.* | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch32.* | tee -a "$LOG_FILE"
	fi
	chmod 777 /opt/retroarch/bin/*

	if test ! -z $(tr -d '\0' < /proc/device-tree/compatible | grep rk3566)
	then
	  printf "\nDownloading Kodi 21.2 package to update Kodi to 21.1 with streaming addon fixed\n" | tee -a "$LOG_FILE"
	  attempt=0
	  while [ ! -f "/dev/shm/Kodi-21.2.tar.xz" ]; do
	    if [ $attempt != 2 ]; then
	     sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/01312025/Kodi-21.2.tar.xz -O /dev/shm/Kodi-21.2.tar.xz -a "$LOG_FILE" || sudo rm -f /dev/shm/Kodi-21.2.tar.xz | tee -a "$LOG_FILE"
	     attempt=$((attempt+1))
		else
	     printf "\nCan't download older Kodi 21.2 for some reason.  Skipping this part of the update.  This can be applied in the future if wanted...\n" | tee -a "$LOG_FILE"
	     sudo rm -f /dev/shm/Kodi-21.2.tar.xz
	     break
		fi
	  done
	  if [ -f "/dev/shm/Kodi-21.2.tar.xz" ]; then
	    pip3 install importlib.metadata
	    printf "  Removing existing Kodi version installed but keeping existing addons and settings in place.\n" | tee -a "$LOG_FILE"
	    rm -rf /opt/kodi/lib/kodi/addons/* /opt/kodi/share/kodi/addons/*
	    printf "  Installing Kodi 21.2.  Please wait...\n" | tee -a "$LOG_FILE"
	    tar xf /dev/shm/Kodi-21.2.tar.xz -C /
	    if [ "$(cat ~/.config/.DEVICE)" != "RG503" ]; then
	      sed -i '/<res width\="1920" height\="1440" aspect\="4:3"/s//<res width\="1623" height\="1180" aspect\="4:3"/g' /opt/kodi/share/kodi/addons/skin.estuary/addon.xml
	    fi
	    printf "  Done!\n" | tee -a "$LOG_FILE"
	  fi
	fi

	printf "\nCopy correct Hypseus-Singe for device\n" | tee -a "$LOG_FILE"
	if [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
      rm -fv /opt/hypseus-singe/hypseus-singe.rk3326 | tee -a "$LOG_FILE"
    else
      mv -fv /opt/hypseus-singe/hypseus-singe.rk3326 /opt/hypseus-singe/hypseus-singe | tee -a "$LOG_FILE"
	fi

	if [ -f "/boot/rk3566.dtb" ]; then
	    printf "\nCopy updated kernel based on device\n" | tee -a "$LOG_FILE"
	    if test ! -z "$(grep "RG353V" /home/ark/.config/.DEVICE | tr -d '\0')"
	    then
	      sudo mv -fv /home/ark/rk3566-kernel/Image.353 /boot/Image | tee -a "$LOG_FILE"
	      sudo mv -fv /home/ark/rk3566-kernel/rk3566-353v.dtb /boot/rk3566-OC.dtb | tee -a "$LOG_FILE"
	      sudo mv -fv /home/ark/rk3566-kernel/rk3566-353v.dtb.bright /boot/rk3566-OC.dtb.bright | tee -a "$LOG_FILE"
	    elif test ! -z "$(grep "RG353M" /home/ark/.config/.DEVICE | tr -d '\0')"
	    then
	      sudo mv -fv /home/ark/rk3566-kernel/Image.353 /boot/Image | tee -a "$LOG_FILE"
	      sudo mv -fv /home/ark/rk3566-kernel/rk3566-353m.dtb /boot/rk3566-OC.dtb | tee -a "$LOG_FILE"
	      sudo mv -fv /home/ark/rk3566-kernel/rk3566-353m.dtb.bright /boot/rk3566-OC.dtb.bright | tee -a "$LOG_FILE"
	    elif test ! -z "$(grep "RGB30" /home/ark/.config/.DEVICE | tr -d '\0')"
	    then
	      sudo mv -fv /home/ark/rk3566-kernel/Image.rgb30 /boot/Image | tee -a "$LOG_FILE"
	      sudo mv -fv /home/ark/rk3566-kernel/rk3566-rgb30.dtb /boot/rk3566-OC.dtb | tee -a "$LOG_FILE"
	      sudo mv -fv /home/ark/rk3566-kernel/rk3566-rgb30-v2.dtb /boot/rk3566-OC.dtb | tee -a "$LOG_FILE"
	    elif test ! -z "$(grep "RGB20PRO" /home/ark/.config/.DEVICE | tr -d '\0')"
	    then
	      sudo mv -fv /home/ark/rk3566-kernel/Image.rgb20pro /boot/Image | tee -a "$LOG_FILE"
	      sudo mv -fv /home/ark/rk3566-kernel/rk3566-rgb20pro.dtb /boot/rk3566-OC.dtb | tee -a "$LOG_FILE"
	    elif test ! -z "$(grep "RK2023" /home/ark/.config/.DEVICE | tr -d '\0')"
	    then
	      sudo mv -fv /home/ark/rk3566-kernel/Image.rk2023 /boot/Image | tee -a "$LOG_FILE"
	      sudo mv -fv /home/ark/rk3566-kernel/rk3566-rk2023.dtb /boot/rk3566-OC.dtb | tee -a "$LOG_FILE"
	    elif test ! -z "$(grep "RG503" /home/ark/.config/.DEVICE | tr -d '\0')"
	    then
	      sudo mv -fv /home/ark/rk3566-kernel/Image.rg503 /boot/Image | tee -a "$LOG_FILE"
	      sudo mv -fv /home/ark/rk3566-kernel/rk3566-rg503.dtb /boot/rk3566-OC.dtb | tee -a "$LOG_FILE"
		fi
		sudo rm -rfv /home/ark/rk3566-kernel/ | tee -a "$LOG_FILE"
		CURRENT_DTB="$(grep FDT /boot/extlinux/extlinux.conf | cut -c 8-)"
		if [ -f "/home/ark/.config/.BRIGHTDTB" ]; then
		  BASE_DTB_NAME="rk3566-OC.dtb.bright"
		else
		  BASE_DTB_NAME="rk3566-OC.dtb"
		fi
		sudo sed -i "/  FDT \/$CURRENT_DTB/c\  FDT \/${BASE_DTB_NAME}" /boot/extlinux/extlinux.conf
	else
	  sudo rm -rfv /home/ark/rk3566-kernel/ | tee -a "$LOG_FILE"
	fi

	printf "\nCopy correct emulationstation depending on device\n" | tee -a "$LOG_FILE"
	if [ -f "/boot/rk3326-r33s-linux.dtb" ] || [ -f "/boot/rk3326-r35s-linux.dtb" ] || [ -f "/boot/rk3326-r36s-linux.dtb" ] || [ -f "/boot/rk3326-rg351v-linux.dtb" ] || [ -f "/boot/rk3326-rg351mp-linux.dtb" ] || [ -f "/boot/rk3326-gameforce-linux.dtb" ]; then
	  sudo mv -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	elif [ -f "/boot/rk3326-odroidgo2-linux.dtb" ] || [ -f "/boot/rk3326-odroidgo2-linux-v11.dtb" ] || [ -f "/boot/rk3326-odroidgo3-linux.dtb" ]; then
	  test=$(stat -c %s "/usr/bin/emulationstation/emulationstation")
	  if [ "$test" = "3416928" ]; then
	    sudo cp -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  elif [ -f "/home/ark/.config/.DEVICE" ]; then
		sudo cp -fv /home/ark/emulationstation.rgb10max /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  else
	    sudo cp -fv /home/ark/emulationstation.header /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  fi
	  if [ -f "/home/ark/.config/.DEVICE" ]; then
	    sudo cp -fv /home/ark/emulationstation.rgb10max /usr/bin/emulationstation/emulationstation.header | tee -a "$LOG_FILE"
	  else
	    sudo cp -fv /home/ark/emulationstation.header /usr/bin/emulationstation/emulationstation.header | tee -a "$LOG_FILE"
	  fi
	  sudo cp -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation.fullscreen | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	elif [ -f "/boot/rk3566.dtb" ] || [ -f "/boot/rk3566-OC.dtb" ]; then
	  sudo mv -fv /home/ark/emulationstation.503 /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	fi

	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth

	touch "/home/ark/.config/.update01312025"
fi
if [ ! -f "/home/ark/.config/.update02012025-2" ]; then

	printf "\nFix potential battery reading issue from 01312025 update for rk3566 devices\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/02012025-2/arkosupdate02012025-2.zip -O /dev/shm/arkosupdate02012025-2.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate02012025-2.zip | tee -a "$LOG_FILE"
if [ -f "/dev/shm/arkosupdate02012025-2.zip" ]; then
	  sudo unzip -X -o /dev/shm/arkosupdate02012025-2.zip -d / | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate02012025-2.zip | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate02012025-2.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
fi

	printf "\nAdd Onscripter_Onsyuri libretro core to Onscripter system\n" | tee -a "$LOG_FILE"
	sed -i -e '/<command>sudo perfmax %GOVERNOR% %ROM%; nice -n -19 \/usr\/local\/bin\/retroarch -L \/home\/ark\/.config\/retroarch\/cores\/onscripter_libretro.so %ROM%; sudo perfnorm<\/command>/{r /home/ark/add_onsyuri_onscripter.txt' -e 'd}' /etc/emulationstation/es_systems.cfg
	sudo rm -fv /home/ark/add_onsyuri_onscripter.txt | tee -a "$LOG_FILE"


	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth

	touch "/home/ark/.config/.update02012025-2"
fi
	
	
if [ ! -f "/home/ark/.config/.update02012025-3" ]; then

	printf "\nFix PortMaster\nAdd KEY_SERVICE to RIGHTSTICK button for Hypseus-Singe\n" | tee -a "$LOG_FILE"

	sed -i '/KEY_SERVICE    \= SDLK_9          0         0                  0                 0/c\KEY_SERVICE    \= SDLK_9          0         BUTTON_RIGHTSTICK  0                 0' /opt/hypseus-singe/hypinput.ini

	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 (02012025)-3(AeUX)" /usr/share/plymouth/themes/text.plymouth

	touch "/home/ark/.config/.update02012025-3"
fi

if [ ! -f "/home/ark/.config/.update02022025" ]; then

	printf "\nFix save issue for Retroarch and Retroarch\nAdd .VERSION file for PortMaster\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/02022025/arkosupdate02022025.zip -O /dev/shm/arkosupdate02022025.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate02022025.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate02022025.zip" ]; then
	  sudo unzip -X -o /dev/shm/arkosupdate02022025.zip -d / | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate02022025.zip | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate02022025.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
fi
	
	printf "\nFix R36H and R33S on Device Types.\n" | tee -a "$LOG_FILE"
	sudo rm -fv "/opt/system/DeviceType/R33S or R36H.sh" | tee -a "$LOG_FILE"
	sudo chmod -R +x /opt/system/*
	
	printf "\nCopy correct Retroarches depending on device\n" | tee -a "$LOG_FILE"
if [ -f "/boot/rk3326-r33s-linux.dtb" ] || [ -f "/boot/rk3326-r35s-linux.dtb" ] || [ -f "/boot/rk3326-r36s-linux.dtb" ] || [ -f "/boot/rk3326-rg351v-linux.dtb" ] || [ -f "/boot/rk3326-rg351mp-linux.dtb" ] || [ -f "/boot/rk3326-gameforce-linux.dtb" ]; then
	  cp -fv /opt/retroarch/bin/retroarch32.rk3326.unrot /opt/retroarch/bin/retroarch32 | tee -a "$LOG_FILE"
	  cp -fv /opt/retroarch/bin/retroarch.rk3326.unrot /opt/retroarch/bin/retroarch | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch.* | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch32.* | tee -a "$LOG_FILE"
fi
	chmod 777 /opt/retroarch/bin/*

	printf "\nMaking changes to retroarch.cfg and retroarch32.cfg files to maintain default save and savestate folder locations due to libretro changes\n" | tee -a "$LOG_FILE"
	if test ! -z "$(grep "savefile_directory = \"~/.config/retroarch/saves\"" /home/ark/.config/retroarch/retroarch.cfg | tr -d '\0')"
	then
	  if test ! -z "$(grep "savefiles_in_content_dir = \"true\"" /home/ark/.config/retroarch/retroarch.cfg | tr -d '\0')"
	  then
	    sed -i "/sort_savefiles_enable = \"/c\\sort_savefiles_enable = \"false\"" /home/ark/.config/retroarch/retroarch.cfg
	  else
	    printf "\n  No change made for sort_savefiles_enable for retroarch as a custom setting is set." | tee -a "$LOG_FILE"
	  fi
	fi
	if test ! -z "$(grep "savestate_directory = \"~/.config/retroarch/states\"" /home/ark/.config/retroarch/retroarch.cfg | tr -d '\0')"
	then
	  if test ! -z "$(grep "savestates_in_content_dir = \"true\"" /home/ark/.config/retroarch/retroarch.cfg | tr -d '\0')"
	  then
	    sed -i "/sort_savestates_enable = \"/c\\sort_savestates_enable = \"false\"" /home/ark/.config/retroarch/retroarch.cfg
	  else
	    printf "\n  No change made for sort_savestates_enable for retroarch as a custom setting is set." | tee -a "$LOG_FILE"
	  fi
	fi
	if test ! -z "$(grep "savefile_directory = \"~/.config/retroarch/saves\"" /home/ark/.config/retroarch32/retroarch.cfg | tr -d '\0')"
	then
	  if test ! -z "$(grep "savefiles_in_content_dir = \"true\"" /home/ark/.config/retroarch32/retroarch.cfg | tr -d '\0')"
	  then
	    sed -i "/sort_savefiles_enable = \"/c\\sort_savefiles_enable = \"false\"" /home/ark/.config/retroarch32/retroarch.cfg
	  else
	    printf "\n  No change made for sort_savefiles_enable for retroarch32 as a custom setting is set." | tee -a "$LOG_FILE"
	  fi
	fi
	if test ! -z "$(grep "savestate_directory = \"~/.config/retroarch/states\"" /home/ark/.config/retroarch32/retroarch.cfg | tr -d '\0')"
	then
	  if test ! -z "$(grep "savestates_in_content_dir = \"true\"" /home/ark/.config/retroarch32/retroarch.cfg | tr -d '\0')"
	  then
	    sed -i "/sort_savestates_enable = \"/c\\sort_savestates_enable = \"false\"" /home/ark/.config/retroarch32/retroarch.cfg
	  else
	    printf "\n  No change made for sort_savestates_enable for retroarch32 as a custom setting is set." | tee -a "$LOG_FILE"
	  fi
	fi
	sed -i "/sort_savefiles_enable = \"/c\\sort_savefiles_enable = \"false\"" /home/ark/.config/retroarch/retroarch.cfg.bak
	sed -i "/sort_savestates_enable = \"/c\\sort_savestates_enable = \"false\"" /home/ark/.config/retroarch/retroarch.cfg.bak
	sed -i "/sort_savefiles_enable = \"/c\\sort_savefiles_enable = \"false\"" /home/ark/.config/retroarch32/retroarch.cfg.bak
	sed -i "/sort_savestates_enable = \"/c\\sort_savestates_enable = \"false\"" /home/ark/.config/retroarch32/retroarch.cfg.bak
	
	printf "\nInstalling MPV and Socat...\n" | tee -a "$LOG_FILE"
	sudo apt-get install -y mpv socat --no-install-recommends | tee -a "$LOG_FILE"

	printf "\nMoving files to their respective locations...\n" | tee -a "$LOG_FILE"
	sudo mv /home/ark/mpv_sense /usr/bin/mpv_sense | tee -a "$LOG_FILE"
	sudo mv /home/ark/mpv.service /lib/systemd/system/mpv.service | tee -a "$LOG_FILE"
	sudo mv /home/ark/mediaplayer.sh /usr/local/bin/mediaplayer.sh | tee -a "$LOG_FILE"

	printf "\nSetting permissions...\n" | tee -a "$LOG_FILE"
	sudo chmod 755 /usr/bin/mpv_sense | tee -a "$LOG_FILE"
	sudo chmod 755 /lib/systemd/system/mpv.service | tee -a "$LOG_FILE"
	sudo chmod 755 /usr/local/bin/mediaplayer.sh | tee -a "$LOG_FILE"
	
	printf "\nReloading systemd daemon...\n" | tee -a "$LOG_FILE"
	sudo systemctl daemon-reload | tee -a "$LOG_FILE"

	if ! sudo systemctl is-active --quiet mpv.service; then
		printf "\nmpv.service is not running. Enabling and starting it...\n" | tee -a "$LOG_FILE"
		sudo systemctl enable mpv.service | tee -a "$LOG_FILE"
		sudo systemctl start mpv.service | tee -a "$LOG_FILE"
	else
    printf "\nmpv.service is already running.\n" | tee -a "$LOG_FILE"
	fi

	printf "\nService status:\n" | tee -a "$LOG_FILE"
	sudo systemctl status mpv.service | tee -a "$LOG_FILE"
	printf "\nMPV Setup Completed Successfully!\n" | tee -a "$LOG_FILE"	
	
	printf "\nUpdate es_systems.cfg and es_systems.cfg.dual files for Read from Both Script\n" | tee -a "$LOG_FILE"
	sudo chmod -R 755 /usr/local/bin/ | tee -a "$LOG_FILE"
	sudo chmod 755 /opt/scummvm/scummvm | tee -a "$LOG_FILE"
	sudo chown ark:ark /opt/scummvm/scummvm | tee -a "$LOG_FILE"

	sudo rm -f /etc/emulationstation/es_systems.cfg.dual | tee -a "$LOG_FILE"
	sudo rm -f /etc/emulationstation/es_systems.cfg | tee -a "$LOG_FILE"
	sudo cp -fv /usr/local/bin/es_systems.cfg.dual /etc/emulationstation/es_systems.cfg.dual | tee -a "$LOG_FILE"
	sudo cp -fv /usr/local/bin/es_systems.cfg.single /etc/emulationstation/es_systems.cfg | tee -a "$LOG_FILE"
	

	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth
	echo "$UPDATE_DATE" > /home/ark/.config/.VERSION

	touch "/home/ark/.config/.update02022025"
fi

if [ ! -f "/home/ark/.config/.update02082025" ]; then

	printf "\nUpdate retroarch to stable 1.20.0 to fix override issue from later commit\nUpdate emulationstation to fix font issues for languages like Korean\nAdd BBC Micro emulator\nUpdate msgbox\nUpdate USB Drive Mount script\nUpdate themes\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/02082025/arkosupdate02082025.zip -O /dev/shm/arkosupdate02082025.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate02082025.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate02082025.zip" ]; then
	  if [ ! -z "$([ -f /home/ark/.config/.DEVICE ] && grep RGB30 /home/ark/.config/.DEVICE | tr -d '\0')" ]; then
		sudo unzip -X -o /dev/shm/arkosupdate02082025.zip -x roms/themes/es-theme-nes-box/* -d / | tee -a "$LOG_FILE"
	  else
		sudo unzip -X -o /dev/shm/arkosupdate02082025.zip -x roms/themes/es-theme-sagabox/* -d / | tee -a "$LOG_FILE"
	  fi
	  printf "\nAdd BBC Micro emulator\n" | tee -a "$LOG_FILE"
	  if test -z "$(cat /etc/emulationstation/es_systems.cfg | grep 'bbcmicro' | tr -d '\0')"
	  then
	    cp -v /etc/emulationstation/es_systems.cfg /etc/emulationstation/es_systems.cfg.update02082025.bak | tee -a "$LOG_FILE"
	    sed -i -e '/<theme>apple2<\/theme>/{r /home/ark/add_bbcmicro.txt' -e 'd}' /etc/emulationstation/es_systems.cfg
	  fi
	  if [ ! -d "/roms/bbcmicro" ]; then
	    mkdir -v /roms/bbcmicro | tee -a "$LOG_FILE"
	    if test ! -z "$(cat /etc/fstab | grep roms2 | tr -d '\0')"
	    then
		  if [ ! -d "/roms2/bbcmicro" ]; then
		    mkdir -v /roms2/bbcmicro | tee -a "$LOG_FILE"
		    sed -i '/<path>\/roms\/bbcmicro/s//<path>\/roms2\/bbcmicro/g' /etc/emulationstation/es_systems.cfg
		  fi
	    fi
	  fi
	  if [ -f "/opt/system/Advanced/Switch to SD2 for Roms.sh" ]; then
	    if test -z "$(cat /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | grep bbcmicro | tr -d '\0')"
	    then
		  sudo chown -v ark:ark /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh | tee -a "$LOG_FILE"
		  sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/bbcmicro\/" ]\; then\n      sudo mkdir \/roms2\/bbcmicro\n  fi\n  sudo pkill filebrowser/' /opt/system/Advanced/Switch\ to\ SD2\ for\ Roms.sh
	    else
		  printf "\nbbcmicro is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	    fi
	  fi
	  if [ -f "/usr/local/bin/Switch to SD2 for Roms.sh" ]; then
	    if test -z "$(cat /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh | grep bbcmicro | tr -d '\0')"
	    then
	      sudo sed -i '/sudo pkill filebrowser/s//if [ \! -d "\/roms2\/bbcmicro\/" ]\; then\n      sudo mkdir \/roms2\/bbcmicro\n  fi\n  sudo pkill filebrowser/' /usr/local/bin/Switch\ to\ SD2\ for\ Roms.sh
	    else
	      printf "\nbbcmicro is already being accounted for in the switch to sd2 script\n" | tee -a "$LOG_FILE"
	    fi
	  fi
	  sudo rm -fv /dev/shm/arkosupdate02082025.zip | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/add_bbcmicro.txt | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate02082025.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi

	printf "\nCopy correct Retroarches depending on device\n" | tee -a "$LOG_FILE"
	  cp -fv /opt/retroarch/bin/retroarch32.rk3326.unrot /opt/retroarch/bin/retroarch32 | tee -a "$LOG_FILE"
	  cp -fv /opt/retroarch/bin/retroarch.rk3326.unrot /opt/retroarch/bin/retroarch | tee -a "$LOG_FILE"
	  cp -Rfv /home/ark/filters/filters.64.rk3326/* /home/ark/.config/retroarch/filters/. | tee -a "$LOG_FILE"
	  cp -Rfv /home/ark/filters/filters.32.rk3326/* /home/ark/.config/retroarch32/filters/. | tee -a "$LOG_FILE"
	  rm -rfv /home/ark/filters/ | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch.* | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch32.* | tee -a "$LOG_FILE"

	chmod 777 /opt/retroarch/bin/*

	printf "\nCopy correct emulationstation depending on device\n" | tee -a "$LOG_FILE"
	  sudo mv -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"


	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth
	echo "$UPDATE_DATE" > /home/ark/.config/.VERSION

	touch "/home/ark/.config/.update02082025"

fi

if [ ! -f "$UPDATE_DONE" ]; then

	printf "\nUpdate retroarch to the correct stable 1.20.0 to fix override issue from later commit\nUpdate emulationstation to fix missing popup keyboard fonts\nUpdate emulationstation to add various featurs thanks to bulzipke\nUpdate retroarch and retroarch32 common overlays\n" | tee -a "$LOG_FILE"
	sudo rm -rf /dev/shm/*
	sudo wget -t 3 -T 60 --no-check-certificate "$LOCATION"/02092025/arkosupdate02092025.zip -O /dev/shm/arkosupdate02092025.zip -a "$LOG_FILE" || sudo rm -f /dev/shm/arkosupdate02092025.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/arkosupdate02092025.zip" ]; then
	  sudo unzip -X -o /dev/shm/arkosupdate02092025.zip -d / | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate02092025.zip | tee -a "$LOG_FILE"
	else
	  printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." | tee -a "$LOG_FILE"
	  sudo rm -fv /dev/shm/arkosupdate02092025.z* | tee -a "$LOG_FILE"
	  sleep 3
	  echo $c_brightness > /sys/class/backlight/backlight/brightness
	  exit 1
	fi

	printf "\nCopy correct Retroarches depending on device\n" | tee -a "$LOG_FILE"
	  cp -fv /opt/retroarch/bin/retroarch32.rk3326.unrot /opt/retroarch/bin/retroarch32 | tee -a "$LOG_FILE"
	  cp -fv /opt/retroarch/bin/retroarch.rk3326.unrot /opt/retroarch/bin/retroarch | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch.* | tee -a "$LOG_FILE"
	  rm -fv /opt/retroarch/bin/retroarch32.* | tee -a "$LOG_FILE"

	chmod 777 /opt/retroarch/bin/*

	printf "\nCopy correct emulationstation depending on device\n" | tee -a "$LOG_FILE"
	  sudo mv -fv /home/ark/emulationstation.351v /usr/bin/emulationstation/emulationstation | tee -a "$LOG_FILE"
	  sudo rm -fv /home/ark/emulationstation.* | tee -a "$LOG_FILE"
	  sudo chmod -v 777 /usr/bin/emulationstation/emulationstation* | tee -a "$LOG_FILE"
	  
	printf "\nCopy correct ogage and retroarch config for the R36H\n" | tee -a "$LOG_FILE" 
	  sudo mv -f -v /home/ark/ra/retroarch.r36h /home/ark/.config/retroarch/retroarch.r36h | tee -a "$LOG_FILE"
	  sudo mv -f -v /home/ark/ra32/retroarch32.r36h /home/ark/.config/retroarch32/retroarch.r36h | tee -a "$LOG_FILE"
	  sudo mv -f -v /home/ark/ogage.351mp /usr/local/bin/ogage.351mp | tee -a "$LOG_FILE"
	  sudo rm -rfv /home/ark/ra32 | tee -a "$LOG_FILE"
	  sudo chmod -R +x /opt/system/*
	  
	printf "\nUpdate es_systems.cfg and es_systems.cfg.dual files for Read from Both Script\n" | tee -a "$LOG_FILE"
	sudo chmod -R 755 /usr/local/bin/ | tee -a "$LOG_FILE"
	sudo chmod 755 /opt/scummvm/scummvm | tee -a "$LOG_FILE"
	sudo chown ark:ark /opt/scummvm/scummvm | tee -a "$LOG_FILE"

	sudo rm -f /etc/emulationstation/es_systems.cfg.dual | tee -a "$LOG_FILE"
	sudo rm -f /etc/emulationstation/es_systems.cfg | tee -a "$LOG_FILE"
	sudo cp -fv /usr/local/bin/es_systems.cfg.dual /etc/emulationstation/es_systems.cfg.dual | tee -a "$LOG_FILE"
	sudo cp -fv /usr/local/bin/es_systems.cfg.single /etc/emulationstation/es_systems.cfg | tee -a "$LOG_FILE"

	printf "\nUpdate boot text to reflect current version of ArkOS\n" | tee -a "$LOG_FILE"
	sudo sed -i "/title\=/c\title\=ArkOS 2.0 ($UPDATE_DATE)(AeUX)" /usr/share/plymouth/themes/text.plymouth
	echo "$UPDATE_DATE" > /home/ark/.config/.VERSION

	touch "$UPDATE_DONE"	
	

	rm -v -- "$0" | tee -a "$LOG_FILE"
	printf "\033c" >> /dev/tty1
	msgbox "Updates have been completed.  System will now restart after you hit the A button to continue.  If the system doesn't restart after pressing A, just restart the system manually."
	echo $c_brightness > /sys/class/backlight/backlight/brightness
	sudo reboot
	exit 187
fi




