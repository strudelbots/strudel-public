## How to create a release
1. Create a branch `<release>_<version>`
2. version X: 0.X.02
3. run a script to update the ref in al places in code 
4. commit the code 
4. create tag `v0.X.02`: `git tag  v0.X.02`
5. push all tags `git push --tags origin`

## gh commands that works
1. ```
   gh api  --method POST  \    
   -H "Accept: application/vnd.github+json"   \  
   -H "X-GitHub-Api-Version: 2022-11-28"  \   
   /repos/strudelbots/strudel-public/actions/workflows/120122122/dispatches  \
      -f "ref=main"  -f "inputs[user_command]=test-strudel"
```