ssm_config = Config(region_name = region)

ssm = boto3.client('ssm',config=)

def retreiveEffectivePatchBaselines(ssm,baselineId)
response = ssm.describe_effective_patches_for_patch_baseline(
    BaselineId=baselineId,
    MaxResults=123,
    NextToken='string'
)


def retrieveAllPatchBaselines(ssm,operatingSystem):
    # 

    response = ssm.describe_patch_baselines()

    baseLineIdentities = response['BaselineIdentities']

    for baselineIdentity in baseLineIdentities:
        baselineId=baselineIdentity['BaselineId']
        result = retrieveEffectivePatchBaselines(ssm,baselineId)
        return result


def main(ssm):
