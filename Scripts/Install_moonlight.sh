#!/bin/bash

if command -v moonlight; then
    echo "Moonlight Already Installed, moving on"
    exit
fi




raspbiancodename=$(grep VERSION_CODENAME= /etc/os-release |cut -d= -f)

# Stupid two lines, SED is my bane at this point
#ID=$(grep ID= /etc/os-release |sort|cut -d= -f 2)

# redid this based on https://github.com/moonlight-stream/moonlight-embedded/wiki/Packages
ID="raspbian"
curl -1sLf 'https://dl.cloudsmith.io/public/moonlight-game-streaming/moonlight-embedded/setup.deb.sh' | distro=${ID} codename=${raspbiancodename} sudo -E bash

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

