# easykernel

This is an attempt to create a quick and easy kernel setup for Kernel Development and also for kernel exploitation challenges in CTFs.
Kick back and have a cup of coffee while easy kernel builds you the setup you want!

## Outline

We build kernel images with [Buildroot](https://buildroot.org/) - which is a commonly used tool for easily building kernel images for Embedded Linux kernel. We will also add some additional tools into the kernel image by adding [busybox](https://busybox.net/) and also add some statically compiled tools taking inspiration from [initramfs-wrap](https://github.com/mephi42/initramfs-wrap)

## Setup

You can use [dependencies.sh](dependencies.sh/) to install all the possible dependencies that are required.
## Further Hacking

If you want to add more tools/features on to the kernel for your purposes. You can do so by compiling them statically and copying them onto the kernel. If your tool is supported by buildroot - then you can add it using buildroot.

### Improving buildroot config

The repo currently uses a custom buildroot configuration that's based on the `qemu_x86-64-defconfig` provided by buildroot. However you can use your own buildroot configuration to build images.

You can use any of the existing ones that buildroot has by running `make <config-name>`. These or the existing one can be then modified using either of these commands. 
```sh
$> make menuconfig
$> make config
```

## TODO

- Try to add [conan](https://conan.io/) to use statically generated files for improving speed of building images.
- Add wrappers for GDB scripts for debugging kernels

## Links

There are various links that I refered to while searching for good ways of creating a Linux kernel setup. I posted a few of them here. 

- [Speeding kernel development using QEMU](https://lwn.net/Articles/660404/)
- [Linux kernel + Busy box](https://www.zachpfeffer.com/single-post/Build-the-Linux-kernel-and-Busybox-and-run-on-QEMU)
- [Kernel + Buildroot + Conan](https://blog.conan.io/2019/08/27/Creating-small-Linux-images-with-Buildroot.html)


## AUTHOR

This repo is maintained by Siddharth Muralee (@R3x). 