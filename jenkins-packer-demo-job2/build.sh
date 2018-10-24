#!/bin/bash
aws s3 cp s3://terraform-state-a2b634h/packer-demo/amivar.tf amivar.tf
touch mykey
touch mykey.pub
terraform init
terraform plan -var APP_INSTANCE_COUNT=1 -target aws_instance.app-instance
terraform apply -auto-approve -var APP_INSTANCE_COUNT=1 -target aws_instance.app-instance
