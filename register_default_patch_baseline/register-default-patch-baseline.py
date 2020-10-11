#!/usr/bin/env python3

import sys
import traceback
import boto3

def checkArguments(action,operatingSystem):
    checkAction = False
    checkOperatingSystem = False

    if action in ['register','deregister']:
        checkAction = True

    if operatingSystem in ['SUSE','WINDOWS','UBUNTU','DEBIAN','AMAZON_LINUX','AMAZON_LINUX_2','REDHAT_ENTERPRISE_LINUX','CENTOS']:
        checkOperatingSystem = True

    return checkAction and checkOperatingSystem


def retrieveAWSDefaultPatchBaselineForOperatingSystem(operatingSystem):
    # the AWS default Patch Baseline are the same in any AWS Account

    mapAWSDefaultPatchBaselines = {}
    mapAWSDefaultPatchBaselines['REDHAT_ENTERPRISE_LINUX'] = "arn:aws:ssm:eu-central-1:416089608788:patchbaseline/pb-002f93afc8c43b096"
    mapAWSDefaultPatchBaselines['CENTOS'] = "arn:aws:ssm:eu-central-1:416089608788:patchbaseline/pb-0081b03b93d656fb9"
    mapAWSDefaultPatchBaselines['AMAZON_LINUX_2'] = "arn:aws:ssm:eu-central-1:416089608788:patchbaseline/pb-043cba60253bab521"
    mapAWSDefaultPatchBaselines['AMAZON_LINUX'] = "arn:aws:ssm:eu-central-1:416089608788:patchbaseline/pb-056d4257efe913420"
    mapAWSDefaultPatchBaselines['DEBIAN'] = "arn:aws:ssm:eu-central-1:416089608788:patchbaseline/pb-0995d101011ef0d2d"
    mapAWSDefaultPatchBaselines['WINDOWS'] = "arn:aws:ssm:eu-central-1:416089608788:patchbaseline/pb-0af17a967557961db"
    mapAWSDefaultPatchBaselines['SUSE'] = "arn:aws:ssm:eu-central-1:416089608788:patchbaseline/pb-0b2a80796f793fc54"
    mapAWSDefaultPatchBaselines['UBUNTU'] = "arn:aws:ssm:eu-central-1:416089608788:patchbaseline/pb-0f40e1898bd7e2eca"

    return mapAWSDefaultPatchBaselines[operatingSystem]



###########################
# MAIN
###########################
if __name__ == '__main__':

    try:
        if len(sys.argv) != 4:
            print("Missing argument : " + sys.argv[0] + " <register|deregister> <baselineId> <opertingSystem>")
            sys.exit()

        else:
            action = sys.argv[1]
            baselineId = sys.argv[2]
            operatingSystem = sys.argv[3]

            # check arguments
            if checkArguments(action,operatingSystem):
                # OK. we can works.

                client = boto3.client('ssm')

                if action == 'register':
                    response = client.register_default_patch_baseline(BaselineId=baselineId)
                    print("Default Patch Baseline for operatingSystem {} : {}".format(operatingSystem,response['BaselineId']))
                
                else:

                    # retrieve the AWS Default Patch Baseline for the operatingSystem
                    awsDefaultPatchBaselineId = retrieveAWSDefaultPatchBaselineForOperatingSystem(operatingSystem)

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
        