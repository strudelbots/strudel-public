#!/bin/bash
echo "Hello from Strudel CLI"
echo "Strudel CLI requires github CLI to be installed !"

get_workflow_id_by_path() {
  local owner="$1"
  local repo="$2"
  local workflow_path="$3"

  gh api "repos/$owner/$repo/actions/workflows" | jq -r ".workflows[] | select(.path==\"$workflow_path\") | .id"
}
trigger_workflow() {
  local owner=$1         # First argument: repository owner
  local repo=$2          # Second argument: repository name
  local workflow_id=$3   # Third argument: workflow ID
  local branch=$4        # Fourth argument: branch name
  local command=$5       # Fifth argument: user command

  gh api \
    --method POST \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    /repos/$owner/$repo/actions/workflows/$workflow_id/dispatches \
    -f "ref=$branch" \
    -f "inputs[user_command]=$command"
}

# Valid values for the argument
VALID_ARGS=("add-logs" "remove-logs" "test-strudel" "add-repo-logs" "remove-repo-logs")

# Function to check if an argument is valid
is_valid_arg() {
    local arg="$1"
    for valid_arg in "${VALID_ARGS[@]}"; do
        if [[ "$arg" == "$valid_arg" ]]; then
            return 0
        fi
    done
    return 1
}

owner=strudelbots
repo=playground-odoo
RED='\033[0;31m'
NC='\033[0m'
if [[ $owner == "set-me" ]]; then
    printf "\n"
    printf "please edit this cli script and set the repository 'owner' variable !\n"
    printf "The owner is the name appearing after 'github.com' in your repository url.\n"
    printf "For example, ${RED}strudelbot${NC} is the owner in https://github.com/${RED}strudelbots${NC}/strudel-public/\n"
    exit 1
fi
if [[ $repo == "set-me" ]]; then
    printf "\n"
    printf "please edit this cli script and set the 'repo' variable !\n"
    printf "The repo is the name appearing after the repository owner in  your github-url.\n".
    printf "For example, ${RED}strudel-public${NC} is the repo in https://github.com/strudelbots/${RED}strudel-public${NC}/\n"
    exit 1
fi

test_workflow_id=$(get_workflow_id_by_path "$owner" "$repo" ".github/workflows/run-strudel-test.yml")
if [ -z "$test_workflow_id" ]; then
    printf "Error: Workflow ID not found for the specified path for ${RED}run-strudel-test.yml${NC}.\n"
    echo "The CLI assumes that you have two actions defined with the names
    (as described in onboarding document):"
    echo "    1. run-strudel-test.yml"
    echo "    2. run-strudel-for-logs.yml"
    echo "Please make sure that you have these actions defined in your repository"
    exit 1
fi
run_strudel_worflow_id=$(get_workflow_id_by_path "$owner" "$repo" ".github/workflows/run-strudel-for-logs.yml")
if [ -z "$run_strudel_worflow_id" ]; then
    printf "Error: Workflow ID not found for the specified path for ${RED}run-strudel-for-logs.yml${NC}.\n"
    echo "The CLI assumes that you have two actions defined with the names
    (as described in onboarding document):"
    echo "    1. run-strudel-test.yml"
    echo "    2. run-strudel-for-logs.yml"
    echo "Please make sure that you have these actions defined in your repository"
    exit 1
fi

# Check if the script receives exactly one argument
if [[ "$#" -ne 1 ]]; then
    echo "Error: This script requires exactly one argument."
    echo "Valid values are: ${VALID_ARGS[*]}"
    exit 1
fi
if [[ "$1" == "--help" ]]; then
    echo "Usage: $0 [ARGUMENT]"
    echo "Valid arguments:"
    for valid_arg in "${VALID_ARGS[@]}"; do
        echo "  - $valid_arg"
    done
    exit 0
fi
command="$1"

# Check if the argument is valid
if ! is_valid_arg "$command"; then
    echo "Error: Invalid argument '$ARG'."
    echo "Valid values are: ${VALID_ARGS[*]}"
    exit 1
fi

branch=$(git rev-parse --abbrev-ref HEAD)
if [[ "$command" == "test-strudel" ]]; then
    echo "Running client-side tests"
    trigger_workflow $owner $repo $test_workflow_id $branch $command
fi
if [[ "$command" == "add-logs" || "$command" == "remove-logs" || "$command" == "add-repo-logs" || "$command" == "remove-repo-logs" ]]; then
    echo "Running add/remove logs, branch: $branch, command: $command"
    trigger_workflow $owner $repo run_strudel_worflow_id $branch $command
fi
