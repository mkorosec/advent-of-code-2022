#!/usr/bin/awk -f

function is_largest_from_any_side(el_row, el_col) {
    el_value = matrix[el_row, el_col]


    #from the left
    visible=1
    for (x=1; x<el_col; x++) {
        if (matrix[el_row, x] >= el_value) {
            visible=0
            break;
        }
    }
    if (visible == 1) {
        return 1
    }

    #from the right
    visible=1
    for (x=el_col+1; x<=columns; x++) {
        if (matrix[el_row, x] >= el_value) {
            visible=0
            break;
        }
    }
    if (visible == 1) {
        return 1
    }

    #from the top
    visible=1
    for (y=1; y<el_row; y++) {
        if (matrix[y, el_col] >= el_value) {
            visible=0
            break;
        }
    }
    if (visible == 1) {
        return 1
    }

    #from the bottom
    visible=1
    for (y=el_row+1; y<=rows; y++) {
        if (matrix[y, el_col] >= el_value) {
            visible=0
            break;
        }
    }
    if (visible == 1) {
        return 1
    }

    return 0
}

BEGIN { 
    FS=""
}

{
    for (i=1; i<=NF; i++) {
        matrix[NR, i] = $i
    }
}

END {
    columns=NF
    rows=FNR

    number_of_edge_nodes = 2*columns + 2*rows - 4

    number_of_inner_nodes_that_are_largest_in_any_direction = 0

    for (i=2; i<rows; i++) {
        for (j=2; j<columns; j++) {
            if (is_largest_from_any_side(i, j) == 1) {
                number_of_inner_nodes_that_are_largest_in_any_direction++
#                print "this one is the largest in any direction; matrix[", i, ",", j, "] =", matrix[i, j]
            }
        }
    }

    print "number_of_edge_nodes =", number_of_edge_nodes
    print "number_of_inner_nodes_that_are_largest_in_any_direction =", number_of_inner_nodes_that_are_largest_in_any_direction
    print "solution =", number_of_edge_nodes + number_of_inner_nodes_that_are_largest_in_any_direction
}