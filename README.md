# strudel-public
Used to share public parts of Strudel 
## Overview 

## Pre-Requisites
1. Register to strudel. <p><a href="mailto:foo@bar.example.com">foo@bar.example.com</a></p> 
2. [mail](mailto:foo@bar.example.com?subject=Hello%20World&body=Hello%20World&nbsp;)
3. Github account with: 
   1. Repository on which you want to install 
   2. Ability to add secrets at the repository
   3. Ability to add actions to the repository
   4. Ability to configure write permission to actions
   Manual onboarding 
   Automatic onboarding 
   Usage 

## Onboarding  
### Using strudel on-prem
1. Open your github project in your favorite IDE
2. Create a new directory (if it does not already exists): 
`.github/workflows`
2. Copy the git action (from the strudel-public repository) 
`run_strudel_for_logs.yml` to your repository in the `.github/workflows` folder.
1. Set up keys to access strudel 
2. enable workflows to write to the repository

### Using strudel cloud solution 
