#!/bin/bash

# Get the realpath that the installer is coming from
here="$(realpath "$(dirname "$0")")"
# Should get the home directory of the user running the script
pihome=$(getent passwd ${SUDO_USER} | cut -d: -f6)

echo -e "\n****************************************************************"
echo -e "Welcome to the Moonlight Installer Script for RetroPie"
echo -e "****************************************************************\n"
echo -e "Select an option:"
echo -e " * 1: Complete Install and Setup"
echo -e " * 2: Install Moonlight"
echo -e " * 3: Pair Moonlight to PC"
echo -e " * 4: Install Moonlight Menu in RetroPie"
echo -e " * 5: Install Moonlight Refresh Script in RetroPie"
echo -e " * 6: Install Moonlight themes"
echo -e " * 7: Remove Launch Scripts"
echo -e " * 8: Exit"

read -r NUM
case ${NUM} in 
    1)
        sudo bash ./Scripts/Install_moonlight.sh "${here}"
        sudo bash ./Scripts/Pair_moonlight.sh
        sudo bash ./Scripts/Install_moonlight_menu.sh
        sudo bash ./Scripts/Install_Scripts.sh
        sudo bash ./Scripts/Install_themes.sh	
        ;;
    2)
        sudo bash ./Scripts/Install_moonlight.sh "${here}"
        sudo bash ./Install.sh
        ;;
    3)				
        sudo bash ./Scripts/Pair_moonlight.sh
        sudo bash ./Install.sh
        ;;
    4)
        sudo bash ./Scripts/Install_moonlight_menu.sh "${here}" "${pihome}"
        sudo bash ./Install.sh
        ;;	
    5) 
        sudo bash ./Scripts/Install_Scripts.sh "${here}" "${pihome}"
        sudo bash ./Install.sh
        ;;
    6)  
        sudo bash ./Scripts/Install_themes.sh "${here}"
        sudo bash ./Install.sh
        ;;
    7)
        echo -e "\nRemoving all Moonlight launch scripts..."
        rm -rf "${pihome}"/RetroPie/roms/moonlight	
        sudo bash "${here}"/Install.sh
        ;;
    8)
        exit 1
        ;;		
    *) echo "INVALID NUMBER!" ;;
esac
