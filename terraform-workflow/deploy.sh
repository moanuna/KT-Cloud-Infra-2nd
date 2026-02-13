#!/bin/bash

cd "$(dirname "$0")"

ENV=$1
ACTION=$2

cd "environments/$ENV"

case $ACTION in
  plan)
    terraform init
    terraform plan -var-file="terraform.tfvars"
    ;;
  
  apply)
    terraform init
    terraform apply -auto-approve -var-file="terraform.tfvars"
    ;;

  destroy)
    terraform destroy -auto-approve -var-file="terraform.tfvars"
    ;;

  *)
    echo "Usage: $0 {dev|stage|prod} {plan|apply|destroy}"
    exit 1
    ;;
esac
