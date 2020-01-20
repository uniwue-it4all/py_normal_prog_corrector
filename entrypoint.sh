#!/usr/bin/env bash

timeout -s KILL 2 python -m unittest discover -p "*_test.py"
