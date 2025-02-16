#!/bin/bash
clear
source  ../strudel_code/functions_for_analyzing_git_db.sh

echo "test one"
result=$(args_to_space_separated_string ".github/actions/get_all_files_in_repository/action.yml")
echo "result of test 1 is $result"
if [[ $result != ".github/actions/get_all_files_in_repository/action.yml" ]]; then
  echo "ERROR 1"
  for (( i=0; i<${#result}; i++ )); do
    echo "${result:$i:1}"
  done
  exit 1
fi
echo "test two"
result=$(args_to_space_separated_string "aaa bbb")
echo "result of test 2 is $result"
if [[ $result != "aaa bbb" ]]; then
  echo "ERROR 2"
  exit 3
fi
echo "test three"
result=$(args_to_space_separated_string "ccc       ddd")
echo "result of test 3 is $result"
if [[ $result != "ccc ddd" ]]; then
  echo "ERROR 3"
  exit 3
fi
echo "test five"
result=$(args_to_space_separated_string "ccc\n   \n    ddd")
echo "result of test 5 is $result"
if [[ $result != "ccc ddd" ]]; then
  echo "ERROR 5"
  exit 5
fi

echo "test six"
result=$(args_to_space_separated_string "ccc\n   \n    ddd   eee\n")
echo "result of test 6 is $result"
if [[ $result != "ccc ddd eee" ]]; then
  echo "ERROR 6"
  for (( i=0; i<${#result}; i++ )); do
    echo "${result:$i:1}"
  done
  exit 6
fi
echo "test seven"
result=$(args_to_space_separated_string "ccc,\n   \n  ,   ddd,   eee\n")
echo "result of test 7 is $result"
if [[ $result != "ccc ddd eee" ]]; then
  echo "ERROR 7"
  for (( i=0; i<${#result}; i++ )); do
    echo "${result:$i:1}"
  done
  exit 7
fi
echo "test eight"
result=$(args_to_space_separated_string "ccc ccc ccc")
echo "result of test 8 is $result"
if [[ $result != "ccc" ]]; then
  echo "ERROR 8"
  exit 8
fi

echo "test nine"
result=$(args_to_space_separated_string "ccc ddd ccc eee ccc eee")
echo "result of test 9 is $result"
if [[ $result != "ccc ddd eee" ]]; then
  echo "ERROR 9"
  exit 9
fi
