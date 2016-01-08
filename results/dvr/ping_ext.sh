 #!/bin/bash
hosts=("10.0.100.102" "10.0.100.103" "10.0.100.104" "10.0.100.105" "10.0.100.116" "10.0.100.117")
for i in "${hosts[@]}"
do
	j="0"
	while [ $j -lt 9 ]
	do
        	ping $i -c 60 >> "result_ext.txt"
		j=$[$j+1]
        done
done
