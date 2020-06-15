#!/bin/sh
IMAGE_DIR=files
QEMU=./buildroot/output/host/bin/qemu-system-x86_64

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


exec $QEMU -M pc -kernel ${IMAGE_DIR}/bzImage -initrd ${IMAGE_DIR}/rootfs.cpio ${KVM} -append "rootwait root=/dev/vda console=tty1 console=ttyS0"  -net nic,model=virtio -net user  ${EXTRA_ARGS}
