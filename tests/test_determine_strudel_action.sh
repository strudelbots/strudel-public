#!/bin/bash
output=$(../strudel_code/determine_strudel_action.sh "strUdel ADD lOgs")
if [ "$output" != "add-logs" ]; then
  echo "Test failed add-logs!"
  exit 1
fi
output=$(../strudel_code/determine_strudel_action.sh "reMove stRudel add LOGS")
if [ "$output" != "none" ]; then
  echo "Test failed remove and add together"
  exit 1
fi
output=$(../strudel_code/determine_strudel_action.sh "Remove LogS strudeL")
if [ "$output" != "remove-logs" ]; then
  echo "Test failed remove-logs-0"
  exit 1
fi
output=$(../strudel_code/determine_strudel_action.sh "strudel please trace logs REMOVE")
if [ "$output" != "remove-logs" ]; then
  echo "Test failed remove-logs-1"
  exit 1
fi
output=$(../strudel_code/determine_strudel_action.sh "strUdel please remove Trace logs")
if [ "$output" != "remove-logs" ]; then
  echo "Test failed remove-logs-2"
  exit 1
fi

echo "Test passed!"
