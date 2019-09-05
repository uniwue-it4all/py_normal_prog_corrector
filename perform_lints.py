from json import dumps as json_dumps
from typing import Dict

from pylint import epylint

results: Dict[str, Dict[str, str]] = {}

with open('files_to_lint.txt', 'r') as f:
    files_to_lint = f.read().splitlines()

    file_to_lint: str
    for file_to_lint in files_to_lint:
        (pylint_stdout, pylint_stderr) = epylint.py_run(file_to_lint, return_std=True)

        results[file_to_lint] = {
            'stdout': pylint_stdout.getvalue().split('\n'),
            'stderr': pylint_stderr.getvalue().split('\n')
        }

with open('lint_results.json', 'w') as res_file:
    res_file.write(json_dumps(results, indent=2))
