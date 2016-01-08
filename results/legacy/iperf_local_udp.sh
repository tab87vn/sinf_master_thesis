 #!/bin/bash
hosts=("14.0.0.22" "14.1.0.20" "14.1.0.17" "14.0.0.17")
#hosts=("14.0.0.22")
for i in "${hosts[@]}"
do
        iperf -u -c $i -t 30 -i 1 -b 100M >> "result_iperf_udp_local_20151022.txt"
        sleep 5
        iperf -u -c $i -t 30 -i 1 -b 200M >> "result_iperf_udp_local_20151022.txt"
        sleep 5
        iperf -u -c $i -t 30 -i 1 -b 300M >> "result_iperf_udp_local_20151022.txt"
        sleep 5
        iperf -u -c $i -t 30 -i 1 -b 400M >> "result_iperf_udp_local_20151022.txt"
        sleep 5
        iperf -u -c $i -t 30 -i 1 -b 500M >> "result_iperf_udp_local_20151022.txt"
        sleep 5
        iperf -u -c $i -t 30 -i 1 -b 600M >> "result_iperf_udp_local_20151022.txt"
        sleep 5
        iperf -u -c $i -t 30 -i 1 -b 700M >> "result_iperf_udp_local_20151022.txt"
        sleep 5
        iperf -u -c $i -t 30 -i 1 -b 800M >> "result_iperf_udp_local_20151022.txt"
        sleep 5
        iperf -u -c $i -t 30 -i 1 -b 900M >> "result_iperf_udp_local_20151022.txt"
        sleep 5
        iperf -u -c $i -t 30 -i 1 -b 1000M >> "result_iperf_udp_local_20151022.txt"
        sleep 5
done
