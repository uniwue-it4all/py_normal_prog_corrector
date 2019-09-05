#!/usr/bin/env bash

IMG_NAME=beyselein/py_normal_prog_corrector

EX=${1:?"Error: exercise name / folder is not defined!"}

# remove trailing slash from 'exercise' (folder!)
if [[ ${EX} == */ ]]; then
    EX=${EX::-1}
fi

ERROR_SUFFIX=${2:-""}

# Build image
docker build -t ${IMG_NAME} .

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

FILES_TO_LINT_FILE=${EX}/lints.txt

RES_FILE=results/${SOL_FILE_NAME}_result
if [[ ! -f ${RES_FILE} ]]; then
    mkdir -p results
    touch ${RES_FILE}
else
    > ${RES_FILE}
fi


LINT_RESULTS_FILE=results/${EX}_lints.json
if [[ ! -d ${LINT_RESULTS_FILE}} ]]; then
    # create lint results file if not exists
    touch ${LINT_RESULTS_FILE}
else
    # clear lint results file
    > ${LINT_RESULTS_FILE}
fi

docker run -it --rm \
    -v $(pwd)/${SOL_FILE}:/data/${EX}.py \
    -v $(pwd)/${TEST_FILE}:/data/${EX}_test.py \
    -v $(pwd)/${FILES_TO_LINT_FILE}:/data/files_to_lint.txt \
    -v $(pwd)/${LINT_RESULTS_FILE}:/data/lint_results.json \
    ${IMG_NAME} > ${RES_FILE}