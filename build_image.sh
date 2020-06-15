#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NOC='\033[0m'

usage()
{
    echo "Usage   : $0 [ OPTIONS ]"
    echo "Options :  "
    echo "     -d : install dependencies "
    echo "     -s : install buildroot"
    echo "     -i : install default kernel"
    echo "     -p <version> : Installs custom kernel version"
    echo "     -h : show this message"
}

if [ $# -eq 0 ]
then
    usage
    exit
fi

while getopts ":dsihp:" opt ;do
    case "${opt}" in
        d) 
            echo -e "\n ---- Installing Dependencies (QEMU version that Buildroot installs is suggested!) -------\n"
            sudo apt update && sudo apt-get install -y qemu qemu-user qemu-user-static
			sudo apt-get install gdb
			;;
        s)
            echo -e "${GREEN} Setting up buildroot for kernel installation ${NOC}"
            wget https://buildroot.org/downloads/buildroot-2020.02.3.tar.gz
            tar -xzf buildroot-2020.02.3.tar.gz
            mv buildroot-2020.02.3/ buildroot/
            rm buildroot-2020.02.3.tar.gz 
            if [[ -d 'buildroot' ]]
            then
                echo -e "${GREEN} buildroot config completed ${NOC}"
            fi
            ;;
        i)
            echo -e "${GREEN} Installing linux kernel version 5.4.46 (Which is latest LTS) ${NOC}"
            mkdir files
            if [[ -d 'buildroot' ]]
            then
                echo -e "${GREEN} buildroot found! starting Installation - This will take a while........... ${NOC}"
                cp buildroot.conf buildroot/.config
                cd buildroot/
                make
                if [[ -d 'output/images' ]]
                then
                    cd output/images
                    if [ -e 'bzImage' ]
                    then
                        cp bzImage ../../../files/
                    else
                        echo -e "${RED} bzImage not found ${NOC}"
                        exit 0
                    fi
                    if [ -e 'rootfs.cpio' ]
                    then
                        cp rootfs.cpio ../../../files/
                    else
                        echo -e "${RED} rootfs.cpio not found. Maybe config was improper? ${NOC}"
                        exit 0
                    fi
                    cd ../../../
                else
                    echo -e "${RED} buildroot output not found! maybe error? ${NOC}"
                    exit 0
                fi
            else
                echo -e "${RED} buildroot not found! try running `./build_image.sh -s` to install buildroot ${NOC}"
                exit 0
            fi

            echo -e "${GREEN} Okay we are Ready to go! You can find your compiled files in `files/` ${NOC}"
            ;;
        h)
            usage
            ;;
        p)
            echo "$OPTARG"
            ;;
        \?)
            echo "Invalid option: $OPTARG" 1>&2
            ;;
        :)
            echo "Invalid option: $OPTARG requires an argument" 1>&2
            ;;
    esac
done
    
