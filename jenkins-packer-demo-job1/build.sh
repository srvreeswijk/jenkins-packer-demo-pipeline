#!/bin/bash
echo "we starten het build script"
pwd
ARTIFACT=`packer build -machine-readable packer-demo.json |awk -F, '$0 ~/artifact,0,id/ {print $6}'`
AMI_ID=`echo $ARTIFACT | cut -d ':' -f2`
echo 'variable "APP_INSTANCE_AMI" { default = "'${AMI_ID}'" }' > amivar.tf
# we copy the amivar.tf to s3 for part2 of this demo. It will use it to start the app. 
aws s3 cp amivar.tf s3://terraform-state-a2b634h/amivar.tf
