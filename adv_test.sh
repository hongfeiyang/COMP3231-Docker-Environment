#!/bin/sh

ASST=asst3
BUILD=ASST3
PROG=huge

cd ~/cs3231/"${ASST}"-src/userland/testbin/"${PROG}"/
bmake && bmake install
cd ~/cs3231/"${ASST}"-src
./configure
cd ~/cs3231/"${ASST}"-src/kern/conf
./config "${BUILD}"
cd ../compile/"${BUILD}"
bmake depend && bmake && bmake install