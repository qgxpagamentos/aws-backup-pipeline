clear
export TF_LOG=TRACE
rm -rf .terraform
terraform init
terraform plan
