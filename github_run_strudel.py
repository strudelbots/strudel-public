import os

import requests


url = 'http://localhost:8080/add_logs/'

OVERWRITE_ORIG_FILES = True
def read_file_as_string(test_program, test_dir=""):
    file_full_name = os.path.join(test_dir, "e2e_tests", test_program)
    text_file = open(file_full_name ,'r')
    python_string = text_file.read()
    text_file.close()
    return python_string
def get_all_files():
    python_files = []
    changed_files = os.getenv('ALL_CHANGED_FILES', 'github_run_strudel.py')
    if changed_files:
        all_files = changed_files.split(' ')
        if len(all_files) ==0:
            raise ValueError('ALL_CHANGED_FILES is empty')
        print(f"**************** len of files: {len(all_files)}")
        for file in all_files:
            if file.endswith('.py'):
                python_files.append(file)
    return python_files, []


def _get_files_from_disc(python_files):
    not_python_files = []
    directory = os.getcwd()
    for dirpath, dirnames, filenames in os.walk(directory):
        if 'venv' in dirpath:
            continue
        if 'tox' in dirpath:
            continue
        for filename in filenames:
            if filename.endswith('.py') and not 'strudel' in filename:
                full_name = os.path.join(dirpath, filename)
                if single_file and full_name != single_file:
                    continue
                python_files.append(full_name)
            else:
                not_python_files.append(os.path.join(dirpath, filename))
    print("Total python files: " + str(len(python_files)), "Total not python files: " + str(len(not_python_files)))
    return not_python_files


def analyze_files(python_files):
    if len(python_files) > 5000:
        raise ValueError('Too many files to analyze')
    total_files = 0
    files_200 = 0
    files_400 = 0
    for index, file in enumerate(python_files):
        file_string = read_file_as_string(file)
        file_name = file.split("/")[-1]
        n_lines = len(file_string.splitlines())
        n_chars = len(file_string)
        if len(file_string) > 80000:
            continue
        payload_dict = {"source": "not used", "file_content": file_string, "file_name":  file}
        headers =  {'Accept': 'application/json',
                    'Content-Type': 'application/json',
                    "X-Request-Id": "run-strudel-"+str(index)
                    }
        start = datetime.datetime.now()
        response = requests.post(url, json=payload_dict, headers=headers)
        end = datetime.datetime.now()
        latency = (end - start).microseconds
        total_time_microseconds += latency
        if response.status_code == 400:
            print(f'ERROR 400, {file}')

            files_400 += 1
        elif response.status_code == 200:
            print("file 200: "+ file)

            if "e2e_tests" not in file :
                print('e2e tests not in file')
                diff = False
                if OVERWRITE_ORIG_FILES and diff:
                    print("writing file: " + file)
                    with open(file, 'w') as f:
                        f.write(response.json()['modified_source'])

            if SAVE_EACH_FILE_RESULT:
                _write_result_file((file, file_name), response)
        else:
            continue
    return results, files_200, files_400, total_time_microseconds

if __name__ == '__main__':
    python_files, not_python_files =  get_all_files()
    if not python_files:
        raise ValueError('No python files found')
    result, files_200, files_400, total_time_microseconds = analyze_files(python_files)
    print(f'files_200, {files_200}')
    print(f'files_400, {files_400}')
