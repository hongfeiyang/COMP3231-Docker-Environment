#!/bin/sh

ASST=asst2
BUILD=ASST2

# Configure

cd ~/cs3231/"${ASST}"-src
./configure
# bmake WERROR="-Wno-error=uninitialized"
bmake # for asst 2, need to build and install the user-level programs that will be run by your kernel in this assignment
bmake install


cd ~/cs3231/"${ASST}"-src/kern/conf
./config "${BUILD}"

# Build

cd ../compile/"${BUILD}"

bmake depend

chmod +x ../../conf/newvers.sh

bmake
bmake install

