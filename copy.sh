#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NOC='\033[0m'

usage()
{
    echo "Usage   : $0 [ OPTIONS ]"
    echo "Options :  "
    echo "     -f <path/to/file> : file to be copied"
    echo "     -p <path> : path on the initramfs where the file will be copied to (default : root/)"
}

if [ $# -eq 0 ]
then
    usage
    exit
fi


ROOTFS="files/rootfs.cpio"
RPATH="root"

while getopts ":f:p:" opt ;do
    case "${opt}" in
        f)
            FILE=$OPTARG
            ;;
        p)  
            RPATH=$OPTARG
            ;;
        h)
            usage
            ;;
        \?)
            echo "Invalid option: $OPTARG" 1>&2
            ;;
        :)
            echo "Invalid option: $OPTARG requires an argument" 1>&2
            ;;
    esac
done

if [ -e $FILE ]
then
    if [ -e "$ROOTFS" ]
    then
        cp $ROOTFS $ROOTFS-$(date '+%T')
        rm -dR files/rootfs
        mkdir files/rootfs
        cd files/rootfs
        cat ../../$ROOTFS | fakeroot cpio -idm
        cp ../../$FILE $RPATH/
        find . | fakeroot cpio -o -H newc > ../rootfs.cpio
        cd ../../
    else
        echo "${RED} $ROOTFS does not exist ${NOC}"
    fi
else
    echo "${RED} $FILE does not exist ${NOC}"
fi
