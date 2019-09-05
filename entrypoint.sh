#!/usr/bin/env bash

python perform_lints.py

timeout -t 2 -s KILL python -m unittest discover -p "*_test.py"