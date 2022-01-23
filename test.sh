#!/bin/bash

echo "---[ test ]-------------------------"
cd ${BASE}
echo "pwd = $(pwd)"

set -x

job-to-xml -help

result=$?
if [ ! ${result} -eq 0 ]; then
    echo "Error: $0[${LINENO}]"
    echo "job-to-xml failed: result: ${result}"
    exit 1
fi

echo "Success"