 #!/bin/bash
hosts=("14.0.0.22" "14.1.0.20" "14.1.0.17" "14.0.0.17")
for i in "${hosts[@]}"
do
        j="0"
        while [ $j -lt 9 ]
        do
                ping $i -c 60 >> "result.txt"
                j=$[$j+1]
        done
done
