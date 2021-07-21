#!/usr/bin/env python3

import sys
import traceback
import boto3
from botocore.config import Config


def checkArguments(action,operatingSystem):
    checkAction = False
    checkOperatingSystem = False

    if action in ['register','deregister']:
        checkAction = True

    if operatingSystem in ['SUSE','WINDOWS','UBUNTU','DEBIAN','AMAZON_LINUX','AMAZON_LINUX_2','REDHAT_ENTERPRISE_LINUX','CENTOS']:
        checkOperatingSystem = True

    return checkAction and checkOperatingSystem


def retrieveAWSDefaultPatchBaselineForOperatingSystem(client,operatingSystem):
    # the AWS default Patch Baseline are the same in any AWS Account, depending of the region

    response = client.describe_patch_baselines(Filters=[
                                                    {
                                                        'Key': 'OWNER',
                                                        'Values': [
                                                            'AWS',
                                                        ]
                                                    },
                                                ],
                                                )

    baseLineIdentities = response['BaselineIdentities']

    for baselineIdentity in baseLineIdentities:
        if baselineIdentity['OperatingSystem'] == operatingSystem:
            return baselineIdentity['BaselineId']


###########################
# MAIN
###########################
if __name__ == '__main__':

    try:
        if len(sys.argv) != 5:
            print("Missing argument : " + sys.argv[0] + " <register|deregister> <baselineId> <opertingSystem> <region>")
            sys.exit()

        else:
            action          = sys.argv[1]
            baselineId      = sys.argv[2]
            operatingSystem = sys.argv[3]
            region          = sys.argv[4]

            # check arguments
            if checkArguments(action,operatingSystem):
                # OK. we can works.


                my_config = Config(
                                    region_name = region,
                                    # signature_version = 'v4',
                                    # retries = {
                                    #     'max_attempts': 10,
                                    #     'mode': 'standard'
                                    # }
                                )
                client = boto3.client('ssm',config=my_config)

                if action == 'register':
                    response = client.register_default_patch_baseline(BaselineId=baselineId)
                    print("Default Patch Baseline for operatingSystem {} : {}".format(operatingSystem,response['BaselineId']))
                
                else:

                    # retrieve the AWS Default Patch Baseline for the operatingSystem
                    awsDefaultPatchBaselineId = retrieveAWSDefaultPatchBaselineForOperatingSystem(client,operatingSystem)

                    # set this patch baseline to default
                    response = client.register_default_patch_baseline(BaselineId=awsDefaultPatchBaselineId)
                    print("Default Patch Baseline for operatingSystem {} : {}".format(operatingSystem,response['BaselineId']))

            else:
                print('Arguments seem not be valid : ')
                print ('action : [register|deregister]')
                print("operatingSystem : ['SUSE','WINDOWS','UBUNTU','DEBIAN','AMAZON_LINUX','AMAZON_LINUX_2','REDHAT_ENTERPRISE_LINUX','CENTOS']")
                sys.exit()

    except Exception as err:
        print("Exception during processing: {0}".format(err))
        traceback.print_exc()
        