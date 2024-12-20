#!/bin/bash
echo "Hello from Strudel CLI"
echo "Strudel CLI requires github CLI to be installed !"
echo "The CLI assumes that you have two actions defined with the names
(as described in onboarding document):"
echo "    1. strudel-test.yml"
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
if [[ $owner == "set-me" ]]; then
    echo "Please set the owner variable !"
    exit 1
fi
if [[ $repo == "set-me" ]]; then
    echo "Please set the repo variable !"
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
    /repos/$owner/$repo/actions/workflows/strudel-test.yml/dispatches \
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
