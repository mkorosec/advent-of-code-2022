#!/usr/bin/awk -f

function pwd() {
    return pwd_limited(current_directory_stack_head)
}

function pwd_limited(up_to_dir_index) {
    result = "/"
    for (j=2; j<=up_to_dir_index; j++) {
        result = sprintf("%s%s/", result, current_directory_stack[j])
    }
    return result
}

function cd_move_to_root() {
    current_directory_stack_head=1
    current_directory_stack[1]="/"
}

function cd_move_one_dir_up() {
    if (current_directory_stack_head > 1) {
        current_directory_stack_head--
    }
}

function cd_move_into_dir(target_dir) {
    current_directory_stack_head+=1
    current_directory_stack[current_directory_stack_head]=target_dir
}

function add_file_size_to_all_dirs_recursively_upstream(size) {
    for (i=1; i<=current_directory_stack_head; i++) {
        full_path_to_dir=pwd_limited(i)
        directory_size[full_path_to_dir]+=size
    }
}

function print_all_dirs_with_sizes() {
    printf "\n\ndirectory sizes:\n"
    for (dir in directory_size) {
        print "- ", dir, ": ", directory_size[dir]
    }
}

BEGIN { 
    cd_move_to_root()
}

/^\$ cd \.\./ {
#    print "cd_move_one_dir_up()", $0
    cd_move_one_dir_up()
#    print "pwd: ", pwd()
}
/^\$ cd \// {
#    print "cd_move_to_root()", $0
    cd_move_to_root()
#    print "pwd: ", pwd()
}
/^\$ cd [^\.\/]/ {
#    print "cd_move_into_dir($3)", $3, $0
    cd_move_into_dir($3)
#    print "pwd: ", pwd()
}

/^\$ ls/ {
#    do nothing
}

/^[^$]+[0-9]+ / {
#    output of an ls command without the dirs
#    print "size", $1, "file", $2
    add_file_size_to_all_dirs_recursively_upstream($1)
}

END {
    print_all_dirs_with_sizes()

    # Find all of the directories with a total size of at most 100000. What is the sum of the total sizes of those directories?
    result_1=0
    for (dir in directory_size) {
        if (directory_size[dir] <= 100000) {
            result_1+=directory_size[dir]
        }
    }    
    print "solution 1", result_1

    # Find the smallest directory that, if deleted, would free up enough space on the filesystem to run the update. What is the total size of that directory?
    total_space=70000000
    space_required=30000000
    total_free_space=total_space-directory_size["/"]
    space_that_we_need_to_free=space_required-total_free_space
    if (space_that_we_need_to_free < 0) {
        print "we have enough free space already, no need to delete anything"
    } else {
        print "space_required", space_required
        print "total_free_space", total_free_space
        print "space_that_we_need_to_free", space_that_we_need_to_free

        result_2="/"
        result_2_size=directory_size["/"]

        for (dir in directory_size) {
            dir_size = directory_size[dir]
            if (dir_size > space_that_we_need_to_free && dir_size < result_2_size) {
                result_2 = dir
                result_2_size = dir_size
            }
        }    

        print "solution 2, best option to delete", result_2, result_2_size
    }



}