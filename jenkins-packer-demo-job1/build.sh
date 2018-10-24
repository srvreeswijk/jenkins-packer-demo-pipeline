#!/bin/bash
echo "we starten het build script"
packer build -machine-readable packer-example.json | tee build.log
AMI_ID=`grep -oPe 'ami-.+(?=\\n)' build.log |tail -n1`
echo 'variable "APP_INSTANCE_AMI" { default = "'${AMI_ID}'" }' > amivar.tf
cat amivar.tf
# we copy the amivar.tf to s3 for part2 of this demo. It will use it to start the app. 
aws s3 cp amivar.tf s3://terraform-state-a2b634h/packer-demo/amivar.tf
