#!/bin/sh
IMAGE_DIR=files/

if [ "${1}" = "serial-only" ]
then
    EXTRA_ARGS='-nographic'
else
    EXTRA_ARGS='-serial stdio'
fi

if [ -e '/dev/kvm' ]
then
    KVM='-machine type=pc,accel=kvm'
else
    KVM=''
fi


qemu-system-x86_64 -M pc -kernel ${IMAGE_DIR}/bzImage -initrd rootfs.cpio ${KVM} -append "rootwait root=/dev/vda console=tty1 console=ttyS0"  -net nic,model=virtio -net user  ${EXTRA_ARGS}
