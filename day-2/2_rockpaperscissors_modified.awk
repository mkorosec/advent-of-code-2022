#!/usr/bin/awk -f 

/X/{ 
    #print "lose"
    score += 0
    if ($1 == "A") {
        score += 3
    }
    else if ($1 == "B") {
        score += 1
    }
    else {
        score += 2
    }
} 
/Y/{ 
    #print "draw"
    score += 3
    if ($1 == "A") {
        score += 1
    }
    else if ($1 == "B") {
        score += 2
    }
    else {
        score += 3
    }
} 
/Z/{ 
    #print "win"
    score += 6
    if ($1 == "A") {
        score += 2
    }
    else if ($1 == "B") {
        score += 3
    }
    else {
        score += 1
    }
} 

END { print score }