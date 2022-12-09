#!/usr/bin/awk -f

function calculate_scenic_score(el_row, el_col) {
    el_value = matrix[el_row, el_col]

    #from the left
    visible_to_the_left=0
    for (x=el_col-1; x>=1; x--) {
        visible_to_the_left++
        if (matrix[el_row, x] >= el_value) {
            # stop, no additional trees are visible after this
            break;
        }
    }

    #from the right
    visible_to_the_right=0
    for (x=el_col+1; x<=columns; x++) {
        visible_to_the_right++
        if (matrix[el_row, x] >= el_value) {
            break;
        }
    }

    #from the top
    visible_to_the_top=0
    for (y=el_row-1; y>=1; y--) {
        visible_to_the_top++
        if (matrix[y, el_col] >= el_value) {
            break;
        }
    }

    #from the bottom
    visible_to_the_bottom=0
    for (y=el_row+1; y<=rows; y++) {
        visible_to_the_bottom++
        if (matrix[y, el_col] >= el_value) {
            break;
        }
    }

#    print "element(row,col)", el_row, el_col
#    print "visible_to_the_bottom =", visible_to_the_bottom
#    print "visible_to_the_left =", visible_to_the_left
#    print "visible_to_the_right =", visible_to_the_right
#    print "visible_to_the_top =", visible_to_the_top

    return visible_to_the_bottom * visible_to_the_left * visible_to_the_right * visible_to_the_top
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

    max_score = 0

    for (i=1; i<=rows; i++) {
        for (j=1; j<=columns; j++) {
            score = calculate_scenic_score(i, j)
            if (score > max_score) {
                max_score = score
            }
        }
    }

    print "max_score =", max_score
}