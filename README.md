# Overview

Ethan is a tool to measure your website performance from all AWS' Availability Zones.

Using terraform it will create an ec2 instance in all AZs and run http requests which then gathers in a central redis instance for further analysis.


## Usage
Starting the profiling:

```
export AWS_ACCESS_KEY_ID="xxx"
export AWS_SECRET_ACCESS_KEY="xxx"
export TF_VAR_test_host="example.com"
export TF_VAR_ssh_key=ssh-rsa AAAAB3N....."

terraform init terraform/aws
terraform apply terraform/aws
```

Once the benchmark is done you can throw away all the resources:

```
terraform destroy terraform/aws
```

