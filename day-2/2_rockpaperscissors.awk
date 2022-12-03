#!/usr/bin/awk -f 

/X/{ 
    #print "rock"
    score += 1
    if ($1 == "A") { #draw
        score += 3
    }
    if ($1 == "C") { #win
        score += 6
    }
} 
/Y/{ 
    #print "paper"
    score += 2
    if ($1 == "B") { #draw
        score += 3
    }
    if ($1 == "A") { #win
        score += 6
    }
} 
/Z/{ 
    #print "scissors"
    score += 3
    if ($1 == "C") { #draw
        score += 3
    }
    if ($1 == "B") { #win
        score += 6
    }
} 

END { print score }