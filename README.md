# strudel-public
Used to share public parts of Strudel 
## Overview 

## Pre-Requisites
1. Register to strudel. <a href="mailto:support@strudel-ai.com?subject=Hello%20World&amp;body=put%20body%20">eMail Strudel Support</a>
3. You will get an email with Strudel secrets, keep this email and do not share your secrets with anyone.
4. Github account with: 
   1. Repository with python code on which you want to install Strudel 
   2. Permission to  to add repository secrets at the repository
   3. Permission to add Github actions  to the repository


## Onboarding  (On Prem Through Github Actions
### Set up keys to access Strudel
1. Go to the repository &rarr; Settings &rarr; Secrets and variables  &rarr; Actions 
1. Add a new secret with the name `STRUDEL_ACCESS_KEY_ID` and the value 
   of the access key you received from Strudel support. 
1. Add a new secret with the name `STRUDEL_SECRET_KEY` and the value of the 
   secret key you received from Strudel Support. 

2. Open your Github project in your favorite IDE
2. Create a new directory (if it does not already exist):`.github/workflows`
2. Set up keys to access Strudel:
     1. Go to the repository &rarr; Settings &rarr; Secrets and variables  &rarr; Actions 
     3. Add a new secret with the name `STRUDEL_ACCESS_KEY_ID` and the value 
        of the access key you received from Strudel support. 
     4. Add a new secret with the name `STRUDEL_SECRET_KEY` and the value of the 
        secret key you received from Strudel Support. 

### Create Strudel-Test Action in your Github Repository (optional)

1. Create a new file in the `.github/workflows` directory with the name `strudel-test.yml`
This step is optional and can be used to run strudel test 
that verifies your set-up is correct 
2. Copy the following code into the file:
   ```yaml
   name: strudel-test
   on:
     workflow_dispatch:
   jobs:
     run-strudel-test:
       uses: strudel-ai/strudel-public/.github/workflows/run_strudel_test.yml@v0.2.0
       secrets:
           strudel_access_key: ${{ secrets.STRUDEL_ACCESS_KEY_ID }}
           strudel_secret_key: ${{ secrets.STRUDEL_SECRET_KEY }}
   ```
2. Commit and push the changes to the repository
3. Manually run the new work flow. 

### Create strudel add-logs github action in your repository:
1. Set up keys to access Strudel (if not done already):
2. Create a new file in the `.github/workflows` directory with the name `run_strudel_for_logs.yml'
2. Copy the following code into the file:
```yaml
    name: strudel-for-logs
    on: 
      pull_request:
# If you want to run the workflow only for other 
# branches than main change the name of the branch 
        branches:
          - main

    jobs:
      run-strudel-for-logs:
        uses: strudel-ai/strudel-public/.github/workflows/run_strudel_for_logs.yml@v0.4.0
        secrets:
            strudel_access_key: ${{ secrets.STRUDEL_ACCESS_KEY_ID }}
            strudel_secret_key: ${{ secrets.STRUDEL_SECRET_KEY }}
      permissions:
        actions: write
        contents: write

```
2. Commit and push the changes to the repository 


## Using Strudel Alpha
## Providing feedback 
