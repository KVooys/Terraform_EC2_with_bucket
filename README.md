# EC2 with bucket access

When experimenting with new cloud tech, a common use case is that you want a compute instance to store some of its data inside a bucket. That way, you can re-use this data easily when you use or build another instance. At the same time, you don't want the EC2 instance to be able to access other buckets, and you don't want all other instances to access the data bucket. 

Therefore I've created a Terraform module that creates one EC2 instance with access to only a specified S3 bucket.

Prerequisites:
- [Terraform >= 0.11](https://github.com/hashicorp/terraform)
- AWS account credentials with EC2, S3 and IAM rights

Use cases:
- Experimenting with new tools using different instance sizes for performance
- Using a bucket to share common configs between instances (ie. YAML files for operational tools, Dockerfiles, Ansible playbooks)
- Quickly recreate instances using setup files stored in a bucket

Setup:
```bash
# Clone this repository and run commands within this directory
# Be aware that the bucket ID must be unique within your region.

terraform init
terraform apply --var 'bucket_id=$IDHERE'  
```
