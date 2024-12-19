

## Strudel: Leave the grind to the bots. Engineer the extraordinary.
Strudel is changing how we engineer software by merging human ingenuity with advanced automation. 
With Strudel, software engineers can shift their focus from repetitive, time-consuming tasks to what truly 
matters—innovation, problem-solving, and building exceptional solutions. 
Strudel’s intelligent bots seamlessly handle routine tasks. 
By automating up to 50% of the development process, Strudel will empower
teams to accelerate productivity and drive meaningful innovation. The result? Faster development cycles, higher-quality code, and engineers who can 
focus on engineering the extraordinary.

## About Strudel Pilot (version 0.20.02)
Strudel's pilot simplifies telemetry integration 
by automatically embedding logging and business metrics directly into your Python code.
With Strudel, logging code is automatically added to your pull requests, 
letting you focus solely on business logic without worrying about implementing logs.

1. New to Strudel? Onboard [now](#pre-requisites).
2. Already using Strudel? Upgrade to the latest version 0.20.0
3. Questions about using Strudel? Check out the [Using Strudel](#using-strudel) section.
4. See what's new in Strudel Pilot [below](#whats-new-in-strudel-pilot).

## Using Strudel 
### Automatic Logging Updates in Your Pull Request
Strudel streamlines logging updates in your pull requests or branch.

1. Strudel automatically adds/removes logging code to the files you change in your branch.
1. Strudel avoids duplicate logging code by checking for existing logs in the files you change.
1. **Trigger Strudel using a commit message**: Simply include `add-logs` in your commit message, 
and Strudel will automatically update the logging code. To remove all logs from your code,
use `remove-logs` in your commit message.
1. **Trigger Strudel using Strudel CLI** (for Mac and Linux): 
   1. Download Strudel CLI <a href=https://github.com/strudelbots/strudel-public/blob/47-release-020xx/strudel_code/strudel_cli.sh>Click to Download</a>: 
   2. Run the Strudel CLI to add logging code to your pull request. Run the CLI from your 
   branch, with the following commands 
   - To add logs `strudel_cli.sh add-logs`
   - To remove logs `strudel_cli.sh remove-logs`
   - To run Strudel test `strudel_cli.sh test-strudel`

### Configuring Strudel 
#### Setting the logger name
By default, Strudel will use the name `strudel` as the logger name. That is, Strudel produces
logs of the form `strudel.<log-level>(<log message>)`. 
If you want to change the logger name, you can do so by adding the following line to your code:
<pre>
uses: strudel-ai/strudel-public/.github/workflows/run_strudel_for_logs.yml       
   <b>with:
       logger_name: &#60;your logger name&gt; </b>
   secrets:
</pre>

## Pre-Requisites
1. **Python**: Strudel pilot is currently available for Python projects only (python versions 3.10+).
1. **Register for Strudel**: [strudelbots.com](https://www.strudelbots.com/pilot-program)
2. **Receive Strudel Secrets**: You will receive an email containing your Strudel secrets. 
Keep this email safe and do not share the secrets with anyone.
2. **GitHub Account**:
   1. A repository with Python code where you want to install Strudel. 
   2. Permission to add repository secrets. 
   3. Permission to add GitHub Actions to the repository.

   
## Onboarding  (On Prem Through Github Actions)
### Setup Keys to Access Strudel
1. Go to the `repository` &rarr; `Settings` &rarr; `Secrets` and `Variables`  &rarr; `Actions`. 
1. Add a new secret,  `STRUDEL_ACCESS_KEY_ID`,  with the access key value 
you received from Strudel support. 
1. Add a new secret, e `STRUDEL_SECRET_KEY`, with the secret key value you 
received from Strudel Support. 


### Create Strudel Test Action in your Github Repository (optional)
This step is optional and can be used to run a Strudel test to verify that your setup is correct.
1. Open your repository in GitHub/IDE. 
2. Create a new file in the `.github/workflows` directory with the name `strudel-test.yml`.
2. CCopy the following code into the file:
```
name: client side run strudel test
# version 0.20.02
on:
  workflow_dispatch:
    inputs:
      user_command:
        description: "inset 'test-strudel' to run this job"
        required: true
  push:
      branches:
        - '**'
        - (!main)
jobs:
  should_run_strudel:
    runs-on: ubuntu-22.04
    outputs:
      run_strudel: ${{ steps.user_command.outputs.RUN_STRUDEL }}
    steps:
      - name: check user command
        id: user_command
        shell: bash
        run: |
          echo "Working branch:" ${{ github.ref }}
          user_command=${{ inputs.user_command }} 
          user_command=${user_command^^}
          {
          if [[ $user_command == *"TEST-STRUDEL"* ]]; then
            echo "RUN_STRUDEL=$user_command" >> $GITHUB_OUTPUT
          else
            echo "RUN_STRUDEL=none" >> $GITHUB_OUTPUT
            echo "No strudel test requested, to run strudel test, please include 'TEST-STRUDEL' in your command"
          fi
          }

  run-strudel-test:
    needs: [ should_run_strudel ]
    if: ${{ needs.should_run_strudel.outputs.run_strudel!='none' }}
    uses: strudelbots/strudel-public/.github/workflows/run_strudel_test.yml@v0.20.02
    with:
      master_branch: main
    secrets:
        strudel_access_key: ${{ secrets.STRUDEL_ACCESS_KEY_ID }}
        strudel_secret_key: ${{ secrets.STRUDEL_SECRET_KEY }}

```
2. Commit and push the changes to the repository
3. Manually run the new work flow. 
4. Check the steps and the logs of the action to ensure that the test ran successfully.

### Create Strudel Add-Logs  Action in Your Github Repository
1. Create a new file in the `.github/workflows` directory with the name 
`run_strudel_for_logs.yml`
2. Copy the following code into the file:
```

name: Client side run strudel-for-logs
on:
  workflow_dispatch:
    inputs:
      user_command:
        description: 'The user command'
        required: true

  # ***** By default the workflow runs every push on all branches besides the main branch
  push:
    branches:
      - "**"
      - '!main'       # chang this to your master branch name if it is not 'main'
jobs:
  should_run_strudel:
    runs-on: ubuntu-22.04
    outputs:
      run_strudel: ${{ steps.user_command.outputs.RUN_STRUDEL }}
    steps:
      - uses: actions/checkout@v3
        with:
          ref: ${{ github.event.pull_request.head.sha }}
          fetch-depth: 0

      - name: check user command
        env:
          sha_last_commit: ${{ github.event.pull_request.head.sha }}
        id: user_command
        shell: bash
        run: |
          echo "Working branch:" ${{ github.ref }}
          user_command=${{ inputs.user_command }} 
          user_command=${user_command^^}
          last_commit=$(git log -1 --pretty=%B $sha_last_commit)
          last_commit=${last_commit^^}
          echo "last_commit: $last_commit"

          {
# *******  The following block is an example on how to use strudel cli
# *******  to trigger strudel based on the user command
# *******  Get the cli for linux ad mac:
          if [[ $user_command == "ADD-LOGS" || $user_command == "REMOVE-LOGS" ]]; then
            user_command=${user_command,,}
            echo "Run strudel with command: $user_command"
            echo "RUN_STRUDEL=$user_command" >> $GITHUB_OUTPUT

# *******  The following block ios an example on how to
# *******  use the last commit message to determine the user command
# *******  uncomment the block if you want to trigger strudel based on the last commit message
#          elif [[ $last_commit == *"ADD-LOGS"* ]]; then
#              echo "Run strudel add logs"
#              echo "RUN_STRUDEL=add-logs" >> $GITHUB_OUTPUT
#          elif [[ $last_commit == *"REMOVE-LOGS"* ]]; then
#              echo "Run strudel remove logs"
#              echo "RUN_STRUDEL=remove-logs" >> $GITHUB_OUTPUT
#          else
#              echo "no commit message to match"
#              echo "RUN_STRUDEL=none" >> $GITHUB_OUTPUT
#          fi
          }

  run-strudel-for-logs:
    needs: [ should_run_strudel ]
    if: ${{ needs.should_run_strudel.outputs.run_strudel!='none' }}
    uses: strudelbots/strudel-public/.github/workflows/run_strudel_for_logs.yml0.20.02
    with:
# Make sure to change the name of your master branch if it is not main
      master_branch: main
      user_command: ${{ needs.should_run_strudel.outputs.run_strudel }}
    secrets:
      strudel_access_key: ${{ secrets.STRUDEL_ACCESS_KEY_ID }}
      strudel_secret_key: ${{ secrets.STRUDEL_SECRET_KEY }}

permissions:
  actions: write
  contents: write


```
2. Commit and push the changes to the repository

## Steps to add logging code to your pull request (example)
With Strudel, logging code is automatically added to your pull requests, 
letting you focus solely on business logic without worrying about implementing logs.

1. Create a new branch, for example, `test-strudel-logging`. 
2. Change a few files in this branch (e.g., add/remove functionality, fix a bug, or just add a few lines). 
2. Commit your changes. **In the commit message write the 
following text: `strudel add logs`**.
3. Push your branch to the repository.
4. Go to action tab in Github, you will see a new action running. `run strudel-for-logs`
4. Strudel automatically adds the necessary logging code to the files you change in your branch.
You can see the new code if you open a pull request, or pull strudel changes back into your local branch. 
5. When you open pull request, reviewers will see both the logging code and your business logic during the review.



## Frequently Asked Questions

#### How can I verify that Strudel is working?  
Check the logs for the Strudel action in the **GitHub Actions** tab.

#### Does Strudel collect any IP or PII from my repository?  
No, Strudel does not collect any IP or PII from your repository. 
It gathers only encrypted metadata in the following format:
```json
{"f0b25bddf6b3213fd77fa89b02d8d3d5": [[3, 12]]}
```
This format is cryptographically secure and ensures that no one, including Strudel, can reverse-engineer your code.  
## What's New in Strudel Pilot?
1. **Nov-24-24: Version 0.13.02 released.** 
   - Bug fix: Strudel correctly change logging code once developer changes the underlying business logic.  


## In the next release
### Add trace-level logging code to your pull request 
In this mode, Strudel adds logging code that enables detailed tracing. 
These logs provide insights into the full execution flow, including method calls 
and control flow, helping you quickly understand the behavior at every level.
This is especially useful during development when you need to verify the flow of execution.

### More options to trigger Strudel 
In addition to the commit message, you will be able to trigger Strudel using a
GitHub label or a comment in the pull request. This will give you more flexibility
in controlling when Strudel adds logging code to your pull request.