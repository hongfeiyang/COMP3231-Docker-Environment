#!/bin/sh

ASST=asst2

cd ~/cs3231/root
wget -O sys161.conf http://cgi.cse.unsw.edu.au/~cs3231/24T1/assignments/"${ASST}"/sys161.conf
sys161 -p 16161 -w kernel