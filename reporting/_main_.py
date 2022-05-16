#!/usr/bin/python

import boto3
import os
from botocore.config import Config

region=os.environ['region']
file=os.environ['file']

ssm_config = Config(
    region_name = region
    )

ssm = boto3.client('ssm', config=ssm_config)

baselineIds = []

def retreiveEffectivePatchBaselinePatches(ssm,id):
    result = []
    response = ""
    try:
        response = ssm.describe_effective_patches_for_patch_baseline(BaselineId=id, MaxResults=100)
        while "NextToken" in response:
            response =  ssm.describe_effective_patches_for_patch_baseline(BaselineId=id, MaxResults=100, NextToken=response["NextToken"])
            result.extend(response)
    except Exception:
        pass
    sreport= ' '.join([str(item)for item in result])
    f = open(file, "a")
    f.write(sreport)
    f.close

def retrieveAllPatchBaselines(ssm):
    # Get them Baselines
    response = ssm.describe_patch_baselines()
    # Get them Baseline Ids
    baseLineIdentities = response['BaselineIdentities']
    # Iterate through them baselines ids, create list
    for baselineIdentity in baseLineIdentities:
        baselineId=baselineIdentity['BaselineId']
        baselineIds.append(baselineId)
    return baselineIds

# Main funtction that is going to tie them them functions together and add them logging and report sending logic
def main(ssm):
    availableBaselines = retrieveAllPatchBaselines(ssm)
    # Iterate through them baseline id's and get them effective patch baselines add to a report
    for id in availableBaselines:
        report = retreiveEffectivePatchBaselinePatches(ssm,id)

main(ssm)