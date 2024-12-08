#!/bin/bash
output='none'
if [ "$#" -ne 1 ]; then
    printf 'ERROR! You must provide one and only one argument!\n' >&2
    exit 1
fi
last_commit_message=$1
last_commit_message=${last_commit_message^^}
if [[ $last_commit_message == *"STRUDEL"* ]] && [[ $last_commit_message == *"ADD"* ]] &&
   [[ $last_commit_message == *"LOGS"* ]] && [[ ! $last_commit_message == *"REMOVE"* ]]; then
    output='add-logs' ; fi

if [[ $last_commit_message == *"STRUDEL"* ]] && [[ $last_commit_message == *"REMOVE"* ]] &&
   [[ $last_commit_message == *"LOGS"* ]] && [[ ! $last_commit_message == *"ADD"* ]]; then
    output='remove-logs'; fi
echo $output
