import difflib
import os

import requests


url = 'http://localhost:8080/add_logs/'

OVERWRITE_ORIG_FILES = True
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
    changed_files = os.getenv('ALL_CHANGED_FILES', None)
    if not changed_files:
        print('No changed files found')
    else:
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
            if OVERWRITE_ORIG_FILES and diff:
                print("writing file: " + file)
                with open(file, 'w') as f:
                        f.write(response.json()['modified_source'])
        else:
            raise ValueError(f'Unexpected status code: {response.status_code}')
    return files_200, files_400

if __name__ == '__main__':
    python_files, not_python_files =  get_all_files()
    if not python_files:
        print('No python files found' )
        exit(0)
    files_200, files_400, = analyze_files(python_files)
    print(f'files_200, {files_200}')
    print(f'files_400, {files_400}')