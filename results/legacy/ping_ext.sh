 #!/bin/bash
hosts=("10.0.100.129" "10.0.100.126" "10.0.100.127" "10.0.100.144" "10.0.100.140" "10.0.100.141")
for i in "${hosts[@]}"
do
        j="0"
        while [ $j -lt 10 ]
        do
                ping $i -c 60 >> "result_ping_ext_20150927.txt"
                j=$[$j+1]
        done
done
