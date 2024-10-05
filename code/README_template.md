

## Strudel: Leave the grind to the bots. Engineer the extraordinary.
Strudel is changing how we engineer software by merging human ingenuity with advanced automation. 
With Strudel, software engineers can shift their focus from repetitive, time-consuming tasks to what truly 
matters—innovation, problem-solving, and building exceptional solutions. 
Strudel’s intelligent bots seamlessly handle routine tasks. 
By automating up to 50% of the development process, Strudel will empower
teams to accelerate productivity and drive meaningful innovation. The result? Faster development cycles, higher-quality code, and engineers who can 
focus on engineering the extraordinary.
## About Strudel MVP 
Strudel's MVP simplifies telemetry integration 
by automatically embedding logging and business metrics directly into your Python code.
With Strudel, logging code is automatically added to your pull requests, 
letting you focus solely on business logic without worrying about implementing logs.

## Pre-Requisites
1. **Python**: Strudel MVP is currently available for Python projects only.
1. **Register for Strudel**: Contact Strudel Support via email,
<a href="mailto:support@strudel-ai.com">Send email</a>
2. **Receive Strudel Secrets**: You will receive an email containing your Strudel secrets. 
Keep this email safe and do not share the secrets with anyone.
2. **GitHub Account**:
   1. A repository with Python code where you want to install Strudel. 
   2. Permission to add repository secrets. 
   3. Permission to add GitHub Actions to the repository.

   
## Onboarding  (On Prem Through Github Actions)
### Setup Keys to Access Strudel
1. Go to the repository &rarr; Settings &rarr; Secrets and variables  &rarr; Actions 
1. Add a new secret,  `STRUDEL_ACCESS_KEY_ID`,  with the access key value 
you received from Strudel support. 
1. Add a new secret, e `STRUDEL_SECRET_KEY`, with the secret key value you 
received from Strudel Support. 


### Create Strudel-Test Action in your Github Repository (optional)
This step is optional and can be used to run strudel test 
that verifies your set-up is correct. 
1. Open your repository in GitHub/IDE. 
2. Create a new file in the `.github/workflows` directory with the name `strudel-test.yml`.
2. Copy the following code into the file:
```yaml
test-client-job-come-here
```
2. Commit and push the changes to the repository
3. Manually run the new work flow. 

### Create Strudel add-logs Github Action in Your Repository
1. Create a new file in the `.github/workflows` directory with the name 
`run_strudel_for_logs.yml`
2. Copy the following code into the file:
```yaml
run-client-job-come-here
```
2. Commit and push the changes to the repository

## Add Logging Code to Your Pull Request
With Strudel, logging code is automatically added to your pull requests, 
letting you focus solely on business logic without worrying about implementing logs.

1. Start developing new functionality or fixing a bug in your Python code.
   1. Create a new branch
   2. Work on your new code as usual.
2. When ready for a code review, create a pull request. 
You can use either the GitHub web interface or the GitHub CLI.
   1. [You can create a pull request using the web api.](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request?tool=webui)
   2. [You can create a pull request using the Github cli.](https://external.ink?to=/docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request?tool=cli#creating-the-pull-request)

4. Create a new Commit with a message that 
includes the words `strudel`, `add`,  and `logs` (in any order).
4. Strudel automatically inserts the required logging code into your branch.
5. Reviewers will review the code, now with the logging included (as if you wrote the logging code).
6. Once the review is completed and everyone is satisfied, merge the pull request.


### Add trace-level logging code to your pull request 
In this mode, Strudel adds logging code that enables detailed tracing. 
These logs provide insights into the full execution flow, including method calls 
and control flow, helping you quickly understand the behavior at every level.

This is especially useful during development when you need to verify the flow of execution.

To enable trace-level logging code Commit with a message 
that includes the words `strudel`, `add`,  `logs`, and `trace` 
(in any order).



### Remove all logging-code to your pull request
To remove all Strudel logging-code from a pull request just add the following
words to your commit message: `strudel`, `remove`, `logs` (in any order).
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
## Frequently Asked Questions
## Limitations 

## Providing feedback 
