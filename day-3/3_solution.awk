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

    for (x = 1; x <= 52; x++) {
        seen[x]=0
    }

    for (x = 1; x <= RUCKSACK_SIZE/2; x++) {
        ITEM_INDEX=index(priority_lookup, $x)
        seen[ITEM_INDEX]++
    }

    for (x = (RUCKSACK_SIZE/2)+1; x <= RUCKSACK_SIZE; x++) {
        ITEM_INDEX=index(priority_lookup, $x)
        if (seen[ITEM_INDEX]>0) {
            THIS_IS_THE_ITEM_WE_ARE_LOOKING_FOR=$x
            THIS_IS_THE_PRIO_OF_THE_ITEM_WE_ARE_LOOKING_FOR=ITEM_INDEX
            break
        }
    }

    sum += THIS_IS_THE_PRIO_OF_THE_ITEM_WE_ARE_LOOKING_FOR

    #print NR, "THIS_IS_THE_ITEM_WE_ARE_LOOKING_FOR", THIS_IS_THE_ITEM_WE_ARE_LOOKING_FOR, "PRIORITY=", THIS_IS_THE_PRIO_OF_THE_ITEM_WE_ARE_LOOKING_FOR
} 

END { print "result", sum }