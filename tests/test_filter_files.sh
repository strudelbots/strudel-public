#!/bin/bash
source  ../strudel_code/functions_for_analyzing_git_db.sh

echo "test one"
result=$(filter_files ".github/actions/get_all_files_in_repository/action.yml" "actions")
echo "result of test 1 is $result"
if [[ $result != "" ]]; then
  echo "ERROR 1"
  exit 1
fi

echo "test two"
result=$(filter_files ".github/actions/get_all_files_in_repository/action.yml" "action")
echo "result of test 2 is $result"
if [[ $result != ".github/actions/get_all_files_in_repository/action.yml" ]]; then
  echo "ERROR 2"
  exit 2
fi

echo "test three"
result=$(filter_files ".github/actions/get_all_files_in_repository/action.yml .github/workflows/get_all_files_in_repository/action.yml" "boy")
echo "result of test 3 is $result"
if [[ $result != ".github/actions/get_all_files_in_repository/action.yml .github/workflows/get_all_files_in_repository/action.yml" ]]; then
  echo "ERROR 3"
  exit 4
fi

echo "test four"
result=$(filter_files ".github/actions/get_all_files_in_repository/action.yml .github/workflows/get_all_files_in_repository/action.yml" "workflow")
echo "result of test 4 is $result"
if [[ $result != ".github/actions/get_all_files_in_repository/action.yml .github/workflows/get_all_files_in_repository/action.yml" ]]; then
  echo "ERROR 4"
  exit 4
fi

echo "test five"
result=$(filter_files ".github/actions/get_all_files_in_repository/action.yml .github/workflows/get_all_files_in_repository/action.yml" "workflows")
echo "result of test 5 is $result"
if [[ $result != ".github/actions/get_all_files_in_repository/action.yml" ]]; then
  echo "ERROR 5"
  exit 5
fi

echo "test six"
result=$(filter_files ".github/actions/get_all_files_in_repository/action.yml .github/actions/get_all_files_in_repository/action.yml" "workflows")
echo "result of test 6 is $result"
if [[ $result != ".github/actions/get_all_files_in_repository/action.yml" ]]; then
  echo "ERROR 6"
  exit 6
fi

echo "test seven"
result=$(filter_files ".github/actions/get_all_files_in_repository/action.yml .github/actions/get_all_files_in_repository/action.yml" "actions")
echo "result of test 7 is $result"
if [[ $result != "" ]]; then
  echo "ERROR 7"
  exit 7
fi
echo "test eight"
result=$(filter_files ".github/actions/get_all_files_in_repository/action.yml .github/workflows/get_all_files_in_repository/action.yml" "workflows+actions")
echo "result of test 8 is $result"
if [[ $result != "" ]]; then
  echo "ERROR 8"
  exit 8
fi
echo "test nine"
result=$(filter_files ".github/actions/get_all_files_in_repository/action.yml .github/workflows/get_all_files_in_repository/action.yml" "boy+girl")
echo "result of test 9 is $result"
if [[ $result != ".github/actions/get_all_files_in_repository/action.yml .github/workflows/get_all_files_in_repository/action.yml" ]]; then
  echo "ERROR 9"
  exit 9
fi
echo "test ten"
result=$(filter_files ".github/actions/get_all_files_in_repository/action.yml init.py" "boy+girl")
echo "result of test 10 is $result"
if [[ $result != ".github/actions/get_all_files_in_repository/action.yml" ]]; then
  echo "ERROR 10"
  exit 10
fi
