#!/bin/bash


if [ $# -ne 2 ]
then
   echo "Missing argument : $0 <baselineId> <PatchGroups separated by coma"
   exit 0
else

    BASELINE_ID=$1
    TAG_GROUPS=$2

    echo "baseline_id = $BASELINE_ID"
    echo "TAG_GROUPS = $TAG_GROUPS"

    Field_Separator=$IFS
    IFS=","

    for tag in ${TAG_GROUPS};
    do
        aws ssm register-patch-baseline-for-patch-group --baseline-id "${BASELINE_ID}" --patch-group "${tag}"
    done

    IFS=$Field_Separator

fi

