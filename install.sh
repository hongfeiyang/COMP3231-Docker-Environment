#!/bin/sh

ASST=asst3
BUILD=ASST3

# Configure

cd ~/cs3231/"${ASST}"-src
./configure
# bmake WERROR="-Wno-error=uninitialized"

cd ~/cs3231/"${ASST}"-src
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

# download config file
cd ~/cs3231/root
wget -O sys161.conf http://cgi.cse.unsw.edu.au/~cs3231/24T1/assignments/"${ASST}"/sys161.conf
