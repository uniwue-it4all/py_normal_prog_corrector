#!/usr/bin/env bash

EX=${1:?"Error: exercise name / folder is not defined!"}

ERROR_SUFFIX=${2:-""}

SOL_FILE=${EX}/${EX}.py

IMG_NAME=py_normal_prog_corrector


docker build -t ${IMG_NAME} .


SOL_FILE=${EX}/${EX}${ERROR_SUFFIX}.py
if [[ ! -f ${SOL_FILE} ]]; then
    echo "The solution file ${SOL_FILE} does not exist!"
    exit 1
fi

TEST_FILE=${EX}/${EX}_test.py
if [[ ! -f ${TEST_FILE} ]]; then
    echo "The test file ${TEST_FILE} does not exist!"
    exit 2
fi

RES_FILE=results/${EX}_result
if [[ ! -f ${RES_FILE} ]]; then
    mkdir results
    touch ${RES_FILE}
else
    > ${RES_FILE}
fi


docker run -it --rm \
    -v $(pwd)/${SOL_FILE}:/data/${EX}.py \
    -v $(pwd)/${TEST_FILE}:/data/${EX}_test.py \
    ${IMG_NAME}