#!/bin/bash
output='none'
if [ "$#" -ne 1 ]; then
    printf 'ERROR! You must provide one and only one argument!\n' >&2
    exit 1
fi
last_comit_message=$1
if [[ $last_comit_message == *"strudel"* ]] && [[ $last_comit_message == *"add"* ]] &&
   [[ $last_comit_message == *"logs"* ]] && [[ ! $last_comit_message == *"remove"* ]]; then
    output='add-logs' ; fi

if [[ $last_comit_message == *"strudel"* ]] && [[ $last_comit_message == *"remove"* ]] &&
   [[ $last_comit_message == *"logs"* ]] && [[ ! $last_comit_message == *"add"* ]]; then
    output='remove-logs'; fi
echo $output
