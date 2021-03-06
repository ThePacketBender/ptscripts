#!/bin/sh

while getops b:k:s:f: option
do
case "${option}"
in
    b) bucket=${optARG};;
    p) profile=${OPTARG};;
    f) file={OPTARG};;
esac
done

for i in $file; do
    aws s3 presign s3://"$bucket"/"$i" --profile "$profile" --expires-in 20 | curl - 2>/dev/null
done
