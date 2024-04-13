#!/bin/sh

ASST=asst3
BUILD=ASST3

cd ~/cs3231/"${ASST}"-src/kern/compile/"${BUILD}"
bmake && bmake install
