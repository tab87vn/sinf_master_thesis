 #!/bin/bash
hosts=("14.0.0.22" "14.1.0.20" "14.1.0.17" "14.0.0.17")
#hosts=("14.0.0.22")
for i in "${hosts[@]}"
do
        j="0"
        while [ $j -lt 10 ]
        do
                iperf -c $i -t 60 -i 1 >> "result_iperf_local_20151226.txt"
                j=$[$j+1]
        done
done
# run for the ext now
sleep 10
hosts=("10.0.100.129" "10.0.100.126" "10.0.100.127" "10.0.100.144" "10.0.100.140" "10.0.100.141")
for i in "${hosts[@]}"
do
        j="0"
        while [ $j -lt 10 ]
        do
                iperf -c $i -t 60 -i 1 >> "result_iperf_ext_20151226.txt"
                j=$[$j+1]
        done
done
