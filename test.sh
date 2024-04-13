sh compile.sh

cd ~/cs3231/root

# sys161 -p 16161 kernel "1c;q" # test for asst1

# sys161 -p 16161 kernel "p /testbin/asst2" # test for asst2 

# sys161 -p 16161 kernel "p /testbin/asst3" # test for asst3

trace161 -f out -tt kernel "p /testbin/asst3"
cd ~/cs3231