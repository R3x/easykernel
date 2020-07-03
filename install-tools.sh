#!/bin/bash

mkdir debugtools
cd debugtools

# strace
git clone https://github.com/strace/strace
cd strace
./bootstrap
export LDFLAGS='-static -pthread'
./configure
make
cd ../../
./copy.sh -f debugtools/strace/strace -p usr/bin
