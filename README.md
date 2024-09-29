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


## Onboarding  (On Prem Through Github Actions)
### Setup Keys to Access Strudel
1. Go to the repository &rarr; Settings &rarr; Secrets and variables  &rarr; Actions 
1. Add a new secret with the name `STRUDEL_ACCESS_KEY_ID` and the value 
   of the access key you received from Strudel support. 
1. Add a new secret with the name `STRUDEL_SECRET_KEY` and the value of the 
   secret key you received from Strudel Support. 

2. Open your Github project in your favorite IDE.
2. Create a new directory (if it does not already exist):`.github/workflows`

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

### Create Strudel add-logs Github Action in Your Repository
1. Create a new file in the `.github/workflows` directory with the name `run_strudel_for_logs.yml`
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
### Using Strudel with Pull Requests
In this mode Strudel will add logs to your pull requests. 
Work on your code without considering logging, just focus on the business 
logic you need to implement. 
1. start by creating a new branch. 
2. work on your code
3. when you feel ready for code review create a pull request.
4. Strudel will add logs to your pull request.
5. Review the logs and make sure they are correct.
6. Merge the pull request.
## Providing feedback 
