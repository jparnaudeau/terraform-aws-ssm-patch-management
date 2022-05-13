ssm_config = Config(region_name = region)

ssm = boto3.client('ssm',config=)

def retreiveEffectivePatchBaselines(ssm,baselineId)
response = ssm.describe_effective_patches_for_patch_baseline( BaselineId=baselineId, MaxResults=123, NextToken='string')


def retrieveAllPatchBaselines(ssm,operatingSystem):
    # Get them Baselines
    response = ssm.describe_patch_baselines()
    # Get them Baseline Ids
    baseLineIdentities = response['BaselineIdentities']
    # Iterate through them baselines ids, retrieve them effective patches
    for baselineIdentity in baseLineIdentities:
        baselineId=baselineIdentity['BaselineId']
        result = retrieveEffectivePatchBaselines(ssm,baselineId)
        return result

# Main funtction that is going to them them functions together and add them logging logic
def main(ssm):
