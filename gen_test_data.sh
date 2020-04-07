#! /bin/bash

# generates test data

FILE_COUNT=10000

rm -rf test_data
mkdir test_data

echo "[INFO] generating $TEST_COUNT test files"
for i in $(seq $FILE_COUNT); do
    dd if=/dev/urandom of=test_data/testfile$i bs=1 count=10000
done