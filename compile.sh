#!/bin/sh

ASST=asst2
BUILD=ASST2

cd ~/cs3231/"${ASST}"-src/kern/compile/"${BUILD}"
bmake && bmake install