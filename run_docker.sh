#!/usr/bin/env bash

EX=${1:?"Error: exercise name / folder is not defined!"}

if [[ ${EX} == */ ]]; then
    EX=${EX::-1}
fi

ERROR_SUFFIX=${2:-""}

SOL_FILE=${EX}/${EX}.py

IMG_NAME=beyselein/py_normal_prog_corrector

# Build image
#docker build -t ${IMG_NAME} .

SOL_FILE_NAME=${EX}${ERROR_SUFFIX}
SOL_FILE=${EX}/${SOL_FILE_NAME}.py
if [[ ! -f ${SOL_FILE} ]]; then
    echo "The solution file ${SOL_FILE} does not exist!"
    exit 1
fi

TEST_FILE=${EX}/${EX}_test.py
if [[ ! -f ${TEST_FILE} ]]; then
    echo "The test file ${TEST_FILE} does not exist!"
    exit 2
fi

RES_FILE=results/${SOL_FILE_NAME}_result
if [[ ! -f ${RES_FILE} ]]; then
    if [[ ! -d results ]]; then
        mkdir results
    fi
    touch ${RES_FILE}
else
    > ${RES_FILE}
fi


docker run -it --rm \
    -v $(pwd)/${SOL_FILE}:/data/${EX}.py \
    -v $(pwd)/${TEST_FILE}:/data/${EX}_test.py \
    ${IMG_NAME} > ${RES_FILE}