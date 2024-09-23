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
1. Open your Github project in your favorite IDE
2. Create a new directory (if it does not already exist): 
`.github/workflows`
#### Create strudel test action in your repository (optional):
2. Set up keys to access Strudel:
     1. Go to the repository &rarr; Settings &rarr; Secrets and variables  &rarr; Actions 
     3. Add a new secret with the name `STRUDEL_ACCESS_KEY_ID` and the value of the API key you received from Strudel
     4. Add a new secret with the name `STRUDEL_SECRET_KEY` and the value of the API URL you received from Strudel

2. Create a new file in the `.github/workflows` directory with the name `strudel-test.yml`
This step is optional and can be used to run strudel test 
that verifies your set-up is correct 
2. Copy the following code into the file:
   ```yaml
   name: run-strudel-test
   on:
     workflow_dispatch:
   jobs:
     run-strudel-test:
       uses: strudel-ai/strudel-public/.github/workflows/run_strudel_test.yml@v0.1.0
       secrets:
           strudel_access_key: ${{ secrets.STRUDEL_ACCESS_KEY_ID }}
           strudel_secret_key: ${{ secrets.STRUDEL_SECRET_KEY }}
   ```
2. Enable workflows to write to the repository. 
2. Commit the changes to the repository
3. Manually run the new work flow. 


## Using Strudel Alpha
## Providing feedback 
