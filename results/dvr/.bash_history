ping 11.0.0.21
ifconfig
sudo mv iperf /usr/bin/
iperf -c 11.0.0.21 -i 2 -t 30
ping 11.0.0.21 -c 15 -i 2
iperf -s
iperf -c 12.0.0.6 -i 2 -t 30
iperf -s
iperf -c 12.0.0.6 -i 2 -t 30
ping 12.0.0.6 -c 15 -i 2
iperf -c 11.0.0.18 -t 30 -i 2
iperf -s
ping 11.0.0.18 -c 15 -i 2
iperf -c 12.0.0.5 -i 2 -t 30
iperf -s
iperf -c 12.0.0.5 -i 2 -t 30
ping 12.0.0.5 -c 15 -i 2
ping 12.0.0.5
iperf -c 12.0.0.5 -t 30 -i 2
iperf -c 12.0.0.5 -t 30 
iperf -c 12.0.0.5 -t 30 -i 2
exit
iperf -c 127.0.0.1 -i 2
ifconfig
ping 11.0.0.18
iperf -c 11.0.0.18 -i 2
iperf -c 11.0.0.18 -i 2 -t 60
iperf -s
top
tmux
iperf -c 11.0.0.18 -i 2
iperf -c 11.0.0.21 -i 2
exit
ping 11.0.0.18 -c 60
ping 11.0.0.21 -c 60
exit
iperf -c 11.0.0.21 -t 60 -i 1 -u -b 100M
iperf -c 11.0.0.21 -t 60 -i 1 -u -b 200M
iperf -c 11.0.0.21 -t 60 -i 1 -u -b 300M
iperf -c 11.0.0.21 -t 60 -i 1 -u -b 400M
iperf -c 11.0.0.21 -t 60 -i 1 -u -b 500M
iperf -c 11.0.0.21 -t 60 -i 1 -u -b 600M
iperf -c 11.0.0.21 -t 60 -i 1 -u -b 700M
iperf -c 11.0.0.21 -t 60 -i 1 -u -b 800M
iperf -c 11.0.0.21 -t 60 -i 1 -u -b 900M
iperf -c 11.0.0.21 -t 60 -i 1 -u -b 1000M
sudo -s
iperf -c 12.0.0.5 -u -t 60 -i 1 -b 100M
ping 12.0.0.5
iperf -c 12.0.0.5
iperf -c 12.0.0.5 -u -t 60 -i 1 -b 100M
iperf -u -c 12.0.0.5 -t 60 -i 1 -b 100M
iperf -c 12.0.0.5 -t 60 -i 1 -b 100M
iperf -c 12.0.0.5 -t 60 -i 1 
exit
exit
iperf -c 12.0.0.6 -t 60 -i 1 
iperf -u -c 12.0.0.6 -t 60 -i 1 
iperf -u -c 12.0.0.6 -t 10 -i 1 
iperf -u -c 11.0.0.21 -t 10 -i 1 
iperf -u -c 11.0.0.21 -t 10 -i 1 -b 100M
exit
iperf -c 11.0.0.18 -t 1000
clear
ping 11.0.0.18 -c 60 
ping 11.0.0.21 -c 60 
ping 12.0.0.5 -c 60 
ping 12.0.0.6 -c 60 
ping 11.0.0.21 -c 60 
ping 12.0.0.5 -c 60 
ping 12.0.0.6 -c 60 
iperf -c 11.0.0.18 
iperf -c 11.0.0.18 -t 60 -i 1
iperf -c 11.0.0.21 -t 60 -i 1
iperf -c 12.0.0.5 -t 60 -i 1
iperf -c 12.0.0.6 -t 60 -i 1
exit
sudo -s
exit
nohup iperf -c 12.0.0.5 -t 86400
kill 5794
ps -ax
ps -ax | grep iperf
nohup iperf -c 5794 -t 60
iperf -c 5794 -t 60
iperf -c 11.0.0.18 -t 60
iperf -c 11.0.0.18 -t 60 -i 1
cleare
exit
iperf -c 11.0.0.18 -t 60 -i 1
iperf -c 11.0.0.21 -t 60 -i 1
ps -ax
iperf -c 11.0.0.18 -t 60 -i 1
ps -ax | grep iper
sudo kill 5794
sudo -s
clear
sudo -s
iperf -c 11.0.0.21 -t 60 -i 1
iperf -c 12.0.0.5 -t 60 -i 1
iperf -c 12.0.0.6 -t 60 -i 1
iperf -c 11.0.0.18 -t 10 -i 1
iperf -c 12.0.0.6 -t 1
exit
ls
vi ping_local.sh 
exit
ping 11.0.0.18 -c 60
ping 11.0.0.18 -c 60 > result1.txt
cat result1.txt 
vi test.sh
chmod +x test.sh 
./test.sh 
vi test.sh
chmod +x test.sh 
./test.sh 
vi test.sh
chmod +x test.sh 
./test.sh 
vi test.sh
chmod +x test.sh 
./test.sh 
ls
ls -la
cat result.txt 
chmod +x test.sh 
vi test.sh
mv test.sh ping_local.sh
./ping_local.sh 
cat result.txt 
exit
ls
ls -la
cat result_iperf_local_20150927.txt 
claer
clear
cat result_iperf_local_20150927.txt 
clear
cat result_iperf_local_20150927.txt 
clear
ls
cat result_iperf_ext_20150927.txt 
exit
ls
vi iperf_ext.sh 
exit
vi iperf_ext.sh 
./iperf_ext.sh &
exit
iperf -u -c 10.0.100.102
iperf -u -c 10.0.100.102 -b 100M -i 1
exit
ping localhost -c 60
ping 11.0.0.17 -c 60
ping 10.0.100.111 -c 60
ping localhost -c 60
ifconfig
exit
nohup iperf -s &
ls
exit
sudo -s
exit
ls
cp iperf_local.sh iperf_local_udp.sh 
vi iperf_local_udp.sh 
./iperf_local_udp.sh 
iperf -u -c 11.0.0.18 -t 60 -i 1 -b 100M
vi iperf_local_udp.sh 
iperf -u -c 11.0.0.18 -t 60 -i 1 -b 100
iperf -u -c 11.0.0.18 -t 60 -i 1 -b 1000
iperf -u -c 11.0.0.18 -t 60 -i 1 -b 1000M
vi iperf_local_udp.sh 
iperf -u -c 11.0.0.18 -t 60 -i 1 -b 100M
vi iperf_local_udp.sh 
sudo ./iperf_local_udp.sh 
vi iperf_local_udp.sh 
sudo ./iperf_local_udp.sh 
vi iperf_local_udp.sh 
./iperf_local_udp.sh 
exit
iperf -u -c 11.0.0.18 -i 1 -t 30 -b 100M >> result_iperf_udp_local_20151022.txt
iperf -u -c 11.0.0.18 -i 1 -t 30 -b 200M >> result_iperf_udp_local_20151022.txt
iperf -u -c 11.0.0.18 -i 1 -t 30 -b 300M >> result_iperf_udp_local_20151022.txt
iperf -u -c 11.0.0.18 -i 1 -t 30 -b 400M >> result_iperf_udp_local_20151022.txt
iperf -u -c 11.0.0.18 -i 1 -t 30 -b 405M >> result_iperf_udp_local_20151022.txt
iperf -u -c 11.0.0.18 -i 1 -t 30 -b 40500M >> result_iperf_udp_local_20151022.txt
[
iperf -u -c 11.0.0.18 -i 1 -t 30 -b 600M >> result_iperf_udp_local_20151022.txt
iperf -u -c 11.0.0.18 -i 1 -t 30 -b 670M >> result_iperf_udp_local_20151022.txt
iperf -u -c 11.0.0.18 -i 1 -t 30 -b 700M >> result_iperf_udp_local_20151022.txt
iperf -u -c 11.0.0.18 -i 1 -t 30 -b 800M >> result_iperf_udp_local_20151022.txt
iperf -u -c 11.0.0.18 -i 1 -t 30 -b 900M >> result_iperf_udp_local_20151022.txt
iperf -u -c 11.0.0.18 -i 1 -t 30 -b 1000M >> result_iperf_udp_local_20151022.txt
vi iperf_local_udp.sh 
./iperf_local_udp.sh 
ls
cta result_iperf_udp_local_20151022.txt 
cat result_iperf_udp_local_20151022.txt 
exit
ls
ls -la
vi result_iperf_udp_local_20151022.txt 
iperf -u -c 12.0.0.5 -t 10 -i 1 - b 100M
iperf -u -c 12.0.0.5 -t 10 -i 1 -b 100M
iperf -u -c 12.0.0.5 -t 10 -i 1 -b 500M
iperf -u -c 11.0.0.17 -t 10 -i 1 -b 500M
iperf -u -c 11.0.0.18 -t 10 -i 1 -b 500M
ls
cat result_iperf_udp_local_20151022.txt
exit
vi iperf_local_udp.sh 
exit
ifconfig
exit
ls 
vi iperf_local.sh 
iperf -c 10.0.100.102
iperf -c 10.0.100.103
iperf -c 10.0.100.104
iperf -c 10.0.100.105
iperf -c 10.0.100.106
iperf -c 10.0.100.116
iperf -c 10.0.100.117
vi iperf_ext.sh 
vi iperf_local.sh 
./iperf_local.sh &
exit
cp iperf_local.sh iperf_full.sh
vi iperf_full.sh 
./iperf_full.sh &
exit
ls -la
ls -la | grep 1120
ls -la | grep 1121
ls
ls -la
vi iperf_full.sh 
ls
ls -la
vi iperf_full.sh 
ls -la
exit
vi iperf_full.sh 
./iperf_full.sh &
exit
vi iperf_full.sh 
./iperf_full.sh &
exit
ping 10.0.100.102
ping 10.0.100.103
ping 10.0.100.104
ping 10.0.100.105
exit
iperf -c 10.0.100.104
iperf -c 10.0.100.105
iperf -c 10.0.100.116
iperf -c 10.0.100.117
iperf -c 10.0.100.111
ls -la
reboot
sudo reboot
ls
cp ping_local.sh ping_full.sh
vi ping_ext.sh 
vi ping_full.sh 
./ping_full.sh &
exit
ls
rm data111.tar.gz 
tar -zcvf data_20151203.tar.gz ../ubuntu/
ls -la
mkdir old
mv result_* old/
ls
exit
vi ping_full.sh 
./ping_full.sh &
exit
tar -zcvf data_20151216.tar.gz ../ubuntu/
ls
exit
sudo -s
exit
ls
vi iperf_full.sh 
exit
. iperf_full.sh &
ls
cat result_iperf_legacy_local_20151225.txt 
ls -la
sudo nohup iperf -s &
clear
ls
vi iperf_full.sh 
sudo -s
ls
cat result_iperf_legacy_local_20151225.txt 
exi
exit
vi ping_full.sh 
./ping_full.sh &
exit
ls
vi iperf_full.sh 
./iperf_full.sh 
ls -la
rm result_iperf_legacy_local_20151226.txt
./iperf_full.sh &
exit
