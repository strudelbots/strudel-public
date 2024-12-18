#!/bin/bash
echo "Hello from Strudel CLI"
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
ARG="$1"

# Check if the argument is valid
if ! is_valid_arg "$ARG"; then
    echo "Error: Invalid argument '$ARG'."
    echo "Valid values are: ${VALID_ARGS[*]}"
    exit 1
fi

gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/strudelbots/strudel-public/actions/workflows/client_side_strudel_test.yml/dispatches \
   -f "ref=44-run-addremove-logs-with-gh-cli" -f "inputs[user_command]=teststrudel"
