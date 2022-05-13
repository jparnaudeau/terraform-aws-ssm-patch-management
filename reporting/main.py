def retreiveEffectivePatchBaselines(client,baselineId)
response = client.describe_effective_patches_for_patch_baseline(
    BaselineId=baselineId,
    MaxResults=123,
    NextToken='string'
)


def retrieveAWSDefaultPatchBaselineForOperatingSystem(client,operatingSystem):
    # the AWS default Patch Baseline are the same in any AWS Account, depending of the region

    response = client.describe_patch_baselines()

    baseLineIdentities = response['BaselineIdentities']

    for baselineIdentity in baseLineIdentities:
        baselineId=baselineIdentity['BaselineId']
        result = retrieveEffectivePatchBaselines(client,baselineId)
        return result