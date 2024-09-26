#!/bin/bash
output=$(../determine_strudel_action.sh "strudel add logs")
if [ "$output" != "add-logs" ]; then
  echo "Test failed add-logs!"
  exit 1
fi
output=$(../determine_strudel_action.sh "remove strudel add logs")
if [ "$output" != "none" ]; then
  echo "Test failed remove and add together"
  exit 1
fi
output=$(../determine_strudel_action.sh "remove logs strudel")
if [ "$output" != "remove-logs" ]; then
  echo "Test failed remove-logs"
  exit 1
fi
output=$(../determine_strudel_action.sh "strudel please remove trace logs")
if [ "$output" != "remove-logs" ]; then
  echo "Test failed remove-logs"
  exit 1
fi

echo "Test passed!"
