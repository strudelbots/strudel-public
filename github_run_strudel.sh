#!/bin/bash
if [ $# -ne 1 ]
  then
    echo "No argument supplied to determine action script"
    exit 1
fi
last_commit_message=$1
if [[ $last_commit_message == *"strudel"* ]] && [[ $last_commit_message == *"add"* ]]; then
  echo "Skipping CI"
  exit 0
fi