#!/bin/bash

source /etc/os-release

OS="${ID}"


function isRoot() {
        if [ "${EUID}" -ne 0 ]; then
                echo "You need to run this script as root"
                exit 1
        fi
}


sudo apt-get update
sudo apt-get upgrade -y


if [ ! -x "$(command -v python)" ]; then
    echo "Install python"
    sudo apt install python3 -y
    sudo apt install python3-pip
else
    echo "Python is installed"
fi


if [ -x "$(command -v docker --version)" ]; then
    echo "Docker is installed!"
else
    echo "You need to install docker? yes - yes, n - no"

    read docker_need


    if [ "$docker_need" = "yes" ]; then
        sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        sudo apt update
        sudo apt install docker-ce -y
        if [-x "$(command -v docker --version)" ]; then
           echo "Docker was installed!"
        fi
    fi
fi

echo "You need to create folder for your project? yes - yes, n - no"

read folder

if [ "$folder" = "yes" ]; then
    echo "Write name of folder:"

    read folder_name

    mkdir $folder_name

fi

echo "Setup is complete"
