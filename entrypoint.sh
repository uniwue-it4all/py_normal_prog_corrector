#!/usr/bin/env bash

timeout -t 2 -s KILL python -m unittest discover -p "*_test.py"