#!/bin/bash
hosts=("11.0.0.18" "11.0.0.21" "12.0.0.5" "12.0.0.6")
for i in "${hosts[@]}"
do
	j="0"
	while [ $j -lt 10 ]
	do
        	ping $i -c 60 >> "result_ping_legacy_local_20151226.txt"
		j=$[$j+1]
        done
done
hosts=("10.0.100.102" "10.0.100.103" "10.0.100.104" "10.0.100.105" "10.0.100.116" "10.0.100.117")
for i in "${hosts[@]}"
do
        j="0"
        while [ $j -lt 10 ]
        do
                ping $i -c 60 >> "result_ping_legacy_ext_20151226.txt"
                j=$[$j+1]
        done
done
