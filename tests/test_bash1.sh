#!/bin/bash
current_branch="v0.10.13"
{
    if [[ $current_branch == v0* ]] || [[ $current_branch == refs\/tag* ]]; then 
      echo "setting current branch  to: $current_branch"
      origin="" 
    elif [[ $repository = "strudelbots/strudel-public" ]]; then
      origin="origin/"
      master_branch="main"
      echo "repository: $repository, origin: $origin, master_branch: $master_branch"
    else
      echo "repository is not strudelbots/strudel-public: $repository"
      exit 23
    fi
}
