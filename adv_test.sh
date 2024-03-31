#!/bin/sh


cd ~/cs3231/asst2-src/userland/testbin/asst2/
bmake && bmake install
cd ~/cs3231/asst2-src
./configure
cd ~/cs3231/asst2-src/kern/conf
./config ASST2
cd ../compile/ASST2
bmake depend && bmake && bmake install