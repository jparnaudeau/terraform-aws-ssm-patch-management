#!/usr/bin/python

import boto3
import os
from botocore.config import Config

region = os.environ['AWS_DEFAULT_REGION']

ssm_config = Config(
    region_name = region
    )

ssm = boto3.client('ssm', config=ssm_config)

baselineIds = []
reports = []

def retreiveEffectivePatchBaselinePatches(ssm,id):
    response = ""
    try:
        response = ssm.describe_effective_patches_for_patch_baseline(BaselineId=id, MaxResults=123)
    except Exception:
        pass
    return response


def retrieveAllPatchBaselines(ssm):
    # Get them Baselines
    response = ssm.describe_patch_baselines()
    # Get them Baseline Ids
    baseLineIdentities = response['BaselineIdentities']
    # Iterate through them baselines ids, retrieve them effective patches
    for baselineIdentity in baseLineIdentities:
        baselineId=baselineIdentity['BaselineId']
        baselineIds.append(baselineId)
    return baselineIds

# Main funtction that is going to tie them them functions together and add them logging and report sending logic
def main(ssm):
    availableBaselines = retrieveAllPatchBaselines(ssm)
    for id in availableBaselines:
        report = retreiveEffectivePatchBaselinePatches(ssm,id)
        reports.append(report)
    return report
        


main(ssm)
print(reports)