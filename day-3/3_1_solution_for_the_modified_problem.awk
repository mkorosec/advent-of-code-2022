#!/usr/bin/awk -f 

BEGIN { 
    FS=""; 
    priority_lookup="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
}

{ 
    if (NF%2==0) {
        RUCKSACK_SIZE=NF
    } else {
        RUCKSACK_SIZE=NF-1
    }
}

NR%3==1 { 
    # first gnome
    for (x = 1; x <= RUCKSACK_SIZE; x++) {
        ITEM_INDEX=index(priority_lookup, $x)
        seen_in_first_rucksack[ITEM_INDEX]++
    }
}

NR%3==2 { 
    # second gnome
    for (x = 1; x <= RUCKSACK_SIZE; x++) {
        ITEM_INDEX=index(priority_lookup, $x)
        if (seen_in_first_rucksack[ITEM_INDEX]>0) {
            seen_in_both_first_and_second_rucksack[ITEM_INDEX]++
        }
    }
} 

NR%3==0 { 
    # this is the 3rd line

    for (x = 1; x <= RUCKSACK_SIZE; x++) {
        ITEM_INDEX=index(priority_lookup, $x)
        if (seen_in_both_first_and_second_rucksack[ITEM_INDEX]>0) {
            THIS_IS_THE_ITEM_WE_ARE_LOOKING_FOR=$x
            THIS_IS_THE_PRIO_OF_THE_ITEM_WE_ARE_LOOKING_FOR=ITEM_INDEX
            break
        }
    }

    sum += THIS_IS_THE_PRIO_OF_THE_ITEM_WE_ARE_LOOKING_FOR

    print NR, "THIS_IS_THE_ITEM_WE_ARE_LOOKING_FOR", THIS_IS_THE_ITEM_WE_ARE_LOOKING_FOR, "PRIORITY=", THIS_IS_THE_PRIO_OF_THE_ITEM_WE_ARE_LOOKING_FOR

    # cleanup
    for (x = 1; x <= 52; x++) {
        seen_in_first_rucksack[x]=0
        seen_in_both_first_and_second_rucksack[x]=0
    }
    
}

END { print "result", sum }