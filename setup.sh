#!/bin/bash

usage()
{
    echo "Usage   : $0 [ OPTIONS ]"
    echo "Options :  "
    echo "     -l : Setup Localy "
}

if [ $# -eq 0 ]
then
    usage
    exit
fi

while getopts ":lv:" opt ;do
    case "${opt}" in
        l)
            echo -e "\n---- Installing Kernel Headers -----\n\n"
            sudo apt update && sudo apt install -y linux-headers-$(uname -r)
