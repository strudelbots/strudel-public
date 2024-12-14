#!/bin/bash
# Source the script containing the functions
source ./commit_functions.sh
# Ensure the script is sourced successfully
if [ $? -ne 0 ]; then
  echo "Error: Failed to source the script containing the functions."
  exit 1
fi

# Function to display usage
usage() {
  echo "Usage: $0 <branch-name> < master branch-name>"
  exit 1
}

# Check if branch name is provided
if [ -z "$1" ]; then
  usage
fi

# Check if branch name is provided
if [ -z "$2" ]; then
  usage
fi

BRANCH_NAME=$1
MASTER_BRANCH_NAME=$2

common_ancestor=$(last_common_commit "$MASTER_BRANCH_NAME" "$BRANCH_NAME")
echo "** The last common commit between '$MASTER_BRANCH_NAME' and '$BRANCH_NAME': $common_ancestor"
commits_after_common_commits=$(commits_after_common_commit $BRANCH_NAME main)
changed_files=()
for hash in $commits_after_common_commits; do
    (is_commit_only_on_branch "$hash" "$BRANCH_NAME")
    if [ $? -eq 0 ]; then
        commit_files=$(files_changed_in_commit "$hash")
        echo
        echo "Commit $hash has the following files:"
        printf "%s\n" "${commit_files[@]}"
        changed_files+=( $commit_files )
    fi
done
unique_files=$(args_to_space_separated_string "${changed_files[@]}")

echo "**** remove files that were deleted in branch $BRANCH_NAME ****"
final_files=""
for file in ${unique_files}; do
    echo "Checking if file $file exists in branch $BRANCH_NAME"
    (file_exists_in_branch "$file" "$BRANCH_NAME")
    if [ $? -eq 0 ]; then
        echo "  +++    File $file exists in branch $BRANCH_NAME  +++"
        final_files+="$file "
    else
        echo "  -- File $file was deleted in branch $BRANCH_NAME ---"
    fi
done
echo "Files that need to be merged from branch $BRANCH_NAME:"
echo "$final_files"
echo
