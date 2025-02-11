#!/bin/bash
get_file_name() {
    if [ "$#" -ne 1 ]; then
        echo "Usage: get_file_name <full_path_to_file>"
        return 1
    fi

    local full_path="$1"
    #echo "Full path: $full_path"
    # Use basename to extract the file name
    local file_name=$(basename "$full_path")

    # Return the file name
    echo "$file_name"
}


# Function to get all commits up to a given commit hash in a branch
get_commits_up_to() {
  local commit_hash=$1
  local branch_name=$2

  # Check if commit hash and branch name are provided
  if [ -z "$commit_hash" ] || [ -z "$branch_name" ]; then
    echo "Error: Both commit hash and branch name must be provided."
    return 1
  fi

  # Verify if the branch exists
  if ! git show-ref --verify --quiet refs/heads/$branch_name && ! git show-ref --verify --quiet refs/remotes/origin/$branch_name; then
    echo "Error: Branch '$branch_name' does not exist."
    return 1
  fi

  # Check if the commit exists
  if ! git cat-file -e "$commit_hash^{commit}" 2>/dev/null; then
    echo "Error: Commit '$commit_hash' does not exist."
    return 1
  fi

  # Get the list of commits up to the given commit (inclusive)
  local commits=$(git rev-list "$commit_hash" --first-parent "$branch_name" 2>/dev/null)

  if [ -z "$commits" ]; then
    echo "Error: Unable to retrieve commits for branch '$branch_name' up to commit '$commit_hash'."
    return 1
  fi

  echo "$commits"
}

# Function to print commits with their dates
print_commits_with_dates() {
  local commits=$1

  # Check if commits list is provided
  if [ -z "$commits" ]; then
    echo "Error: No commits provided to print_commits_with_dates function."
    return 1
  fi

  # Iterate over each commit and print its date
  while IFS= read -r commit; do
    if [ -n "$commit" ]; then
      local commit_date=$(git show -s --format=%ci "$commit" 2>/dev/null)
      if [ -n "$commit_date" ]; then
        echo "$commit - $commit_date"
      else
        echo "$commit - Error: Unable to retrieve date."
      fi
    fi
  done <<< "$commits"
}
# Function to check if a commit exists only on a specific branch
is_commit_only_on_branch() {
  local commit_hash=$1
  local branch_name=$2

  # Check if commit hash and branch name are provided
  if [ -z "$commit_hash" ] || [ -z "$branch_name" ]; then
    echo "Error: Both commit hash and branch name must be provided."
    return 1
  fi

  # Verify if the branch exists
  if ! git show-ref --verify --quiet refs/heads/$branch_name && ! git show-ref --verify --quiet refs/remotes/origin/$branch_name; then
    echo "Error: Branch '$branch_name' does not exist."
    return 1
  fi

  # Check if the commit exists
  if ! git cat-file -e "$commit_hash^{commit}" 2>/dev/null; then
    echo "Error: Commit '$commit_hash' does not exist."
    return 1
  fi

  # Check if the commit exists only on the given branch
  local branches_with_commit=$(git branch --contains "$commit_hash" | sed 's/^..//')
  local count=0

  while IFS= read -r branch; do
    if [ "$branch" == "$branch_name" ]; then
      count=$((count + 1))
    else
      #echo "False"
      return 1
    fi
  done <<< "$branches_with_commit"

  if [ $count -eq 1 ]; then
    #echo "True"
    return 0
  fi

  echo "False"
  return 1
}


# Function to list files changed in a given commit
files_changed_in_commit() {
    # Check if a commit hash is provided
    if [ -z "$1" ]; then
        echo "Usage: files_changed_in_commit <commit-hash>"
        return 1
    fi

    local commit_hash="$1"

    # Use git show to list the files changed in the commit
    git show --name-only --pretty=format: "$commit_hash"
}

# Function to find the last common commit between two branches
last_common_commit() {
    if [ "$#" -ne 2 ]; then
        echo "Usage: last_common_commit <branch1> <branch2>"
        return 1
    fi

    local branch1="$1"
    local branch2="$2"
    echo "Branch1: $branch1" >> /tmp/commit_functions.log
    echo "Branch2: $branch2" >> /tmp/commit_functions.log
    git merge-base $branch1 $branch2
}
filter_files() {
    #echo "Filtering files"
    if [ "$#" -ne 2 ]; then
        echo "Usage: commits_after_common_commit <branch1> <branch2>"
        return 1
    fi

    local files=($1)
    local exclude_directories=($2)
    local result=''
    # Get the last common commit between the two branches
    for file in "${files[@]}"; do
      for dir in "${exclude_directories[@]}"; do
        if [[ "$file" == *"$dir/"* ]]; then
            printf "Filtering file: $file"
        else
          result="$result $file"
        fi
      done
    done
    echo $result
}

commits_after_common_commit() {
    if [ "$#" -ne 2 ]; then
        echo "Usage: commits_after_common_commit <branch1> <branch2>"
        return 1
    fi

    local branch1="$1"
    local branch2="$2"

    # Get the last common commit between the two branches
    local common_commit
    common_commit=$(last_common_commit "$branch1" "$branch2")

    if [ -z "$common_commit" ]; then
        echo "Error: Could not find a common commit."
        return 1
    fi

    # List commits on branch1 after the common commit
     git log --pretty=format:"%H" "$common_commit..$branch1"
}
args_to_space_separated_string() {
    local num_args="$#"
    # Echo the number of arguments
    #echo "Number of arguments: $num_args"
    # Join all arguments with a space separator
    local unique_args=$(echo "$*" | tr ' ' '\n' | sort -u | tr '\n' ' ' | sed 's/ *$//')

    local num_unique_args=$(echo "$unique_args" | tr ' ' '\n' | wc -l)

    # Print the number of unique arguments
    #echo "Number of unique arguments: $num_unique_args"
    # Return the unique space-separated string of arguments
    echo "$unique_args"
}

# Function to check if a file exists in a specific branch
file_exists_in_branch() {
    if [ "$#" -ne 2 ]; then
        echo "Usage: file_exists_in_branch <file_name> <branch_name>"
        return 1
    fi

    local full_file_name="$1"
    local branch_name="$2"
    file_name=$(get_file_name "$full_file_name")
    echo "File name: $file_name"
    # Check if the file exists in the branch or if it was deleted
    # The command lists all files in the branch and also checks for files that are marked as deleted in git
    sleep 3
    echo "after sleep"
    git log --name-status $branch_name -- $file_name
    echo "after log"
}


