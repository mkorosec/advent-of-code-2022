#!/usr/bin/awk -f 

BEGIN { FS="\n";RS="";ORS="\n\n" }

{ 
    sum = 0
    for (x = 1; x <= NF; x++) {
        sum += $x
    }
    print sum
} 