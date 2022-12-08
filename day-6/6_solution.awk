#!/usr/bin/awk -f

function count_number_of_distinct_elements() {
    result=0
    for (j=0; j<SLIDING_WINDOW_SIZE; j++) {
        el=sliding_window_to_check[j]
        if (seen[el] == 0) {
            result+=1
            seen[el]=1
        }
    }
    delete seen
    return result
}

BEGIN { 
    FS=""
    SLIDING_WINDOW_SIZE=4
}
{
    for (i=1; i<=NF; i++) {
        sliding_window_to_check[i%SLIDING_WINDOW_SIZE]=$i

        if (i>=SLIDING_WINDOW_SIZE && count_number_of_distinct_elements()==SLIDING_WINDOW_SIZE) {
            print "solution found at", i
            break
        }
    }
}
