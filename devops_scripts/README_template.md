

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
2. Already using Strudel? Upgrade to the latest [version 0.20.2](#Create-Main-Strudel-Action-in-Your-Github-Repository).
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
   1. Download Strudel CLI <a href=https://github.com/strudelbots/strudel-public/blob/main/strudel_code/strudel_cli.sh>link</a>. 
   Here is a `curl` command to download the CLI:
   ```
   curl -o strudel_cli.sh https://raw.githubusercontent.com/strudelbots/strudel-public/refs/heads/main/strudel_code/strudel_cli.sh
   ```
   4. Add strudel CLI to your path.
   5. Run the Strudel CLI to add logging code to your pull request. Run the CLI from your 
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
test-client-job-come-here
```
2. Commit and push the changes to the repository
3. Manually run the new work flow. 
4. Check the steps and the logs of the action to ensure that the test ran successfully.

### Create Main Strudel Action in Your Github Repository
1. Create a new file in the `.github/workflows` directory with the name 
`run_strudel_for_logs.yml`
2. Copy the following code into the file:
```

run-client-job-come-here

```
2. **Make sure** you configure the name of you main branch in the file above
3. Commit and push the changes to the repository

## Steps to add logging code to your pull request (example)
With Strudel, logging code is automatically added to your pull requests, 
letting you focus solely on business logic without worrying about implementing logs.

1. Create a new branch, for example, `test-strudel-logging`. 
2. Change a few files in this branch (e.g., add/remove functionality, fix a bug, or just add a few lines). 
2. Commit your changes. **In the commit message write the 
following text: `strudel add-logs`**.
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
1. **Dec-24-19: Version 0.20.02 released.** 
   - Strudel CLI for Mac and Unix users.
   Get the CLI:
   ```
   curl -o strudel_cli.sh https://raw.githubusercontent.com/strudelbots/strudel-public/refs/heads/main/strudel_code/strudel_cli.sh
   ```
   
   - Logging for Return Statements isa more accurate.
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