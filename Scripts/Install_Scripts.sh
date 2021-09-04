#!/bin/bash

echo -e "\nCreating Refresh script in Moonlight..."

if [ -d "${1}"RetroPie/roms/moonlight ] 
then
    rm -rf "${1}"RetroPie/roms/moonlight
fi

mkdir -p /home/pi/RetroPie/roms/moonlight

chmod a+x "${0}"/Scripts/Refresh.sh
/bin/cp "${0}"/Scripts/Refresh.sh /home/pi/RetroPie/roms/moonlight/Refresh.sh
/bin/cp "${0}"/GenerateGamesList.py /home/pi/RetroPie/roms/moonlight/GenerateGamesList.py

chmod 755 /home/pi/RetroPie/roms/moonlight

echo -e "Refresh script has been added to RetroPie\n"
echo -e "After loading RetroPie, use the \"Refresh\" rom listed in the Moonlight system.\n"
