if __name__ == '__main__':
    print('start')
    test_job_content = ''
    run_job_content = ''
    with open('../.github/workflows/client_side_strudel_test.yml', 'r') as f:
        test_job_content = f.read()
    with open('../.github/workflows/client_side_strudel_run.yml', 'r') as f:
        run_job_content = f.read()

    with open('README_template.md', 'r') as f:
        readme_lines = f.readlines()

    with open('../README.md', 'w') as f:
        for line in readme_lines:
            if 'test-client-job-come-here' in line:
                f.write(test_job_content)
            elif 'run-client-job-come-here' in line:
                f.write(run_job_content)
            else:
                f.write(line)
    print('done')


