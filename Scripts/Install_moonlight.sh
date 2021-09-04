#!/bin/bash
set -euo pipefail
raspbiancodename=$(grep VERSION_CODENAME= /etc/os-release |cut -d= -f)

echo -e "\nAdding Moonlight to Sources List..."

if grep -q "deb http://archive.itimmer.nl/raspbian/moonlight ${raspbiancodename} main" /etc/apt/sources.list; then
    echo -e "NOTE: Moonlight Source Exists - Skipping"
else
    echo -e "Adding Moonlight to Sources List"
    echo "deb http://archive.itimmer.nl/raspbian/moonlight ${raspbiancodename} main" >> /etc/apt/sources.list
fi

echo -e "\nFetching and installing the GPG key....\n"

if [ -f "${0}"itimmer.gpg ]
then	
    echo -e "NOTE: GPG Key Exists - Skipping"
else		
    wget http://archive.itimmer.nl/itimmer.gpg -P "${0}"
    chown pi:pi "${0}"/itimmer.gpg
    apt-key add "${0}"/itimmer.gpg		
fi

echo -e "\nUpdating Apt Search Repos..."
apt-get update -y

echo "Compile or Apt Install? (y/n)')" 
read -p COMPILE
	
echo -e "\nInstalling Moonlight..."

case ${COMPILE} in
    y)
        echo -e "\Compile Time..."
        echo -e "\nInstalling Dependancies and cloning repo..."

        sudo apt-get install git libopus0 libexpat1 libasound2 libudev1 libavahi-client3 libcurl4 libevdev2 libenet7 libssl-dev libopus-dev libasound2-dev libudev-dev libavahi-client-dev libcurl4-openssl-dev libevdev-dev libexpat1-dev libpulse-dev uuid-dev libenet-dev cmake gcc g++ fakeroot debhelper -y
        sudo apt-get install libraspberrypi-dev -y

        git clone https://github.com/irtimmer/moonlight-embedded.git "${0}/moonlight-embedded"
        cd "${0}"/moonlight-embedded || exit
        git submodule update --init
        mkdir build
        cd build/ || exit

        echo -e "\nIt's Build time...Good luck..."
        cmake ../
        make
        sudo make install
        sudo ldconfig 
        rm -rf ""  
        ;;
    n)
        echo -e "\n Apt Install Moonlight-Embedded..."
        apt install moonlight-embedded
        ;;
    *) 
        echo "INVALID NUMBER!" 
        ;;
esac


# If install Cool if not....
if command -v moonlight; then
    echo -e "\nMoonlight Installed!"
else
    echo "Something Went Wrong..."
    exit
fi 

