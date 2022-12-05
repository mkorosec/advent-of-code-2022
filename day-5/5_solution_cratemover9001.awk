#!/usr/bin/awk -f 
function print_stacks() {
    print "------ print current stack states ------"
    for (i=1; i<=MAX_STACK_INDEX; i++) {
        for (j=1; j<=stacks_current_max_index[i]; j++) {
            print "stack", i, "index", j, "value", stacks[i,j]
        }
    }
#    print "------ /print current stack states ------"
#    print ""
}
function reverse_stacks() {
#    print "MAX_STACK_INDEX", MAX_STACK_INDEX
#    print "INITIAL_MAX_STACK_SIZE", INITIAL_MAX_STACK_SIZE
    for (i=1; i<=MAX_STACK_INDEX; i++) {
        for (j=1; j<=INITIAL_MAX_STACK_SIZE/2; j++) {
#            print "switch values", stacks[i,j], stacks[i,INITIAL_MAX_STACK_SIZE-j+1]
            tmp=stacks[i,j]
            stacks[i,j]=stacks[i,INITIAL_MAX_STACK_SIZE-j+1]
            stacks[i,INITIAL_MAX_STACK_SIZE-j+1]=tmp
        }
    }
}
function move(crates_to_move, start_stack, end_stack) {
#    print "moving crates_to_move", crates_to_move, "start_stack", start_stack, "end_stack", end_stack, "."
#    print "stacks_current_max_index[start_stack]", stacks_current_max_index[start_stack]
#    print "stacks_current_max_index[end_stack]", stacks_current_max_index[end_stack]

    start_stack_index=stacks_current_max_index[start_stack]-crates_to_move

    for (i=1; i<=crates_to_move; i++) {
        start_stack_index+=1
        end_stack_index=stacks_current_max_index[end_stack]+1
#        print "moving crate", i, "start_stack_index", start_stack_index, "end_stack_index", end_stack_index

        crate_value_to_move=stacks[start_stack, start_stack_index]
        stacks[end_stack, end_stack_index]=crate_value_to_move
        stacks[start_stack, start_stack_index]=""

        stacks_current_max_index[end_stack]+=1
    }

    stacks_current_max_index[start_stack]-=crates_to_move
#    print_stacks()
#    print ""
}

BEGIN {
    FS=""
    process_crates_layout=1
    process_crates_move_steps=0
}

{
    if (process_crates_layout==1) {
        for (x = 1; x <= NF; x++) {
            if ($x ~ "[A-Z]") {
#                print NR, NF, x, $x
                CRATE_SYMBOL=$x
                STACK_INDEX=(x+2)/4
                
#                print "CRATE_SYMBOL", CRATE_SYMBOL, "STACK_INDEX", STACK_INDEX
                
                stacks[STACK_INDEX, NR]=CRATE_SYMBOL
                stacks_current_max_index[STACK_INDEX]+=1

                if (STACK_INDEX>MAX_STACK_INDEX) {
                    MAX_STACK_INDEX=STACK_INDEX
                }
            }
        }
    } else if (process_crates_move_steps==1 && length($0)>5) {
#        print "crates_to_move", $2, "start_stack", $4, "end_stack", $6
        move($2,$4,$6)
    }

    if ($0 ~ "^[^a-zA-Z]*$" && length($0) > 3) {
        #print "checkpoint 1", $0
        INITIAL_MAX_STACK_SIZE=NR-1
        print "------ done reading stacks: reached the end of crates definition, what follows are the move steps ------\n"
        print "------ reverse: reading of the stacks was reverse of actual stacks, so we need to reverse the stacks ------\n"
        reverse_stacks()
#        print_stacks()

        print "------ move crates: start processing steps that move crates ------\n"
        FS=" "
        process_crates_move_steps=1
        process_crates_layout=0
    }
} 

END {
    print "------ solution: read only the top-most element in each stack ------\n"
    for (i=1; i<=MAX_STACK_INDEX; i++) {
        printf("%s", stacks[i,stacks_current_max_index[i]])
    }
    print ""
}