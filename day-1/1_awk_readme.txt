awk -v FS='\n' -v RS= -v ORS='\n\n' '{ sum += $1 } END { print sum }' 1_input.txt

# what is NR, FR, FNR - awk builtins
awk -v FS='\n' -v RS= -v ORS='\n\n' '{ print "NR: " NR ", NF: " NF ", FNR: " FNR "; " $0 }' 1_input.txt

# iterate over all columns of a row
# due to FS/RS/ORS overrides, for us row==block until double new line, column==row inside block
# for each row (block), sum up all columns (rows in block), then compare the sum to a max value per block and set max=sum if sum>max
awk -v FS='\n' -v RS= -v ORS='\n\n' '{ 
    sum = 0
    for (x = 1; x <= NF; x++) {
        sum += $x
    }
    print NR,sum

    if (sum > max) {
        max = sum
    }
} 
END { print "max",max }' 1_input.txt

# solution 1: ./1_find_max_sum.awk 1_input.txt
# solution 2: ./1_find_all_sums.awk 1_input_test.txt | grep . | sort -n | tail -3 | ./1_sum_all_lines.awk
