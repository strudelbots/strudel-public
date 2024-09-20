import logging # STRUDEL_IMPORT_0
import difflib
import os

import requests


strudel = logging.getLogger(__name__) # STRUDEL_IMPORT_1
strudel.addHandler(logging.StreamHandler()) # STRUDEL_IMPORT_2
strudel.setLevel(logging.INFO) # STRUDEL_IMPORT_3
url = 'http://localhost:8080/add_logs/'

OVERWRITE_ORIG_FILES = True
def _file_changed_by_strudel(file:tuple, response):
    strudel.info('Method "_file_changed_by_strudel" starts') #  # STRUDEL_TRACE_1

    response_json = response.json()
    original_source = _read_file_as_string(file[0])
    modified_source = response_json['modified_source']
    diff = _is_diff_beside_WS(modified_source, original_source)
    if diff:
        strudel.info('Test Prefix Call print("Found diff in file: ", file[0]) because diff') #  # STRUDEL_IF_LOG_1
        strudel.info('Test Prefix diff') #  # STRUDEL_IF_LOG_0
        print("Found diff in file: ", file[0])
    else:
        strudel.info('Test Prefix Call print("No diff: " + file[0]) because "diff" is evaluated to False') #  # STRUDEL_IF_LOG_ELSE_2
        print("No diff: " + file[0])
    strudel.info('Method "_file_changed_by_strudel" returns "diff"') #  # STRUDEL_RETURN_TRACE_0
    return diff

def _is_diff_beside_WS(modified_source, original_source):
    strudel.info('Method "_is_diff_beside_WS" starts') #  # STRUDEL_TRACE_1
    for i, s in enumerate(difflib.ndiff(original_source, modified_source)):
        if s[0] == ' ':
            strudel.info('Test Prefix s[0] == " "') #  # STRUDEL_IF_LOG_0
            continue
        elif s[0] == '-':
            strudel.info('Test Prefix s[0] == "-"') #  # STRUDEL_IF_LOG_0
            if s == '- \n' or s == '-  ':
                strudel.info('Test Prefix s == "- \n" OR s == "-  "') #  # STRUDEL_IF_LOG_0
                continue
            return True
        elif s[0] == '+':
            strudel.info(f'Test Prefix Return True because s[0] == "+"') #  # STRUDEL_IF_LOG_1
            strudel.info('Test Prefix s[0] == "+"') #  # STRUDEL_IF_LOG_0
            return True
    strudel.info('Return False') #  # STRUDEL_RETURN_TRACE_0
    return False

def _read_file_as_string(file_name, dir=""):
    strudel.info('Method "_read_file_as_string" starts') #  # STRUDEL_TRACE_1
    file_full_name = os.path.join(dir, "", file_name)
    text_file = open(file_full_name ,'r')
    python_string = text_file.read()
    text_file.close()
    strudel.info('Method "_read_file_as_string" returns "python_string"') #  # STRUDEL_RETURN_TRACE_0
    return python_string
def get_all_files():
    strudel.info('Method "get_all_files" starts') #  # STRUDEL_TRACE_1
    python_files = []
    changed_files = os.getenv('ALL_CHANGED_FILES', None)
    if not changed_files:
        strudel.info('Test Prefix Call print("No changed files found") because "changed_files" is evaluated to False') #  # STRUDEL_IF_LOG_1
        strudel.info('Test Prefix "changed_files" is evaluated to False') #  # STRUDEL_IF_LOG_0
        print('No changed files found')
    else:
        all_files = changed_files.split(' ')
        if len(all_files) ==0:
            strudel.error('Test Prefix Raise ValueError("ALL_CHANGED_FILES is empty") because Length of all_files={len(all_files)} == 0') #  # STRUDEL_IF_LOG_1
            strudel.info('Test Prefix Length of all_files={len(all_files)} == 0') #  # STRUDEL_IF_LOG_0
            raise ValueError('ALL_CHANGED_FILES is empty')
        print(f"**************** len of files: {len(all_files)}")
        for file in all_files:
            if file.endswith('.py'):
                strudel.info('Test Prefix Call Appending file to python_files because file.endswith(".py")') #  # STRUDEL_IF_LOG_1
                strudel.info('Test Prefix file.endswith(".py")') #  # STRUDEL_IF_LOG_0
                python_files.append(file)
    strudel.info('Return stub log') #  # STRUDEL_RETURN_TRACE_0
    return python_files, []

def _get_files_from_disc(python_files):
    strudel.info('Method "_get_files_from_disc" starts') #  # STRUDEL_TRACE_1
    not_python_files = []
    directory = os.getcwd()
    for dirpath, dirnames, filenames in os.walk(directory):
        if 'venv' in dirpath:
            strudel.info('Test Prefix "venv" in dirpath') #  # STRUDEL_IF_LOG_0
            continue
        if 'tox' in dirpath:
            strudel.info('Test Prefix "tox" in dirpath') #  # STRUDEL_IF_LOG_0
            continue
        for filename in filenames:
            if filename.endswith('.py') and not 'strudel' in filename:
                strudel.info('Test Prefix filename.endswith(".py") AND "strudel" in filename') #  # STRUDEL_IF_LOG_0
                full_name = os.path.join(dirpath, filename)
                if single_file and full_name != single_file:
                    strudel.info('Test Prefix single_file AND full_name != single_file') #  # STRUDEL_IF_LOG_0
                    continue
                python_files.append(full_name)
            else:
                strudel.info('Test Prefix Call Appending os.path.join(dirpath, filename) to not_python_files because Condition: not (filename.endswith(".py") AND "strudel" in filename)') #  # STRUDEL_IF_LOG_ELSE_1
                not_python_files.append(os.path.join(dirpath, filename))
    print("Total python files: " + str(len(python_files)), "Total not python files: " + str(len(not_python_files)))
    strudel.info('Method "_get_files_from_disc" returns "not_python_files"') #  # STRUDEL_RETURN_TRACE_0
    return not_python_files


def analyze_files(python_files):
    strudel.info('Method "analyze_files" starts') #  # STRUDEL_TRACE_1
    if len(python_files) > 5000:
        strudel.error('Test Prefix Raise ValueError("Too many files to analyze") because Length of python_files={len(python_files)} > 5000') #  # STRUDEL_IF_LOG_1
        strudel.info('Test Prefix Length of python_files={len(python_files)} > 5000') #  # STRUDEL_IF_LOG_0
        raise ValueError('Too many files to analyze')
    files_200 = 0
    files_400 = 0
    for index, file in enumerate(python_files):
        file_string = _read_file_as_string(file)
        file_name = file.split("/")[-1]
        if len(file_string) > 80000:
            strudel.info('Test Prefix Length of file_string={len(file_string)} > 80000') #  # STRUDEL_IF_LOG_0
            continue
        payload_dict = {"source": "not used", "file_content": file_string, "file_name":  file}
        headers =  {'Accept': 'application/json',
                    'Content-Type': 'application/json',
                    "X-Request-Id": "run-strudel-"+str(index)
                    }
        response = requests.post(url, json=payload_dict, headers=headers)
        if response.status_code == 400:
            strudel.info('Test Prefix response.status_code == 400') #  # STRUDEL_IF_LOG_0
            print(f'ERROR 400, {file}')
            files_400 += 1
        elif response.status_code == 200:
            strudel.info('Test Prefix response.status_code == 200') #  # STRUDEL_IF_LOG_0
            print("file 200: "+ file)
            files_200 += 1
            diff = _file_changed_by_strudel((file, file_name), response)
            if OVERWRITE_ORIG_FILES and diff:
                strudel.info('Test Prefix Both OVERWRITE_ORIG_FILES AND diff are True') #  # STRUDEL_IF_LOG_0
                print("writing file: " + file)
                with open(file, 'w') as f:
                        f.write(response.json()['modified_source'])
        else:
            strudel.error('Test Prefix Raise ValueError(Unexpected status code:   . . .) because response.status_code == 200') #  # STRUDEL_IF_LOG_ELSE_1
            raise ValueError(f'Unexpected status code: {response.status_code}')
    strudel.info('Return stub log') #  # STRUDEL_RETURN_TRACE_0
    return files_200, files_400

if __name__ == '__main__':
    strudel.info('Test Prefix running main') #  # STRUDEL_IF_LOG_0
    python_files, not_python_files =  get_all_files()
    if not python_files:
        strudel.info('Test Prefix "python_files" is evaluated to False') #  # STRUDEL_IF_LOG_0
        print('No python files found' )
        exit(0)
    files_200, files_400, = analyze_files(python_files)
    print(f'files_200, {files_200}')
    print(f'files_400, {files_400}')
