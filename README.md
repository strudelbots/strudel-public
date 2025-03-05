

## Strudel: Leave the grind to the bots. Engineer the extraordinary.
Strudel is changing how we engineer software by merging human ingenuity with advanced automation. 
With Strudel, software engineers can shift their focus from repetitive, time-consuming tasks to what truly 
matters—innovation, problem-solving, and building exceptional solutions. 
Strudel’s intelligent bots seamlessly handle routine tasks. 
By automating up to 50% of the development process, Strudel will empower
teams to accelerate productivity and drive meaningful innovation. The result? Faster development cycles, higher-quality code, and engineers who can 
focus on engineering the extraordinary.

## About Strudel Pilot
Strudel's pilot simplifies telemetry integration 
by automatically embedding logging and business metrics directly into your Python code.
With Strudel, logging code is automatically added to your pull requests, 
letting you focus solely on business logic without worrying about implementing logs.

1. New to Strudel? Onboard [now](#pre-requisites).
2. Already using Strudel? See whats new in [version 28.0](#Exclude-Directories-from-Strudel-Analysis) and upgrade [version 28.0](#Create-Main-Strudel-Action-in-Your-Github-Repository).
4. Questions about using Strudel? Check out the [Using Strudel](#using-strudel) section.
5. See what's new in Strudel Pilot [below](#whats-new-in-strudel-pilot).

## Using Strudel
Strudel streamlines logging updates in your pull requests or branch.   

1. Strudel automatically adds/removes logging code to the files you change in your branch.
1. Strudel avoids duplicate logging code by checking for existing logs in the files you change.

### Add logging-code to your branch automatically (default Strudel settings)
With Strudel, logging-code is automatically added to your pull requests, 
letting you focus solely on business logic without worrying about implementing logs.


1. Create a new branch, for example, `test-strudel-logging`. 
2. Change a few files in this branch (e.g., add/remove functionality, fix a bug, or just add a few lines). 
2. Commit your changes. 
3. Push your changes 
4. By default Strudel will run on every push (you can change those [here](#Adding or Removing Logging Code in Your Branch via Commit Messages).)
4. Go to Actions tab in Github, you will see a new action running: `run strudel_for_logs`.
4. Strudel automatically adds the necessary logging code to the files you change in your branch.
5. You can now 'pull' strudel changes to your local branch.
5. When you open pull request, reviewers will see both the logging code and your business logic during the review.

### Add or remove logging-code to your branch manually
If you want to manually add or remove logging code to your branch, you can do so by using two methods. 
1. Using Strudel [CLI](#add-or-remove-logging-code-using-strudel-cli).
2. Using a [commit message](#adding-or-removing-logging-code-in-your-branch-via-commit-messages).


#### Add or Remove Logging Code Using Strudel CLI

1. **Platform Support**  
   The current version of the Strudel CLI is supported only on **Mac** and **Linux**.

2. **Download Strudel CLI**  
   You can download the Strudel CLI script from the following link:  
   [Strudel CLI Download](https://github.com/strudelbots/strudel-public/blob/main/strudel_code/strudel_cli.sh)  
   Alternatively, use this `curl` command to download it:  
   ```bash
   curl -o strudel_cli.sh https://raw.githubusercontent.com/strudelbots/strudel-public/refs/heads/main/strudel_code/strudel_cli.sh
   ```

3. **Add Strudel CLI to Your Path**  
   Ensure the `strudel_cli.sh` script is added to your system's PATH so it can be executed from anywhere.

4. **Run the Strudel CLI Commands**  
   Execute the Strudel CLI from your branch using one of the following commands:  
   - **Add logs** to the current branch:  
     ```bash
     strudel_cli.sh add-logs
     ```  
   - **Remove logs** from the current branch:  
     ```bash
     strudel_cli.sh remove-logs
     ```  
   - **Add logs** to all Python files in the repository:  
     ```bash
     strudel_cli.sh add-repo-logs
     ```  
   - **Remove logs** from all Python files in the repository:  
     ```bash
     strudel_cli.sh remove-repo-logs
     ```  
   - **Run Strudel tests**:  
     ```bash
     strudel_cli.sh test-strudel
     ```

   
#### Adding or Removing Logging Code in Your Branch via Commit Messages

If you'd like more control over when Strudel is invoked (e.g., to avoid triggering it on every push), you can do so by using specific commit messages. To enable this, follow these steps:

1. **Disable Automatic Strudel Invocation:**  
   Update the configuration by setting `enable_on_push` to `false` in the file `run_strudel_for_logs.yml`. This will disable the default behavior of invoking Strudel on every push.

2. **Use Commit Messages to Control Logging Code:**  
   - To **add logging code** to your branch, include the keyword `add-logs` in your commit message when committing your changes.  
   - To **remove logging code** from your branch, include the keyword `remove-logs` in your commit message when committing your changes.
   - To **add logging code from all files in your repository**, include the keyword `add-repo-logs` in your commit message when committing your changes.
   - To **remove logging code from all files in your repository**, include the keyword `remove-repo-logs` in your commit message when committing your changes.




## Configuring Strudel 
### Setting the logger name
By default, Strudel will use the name `strudel` as the logger name. That is, Strudel produces
logs of the form `strudel.<log-level>(<log message>)`. 
If you want to change the logger name, you can do so by adding the following line to your code:
<pre>
uses: strudel-ai/strudel-public/.github/workflows/run_strudel_for_logs.yml       
   <b>with:
       logger_name: &#60;your logger name&gt; </b>
   secrets:
</pre>
### Exclude Directories from Strudel Analysis
To exclude directories from Strudel analysis and modification, add 
the `excluded_directories` parameter to the `run_strudel_for_logs.yml`  
action. List the directories you want to exclude, separating them with the `+` character. 
You can exclude up to ten directories.
By default, this parameter excludes the `test` and `tests` directories, as shown below:
<pre>
uses: strudel-ai/strudel-public/.github/workflows/run_strudel_for_logs.yml
  <b>with:
    excluded_directories: test+tests</b>
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
2. Create a new file in the `.github/workflows` directory with the name `run-strudel-test.yml`.
2. CCopy the following code into the file:
```
name: run strudel test
# version v28.0
on:
  workflow_dispatch:
    inputs:
      user_command:
        description: "insert 'test-strudel' to run this job"
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
      - uses: actions/checkout@v3
        with:
          ref: ${{ github.event.pull_request.head.sha }}

      - name: check user command
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
          if [[ $user_command == *"TEST-STRUDEL"* ]]; then
            echo "Run strudel with cli command: $user_command"
            echo "RUN_STRUDEL=$user_command" >> $GITHUB_OUTPUT
          elif [[ $last_commit == *"TEST-STRUDEL"* ]]; then
              echo "Run strudel-test by commit message"
              echo "RUN_STRUDEL=TEST-STRUDERL" >> $GITHUB_OUTPUT
          else
            echo "RUN_STRUDEL=none" >> $GITHUB_OUTPUT
            echo "No strudel test requested, to run strudel test, please include 'TEST-STRUDEL' in your command"
          fi
          }
  run-strudel-test:
    needs: [ should_run_strudel ]
    if: ${{ needs.should_run_strudel.outputs.run_strudel!='none' }}
    uses: strudelbots/strudel-public/.github/workflows/run_strudel_test.yml@v28.0
    with:
      master_branch: main
      use_dev_ecr_repository: true
      excluded_directories: test+tests
      runner: ubuntu-22.04 # experimental
    secrets:
        strudel_access_key: ${{ secrets.STRUDEL_ACCESS_KEY_ID }}
        strudel_secret_key: ${{ secrets.STRUDEL_SECRET_KEY }}


```
2. Commit and push the changes to the repository
3. Manually run the new work flow. 
4. Check the steps and the logs of the action to ensure that the test ran successfully.

### Create Main Strudel Action in Your Github Repository
1. Create a new file in the `.github/workflows` directory with the name 
`run_strudel_for_logs.yml`
2. Copy the following code into the file:
```

name: Run strudel-for-logs
# version: v28.0 

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
          is_push: ${{ github.event_name == 'push' }}
          enable_on_push: true
        id: user_command
        shell: bash
        run: |
          echo "Working branch:" ${{ github.ref }}
          user_command=${{ inputs.user_command }} 
          user_command=${user_command^^}
          last_commit=$(git log -1 --pretty=%B $sha_last_commit)
          last_commit=${last_commit^^}
          echo "last_commit: $last_commit"
          echo "user_command: $user_command"

          { # feel free to change the logic here to decide when to run strudel
          if [[ $user_command == "ADD-LOGS" || $user_command == "REMOVE-LOGS" ]]; then
            user_command=${user_command,,}
            echo "Run strudel with user command: $user_command"
            echo "RUN_STRUDEL=$user_command" >> $GITHUB_OUTPUT
          elif [[ $user_command == "ADD-REPO-LOGS" || $user_command == "REMOVE-REPO-LOGS" ]]; then
            user_command=${user_command,,}
            echo "Run strudel with user command: $user_command"
            echo "RUN_STRUDEL=$user_command" >> $GITHUB_OUTPUT
          elif [[ $last_commit == *"REMOVE-LOGS"* ]]; then
            echo "Run strudel remove logs commit message: $last_commit"
            echo "RUN_STRUDEL=remove-logs" >> $GITHUB_OUTPUT
          elif [[ $last_commit == *"ADD-LOGS"* ]]; then 
              echo "Run strudel add logs commit message: $last_commit"
              echo "RUN_STRUDEL=add-logs" >> $GITHUB_OUTPUT
          elif [[ $last_commit == *"ADD-REPO-LOGS"* ]]; then 
              echo "Run strudel add repo logs commit message: $last_commit"
              echo "RUN_STRUDEL=add-repo-logs" >> $GITHUB_OUTPUT
          elif [[ $last_commit == *"REMOVE-REPO-LOGS"* ]]; then 
              echo "Run strudel remove repo logs commit message: $last_commit"
              echo "RUN_STRUDEL=remove-repo-logs" >> $GITHUB_OUTPUT
          elif [[ "$is_push" = true && "$enable_on_push" = true ]]; then
            echo "Run default strudel settings for push"
            echo "RUN_STRUDEL=add-logs" >> $GITHUB_OUTPUT
          else
                echo "no commit message or user commandto match "
                echo "RUN_STRUDEL=none" >> $GITHUB_OUTPUT
          fi
          }
  run-strudel-for-logs:
    needs: [ should_run_strudel ]
    if: ${{ needs.should_run_strudel.outputs.run_strudel!='none' }}
    uses: strudelbots/strudel-public/.github/workflows/run_strudel_for_logs.yml@v28.0
    with:
# Make sure to change the name of your master branch if it is not main
      master_branch: main
      user_command: ${{ needs.should_run_strudel.outputs.run_strudel }}
      use_dev_ecr_repository: true
      excluded_directories: test+tests
      runner: ubuntu-22.04 # experimental 

    secrets:
      strudel_access_key: ${{ secrets.STRUDEL_ACCESS_KEY_ID }}
      strudel_secret_key: ${{ secrets.STRUDEL_SECRET_KEY }}

permissions:
  actions: write
  contents: write

```
2. **Make sure** you configure the name of you main branch in the file above
3. Commit and push the changes to the repository



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
1. **March-4-25: Version 28.0 released.** 
   - Improved logging-code placements.
   - Ability set a runner type in Strudel actions 

1. **Feb-15-25: Version 0.26.02 released.** 
   - Support for [exclusion of directories](#exclude-directories-from-strudel-analysis) 
   from Strudel analysis.

2. **Jan-19-25: Version 0.24.04 released.** 
   - Support for entire repository add/remove logging-code (see [Using Strudel](#using-strudel) section).

2. **Dec-19-24: Version 0.22.04 released.** 
   - Strudel CLI for Mac and Unix users.
   Get the CLI:
   ```
   curl -o strudel_cli.sh https://raw.githubusercontent.com/strudelbots/strudel-public/refs/heads/main/strudel_code/strudel_cli.sh
   ```

   

### More options to trigger Strudel 
In addition to the commit message, you will be able to trigger Strudel using a
GitHub label or a comment in the pull request. This will give you more flexibility
in controlling when Strudel adds logging code to your pull request.