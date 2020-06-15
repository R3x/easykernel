#!/bin/bash

usage()
{
    echo "Usage   : $0 [ OPTIONS ]"
    echo "Options :  "
    echo "     -s : Setup Kernel Environment "
}

if [ $# -eq 0 ]
then
    usage
    exit
fi

while getopts ":s:" opt ;do
    case "${opt}" in
        s)
            echo -e "\n---- Installing Kernel Headers -----\n\n"
            sudo apt update && sudo apt install -y linux-headers-$(uname -r)
            
            echo -e "\n---- Installing QEMU -----\n\n"
            sudo apt update && sudo apt-get install -y qemu qemu-user qemu-user-static

			echo -e "\n ---- Installing GDB -------\n"
			sudo apt-get install gdb
			
            echo -e "\n---- Installing Kernel Sources -----\n\n"
            mkdir kernel_source
            cd kernel_source
            wget -c  https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.18.16.tar.xz
            tar -xvf linux-4.18.16.tar.xz
            cd ../
			
			echo -e "\n---- Preparing Kernel for Module Compilation ----\n\n"
			sudo apt install bison
			sudo apt install flex
			sudo apt install libelf-dev

			cd ./kernel_source/linux-4.18.16/
            make x86_64_defconfig
            make modules_prepare
            cd ../..
