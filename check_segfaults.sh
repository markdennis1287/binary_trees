#!/bin/bash

# List of programs to check
programs=("0-binary_tree_node.c" "1-binary_tree_insert_left.c" "2-binary_tree_insert_right.c" "3-binary_tree_delete.c" "4-binary_tree_is_leaf.c" "5-binary_tree_is_root.c" "6-binary_tree_preorder.c" "7-binary_tree_inorder.c" "8-binary_postorder.c" "9-binary_tree_height.c" "10-binary_tree_depth.c" "11-binary_tree_size.c" "12-binary_tree_leaves.c" "13-binary_tree_nodes.c" "14-binary_tree_balance.c" "15-binary_tree_is_full.c" "16-binary_tree_is_perfect.c" "17-binary_tree_sibling.c" "18-binary_tree_uncle.c" "binary_tree_print.c")

# Directory to store GDB outputs
output_dir="gdb_outputs"
mkdir -p "$output_dir"

# Function to run GDB on a program
run_gdb() {
    local program=$1
    local output_file="$output_dir/${program}_gdb_output.txt"

    echo "Running GDB on $program..."

    # GDB script to run the program and capture backtrace on segfault
    gdb_script="run\nbacktrace\nquit\n"

    # Run GDB and capture output
    echo -e "$gdb_script" | gdb ./"$program" > "$output_file" 2>&1

    # Check if a segmentation fault occurred
    if grep -q "Program received signal SIGSEGV" "$output_file"; then
        echo "Segmentation fault detected in $program. See $output_file for details."
    else
        echo "No segmentation fault detected in $program."
        # Optionally, remove the output file if no segfault was detected
        rm "$output_file"
    fi
}

# Run GDB on each program in the list
for program in "${programs[@]}"; do
    if [[ -f "$program" ]]; then
        run_gdb "$program"
    else
        echo "Program $program not found."
    fi
done

