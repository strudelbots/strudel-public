# strudel-public
Used to share public parts of Strudel 
## Overview 

## Pre-Requisites
1. Register to strudel. <a href="mailto:foo@bar.example.com?subject=Hello%20World&amp;body=put%20body%20">eMail Strudel Support</a>
3. Github account with: 
   1. Repository with python code on which you want to install Strudel 
   2. Permission to  to add repository secrets at the repository
   3. Permission to add Github actions  to the repository
   4. Permission to configure write permission to actions
    

## Onboarding  
### Onboarding strudel on-prem
1. Open your github project in your favorite IDE
2. Create a new directory (if it does not already exists): 
`.github/workflows`
2. Copy the git action (from the strudel-public repository) 
`run_strudel_for_logs.yml` to your repository in the `.github/workflows` folder.
1. Set up keys to access strudel
     1. Go to the repository `-->` settings `-->` secrets and variables  `-->` actions 
     3. Add a new secret with the name `STRUDEL_ACCESS_KEY_ID` and the value of the API key you received from Strudel
     4. Add a new secret with the name `STRUDEL_SECRET_KEY` and the value of the API URL you received from Strudel
2. Enable workflows to write to the repository

### Onboarding strudel cloud solution

## Using Strudel Alpha
## Providing feedback 
