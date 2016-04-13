#!/bin/bash
#
# THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR 
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS 
# FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.
#

echo "Performing a Datastage Deployment"

# Unzip the file before processing
unzip -o -d ${deployed.container.workDirectory} ${deployed.file.path}

for DSX_FILE in $(ls ${deployed.container.workDirectory}/*.dsx)
do

  echo "Running the command: ${deployed.container.deploymentExecutable} -ISAuthFile ${deployed.container.deploymentISAuthFile} -DSProject ${deployed.deploymentDSProject} -DSXFile $DSX_FILE ${deployed.container.deploymentOptions}"
  ${deployed.container.deploymentExecutable} -ISAuthFile ${deployed.container.deploymentISAuthFile} -DSProject ${deployed.deploymentDSProject} -DSXFile $DSX_FILE ${deployed.container.deploymentOptions}

  if [ $? -eq 0 ] ; then
    echo "Removing $DSX_FILE"
    rm -f $DSX_FILE
  fi

done

# ERROR CHECKING
# Items not imported = >0

#	THIS IS HOW THE SCRIPT IS NORMALLY CALLED
#/opt/IBM/InformationServer/ASBNode/bin/DSXImportService.sh
#-ISAuthFile /opt/IBM/InformationServer/properties/authfile.txt
#-DSProject dstage1
#-DSXFile /home/dsadm/deploy/dstage1.dsx
#-Overwrite
#-Verbose  > /ETL_FILES/dstage1/joblogs/dstage1.dsx.import.log
