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
test-client-job-come-here
```
2. Commit and push the changes to the repository
3. Manually run the new work flow. 

### Create Strudel add-logs Github Action in Your Repository
1. Create a new file in the `.github/workflows` directory with the name `run_strudel_for_logs.yml`
2. Copy the following code into the file:
```yaml
run-client-job-come-here
```
2. Commit and push the changes to the repository

## Using Strudel Alpha
### Using Strudel with Pull Requests
In this mode, Strudel will automatically add logging code to your pull requests, 
allowing you to focus entirely on your business logic without worrying about log implementation.

1. Start by creating a new branch.
2. Work on your code as usual.
3. When you're ready for a code review, create a pull request. 
   1. [You can create a pull request using the web api.](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request?tool=webui)
   2. [You can create a pull request using the Github cli.](https://external.ink?to=/docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request?tool=cli#creating-the-pull-request)
3. Commit to your branch a commit message with the words `strudel`,`add`, `logs` (in any order).  
4. Strudel will automatically insert the necessary logs into your pull request.
4. The reviewers will review your code with the logs. 
5. Once everyone is satisfied, merge the pull request.
#### Add trace level logging-code to your pull request 
#### Remove all logging-code to your pull request
To remove all Strudel logging-code from a pull request just add the forlowing
words to your commit message: `strudel`, `remove`, `logs` (in any order).
## Configuring Strudel 
### Setting the logger name
By default, Strudel will use the name `strudel` as the logger name. That is, Strudel produces
logs of the form `strudel.<log-level>(<log message>)`. 
If you want to change the logger name, you can do so by adding the following line to your code:
```
    uses: strudel-ai/strudel-public/.github/workflows/run_strudel_for_logs.yml        
    *with:*
      *logger_name: <your-logger-name>*
    secrets:
```
## Frequently Asked Questions
## Limitations 

## Providing feedback 
