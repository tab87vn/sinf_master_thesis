 #!/bin/bash
hosts=("11.0.0.18" "11.0.0.21" "12.0.0.5" "12.0.0.6")
for i in "${hosts[@]}"
do
	j="0"
	while [ $j -lt 9 ]
	do
        	ping $i -c 60 >> "result.txt"
		j=$[$j+1]
        done
done
