#!/bin/sh

rm -rf ~/.gdbinit

echo "set auto-load safe-path /" > ~/.gdbinit

mkdir -p ~/cs3231/root/ 

rm -rf ~/cs3231/root/.gdbinit

echo "set can-use-hw-watchpoints 0" >> ~/cs3231/root/.gdbinit
echo "define connect" >> ~/cs3231/root/.gdbinit
echo "dir ~/cs3231/asst1-src/kern/compile/ASST1" >> ~/cs3231/root/.gdbinit
# target remote unix:.sockets/gdb # use this if you dont want to use custom port
echo "target remote localhost:16161" >> ~/cs3231/root/.gdbinit
echo "b panic" >> ~/cs3231/root/.gdbinit
echo "end" >> ~/cs3231/root/.gdbinit
