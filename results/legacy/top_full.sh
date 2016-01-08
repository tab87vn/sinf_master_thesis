 #!/bin/bash
#hosts=("14.0.0.22" "14.0.0.17")
#hosts=("14.0.0.22")
hosts=("10.0.100.129" "10.0.100.144")
for i in "${hosts[@]}"
do
        #j="0"
        #while [ $j -lt 10 ]
        #do
 	iperf -c $i -t 150 -i 1 >> "result_iperf_ext_20151207.txt"
        #        j=$[$j+1]
        #done
	sleep 70
done
# run for the ext now
