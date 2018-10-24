#!/bin/bash
packer build -machine-readable packer-example.json | tee build.log
if [ $? > 0 ];then echo "the packer command has failed";exit 1;fi
AMI_ID=`grep -oPe 'ami-.+(?=\\n)' build.log |tail -n1`
echo 'variable "APP_INSTANCE_AMI" { default = "'${AMI_ID}'" }' > amivar.tf
terraform init
terraform apply
