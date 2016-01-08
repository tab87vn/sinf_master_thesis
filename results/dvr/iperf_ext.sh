 #!/bin/bash
hosts=("10.0.100.102" "10.0.100.103" "10.0.100.104" "10.0.100.105" "10.0.100.116" "10.0.100.117")
#hosts=("10.0.100.116" "10.0.100.117")
for i in "${hosts[@]}"
do
	j="0"
	while [ $j -lt 10 ]
	do
        	iperf -c $i -t 60 -i 1 >> "result_iperf_ext_20150928.txt"
		j=$[$j+1]
        done
done
