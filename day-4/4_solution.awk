#!/usr/bin/awk -f 

BEGIN { 
    FS=","
}

{ 
    split($1, gnome1, "-")
    split($2, gnome2, "-")

    if (gnome1[1]<=gnome2[1] && gnome1[2]>=gnome2[2]) {
        #gnome2 range is fully contained in gnome1 range
        CONTAINS_FULLY+=1
        INTERSECTS+=1
    } else if (gnome2[1]<=gnome1[1] && gnome2[2]>=gnome1[2]) {
        #gnome1 range is fully contained in gnome2 range
        CONTAINS_FULLY+=1
        INTERSECTS+=1
    } else if (gnome2[1]<=gnome1[1] && gnome1[1]<=gnome2[2]) {
        INTERSECTS+=1
    } else if (gnome2[1]<=gnome1[2] && gnome1[2]<=gnome2[2]) {
        INTERSECTS+=1
    }
}


END { 
    print "CONTAINS_FULLY", CONTAINS_FULLY 
    print "INTERSECTS", INTERSECTS 
}