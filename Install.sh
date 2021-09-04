#!/bin/bashi
set -euo pipefail
SCRIPT=$(basename "$0")
if [ "${UID}" != 0 ]; then
    echo "Please Run sudo ${SCRIPT}"
    exit $?
fi
# Get the realpath that the installer is coming from
HERE="$(realpath "$(dirname "$0")")"
# Should get the home directory of the user running the script
PIHOME=$(getent passwd ${SUDO_USER} | cut -d: -f6)

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
        if command -v moonlight; then
            echo -e "\nMoonlight Installed!"
        else    
            sudo bash ./Scripts/Install_moonlight.sh "${HERE}"
        fi
        sudo bash ./Scripts/Pair_moonlight.sh
        sudo bash ./Scripts/Install_moonlight_menu.sh "${HERE}" "${PIHOME}"
        sudo bash ./Scripts/Install_Scripts.sh "${HERE}" "${PIHOME}"
        sudo bash ./Scripts/Install_themes.sh "${HERE}"	
        ;;
    2)
        sudo bash ./Scripts/Install_moonlight.sh "${HERE}"
        sudo bash ./Install.sh
        ;;
    3)				
        sudo bash ./Scripts/Pair_moonlight.sh
        sudo bash ./Install.sh
        ;;
    4)
        sudo bash ./Scripts/Install_moonlight_menu.sh "${HERE}" "${PIHOME}"
        sudo bash ./Install.sh
        ;;	
    5) 
        sudo bash ./Scripts/Install_Scripts.sh "${HERE}" "${PIHOME}"
        sudo bash ./Install.sh
        ;;
    6)  
        sudo bash ./Scripts/Install_themes.sh "${HERE}"
        sudo bash ./Install.sh
        ;;
    7)
        echo -e "\nRemoving all Moonlight launch scripts..."
        rm -rf "${PIHOME}"/RetroPie/roms/moonlight	
        sudo bash "${HERE}"/Install.sh
        ;;
    8)
        exit 1
        ;;		
    *) echo "INVALID NUMBER!" ;;
esac
