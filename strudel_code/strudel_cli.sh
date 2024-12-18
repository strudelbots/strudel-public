#!/bin/bash
echo "Hello from Strudel CLI"

gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/strudelbots/strudel-public/actions/workflows/client_side_strudel_test.yml/dispatches \
   -f "ref=44-run-addremove-logs-with-gh-cli" -f "inputs[user_command]=strudel-test"
