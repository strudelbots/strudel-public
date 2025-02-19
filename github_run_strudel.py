import logging
import difflib
import os
import sys

import requests


strudel = logging.getLogger(__name__)
strudel.addHandler(logging.StreamHandler())
strudel.setLevel(logging.INFO)
url = 'http://localhost:8080/add_logs/'

def _file_changed_by_strudel(file:tuple, response):

    response_json = response.json()
    original_source = _read_file_as_string(file[0])
    modified_source = response_json['modified_source']
    diff = _is_diff_beside_WS(modified_source, original_source)
    if diff:
        print("Found diff in file: ", file[0])
    else:
        print("No diff: " + file[0])
    return diff

def _is_diff_beside_WS(modified_source, original_source):
    for i, s in enumerate(difflib.ndiff(original_source, modified_source)):
        if s[0] == ' ':
            continue
        elif s[0] == '-':
            if s == '- \n' or s == '-  ':
                continue
            return True
        elif s[0] == '+':
            return True
    return False

def _read_file_as_string(file_name, dir=""):
    file_full_name = os.path.join(dir, "", file_name)
    text_file = open(file_full_name ,'r')
    python_string = text_file.read()
    text_file.close()
    return python_string
def get_all_files():
    python_files = []
    changed_files = os.getenv('ALL_CHANGED_FILES_FILE', None)
    if not changed_files:
        strudel.error(' Raise ValueError(No files found for strudel.  . . .) because'
            '"changed_files" is evaluated to False')
        raise ValueError(f'No files found for strudel.')
    else:
        with open(changed_files, 'r') as f:
            all_files = f.read()
        all_files = all_files.removesuffix('\n')
        files = all_files.split(' ')
        for file in files:
            if file.endswith('.py'):
                python_files.append(file)
    return python_files, []


def analyze_files(python_files):
    if len(python_files) > 5000:
        strudel.error(' Raise ValueError("Too many files to analyze") because Length of'
            'python_files={len(python_files)} > 5000')
        raise ValueError('Too many files to analyze')
    files_200 = 0
    files_400 = 0
    for index, file in enumerate(python_files):
        file_string = _read_file_as_string(file)
        file_name = file.split("/")[-1]
        if len(file_string) > 80000:
            continue
        payload_dict = {"source": "not used", "file_content": file_string, "file_name":  file}
        headers =  {'Accept': 'application/json',
                    'Content-Type': 'application/json',
                    "X-Request-Id": "run-strudel-"+str(index)
                    }
        response = requests.post(url, json=payload_dict, headers=headers)
        if response.status_code == 400:
            print(f'ERROR 400, {file}')
            files_400 += 1
        elif response.status_code == 200:
            print("file 200: "+ file)
            files_200 += 1
            diff = _file_changed_by_strudel((file, file_name), response)
            if diff:
                print("writing file: " + file)
                with open(file, 'w') as f:
                    modified_source = response.json()['modified_source']
                    lines = modified_source.split('\n')
                    for line in lines:
                        #print(f'line is: {line}')
                        f.write(line+'\n')
        else:
            raise ValueError(f'Unexpected status code: {response.status_code}, file: {file}')
    return files_200, files_400


def _set_url(action):
    if action == 'add-logs' or action == 'add-repo-logs':
        return 'http://localhost:8080/add_logs/'
    elif action == 'remove-logs' or action == 'remove-repo-logs':
        return 'http://localhost:8080/remove_logs/'
    elif action == 'test-strudel':
        return None
    else:
        strudel.error(' Raise ValueError("Invalid action") because action({action}) != "test-strudel"')
        raise ValueError('Invalid action')

if __name__ == '__main__':
    if len(sys.argv) < 2:
        strudel.error(' Raise ValueError("No action provided") because len(sys.argv) < 2')
        raise ValueError('No action provided')
    print(f'argv: {sys.argv}')
    action = sys.argv[1]
    python_files, not_python_files =  get_all_files()
    url = _set_url(action)
    if action == 'test-strudel':
        print("Test strudel run")
        for file in python_files:
            print(file)
        print(f"Total files: {len(python_files)}")
        exit(0)
    if not python_files:
        print('No python files found' )
        exit(0)
    files_200, files_400, = analyze_files(python_files)
    print(f'files_200, {files_200}')
    print(f'files_400, {files_400}')









