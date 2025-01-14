#!/bin/bash
echo "Hello from Strudel CLI"
echo "Strudel CLI requires github CLI to be installed !"
echo "The CLI assumes that you have two actions defined with the names
(as described in onboarding document):"
echo "    1. run-strudel-test.yml"
echo "    2. run_strudel_for_logs.yml"
echo "Please make sure that you have these actions defined in your repository"


# Valid values for the argument
VALID_ARGS=("add-logs" "remove-logs" "test-strudel")

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

owner=set-me
repo=set-me
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

  gh api \
    --method POST \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    /repos/$owner/$repo/actions/workflows/run-strudel-test.yml/dispatches \
    -f "ref=$branch"  -f "inputs[user_command]=$command"
fi
if [[ "$command" == "add-logs" || "$command" == "remove-logs" ]]; then
    echo "Running add/remove logs, branch: $branch"
  gh api \
    --method POST \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    /repos/$owner/$repo/actions/workflows/run_strudel_for_logs.yml/dispatches \
    -f "ref=$branch"  -f "inputs[user_command]=$command"
fi
