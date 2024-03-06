#!/bin/sh

cd ~/cs3231/asst1-src
./configure
bmake WERROR="-Wno-error=uninitialized"
bmake install


cd ~/cs3231/asst1-src/kern/conf
./config ASST1
cd ../compile/ASST1

bmake depend

chmod +x ../../conf/newvers.sh

bmake
bmake install

