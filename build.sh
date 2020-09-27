#!/bin/bash

set -x
set -e

# Terraform
cd terraform
terraform init
terraform plan --var-file input.tfvars --out plan.tfplan
terraform apply plan.tfplan
cd ../
