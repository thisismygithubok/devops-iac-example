# TMGM DevOps Challenge v3
This is the necessary terraform for the TMGM DevOps Challenge v3

## Terraform
This is written in a way where infrastructure is grouped into modules for easy management and reusability.
- **./modules/\*** - contains all modules needed to deploy the infra for this publicly accessible, highly secure, high-availability web service.
- **./providers.tf** - The AWS and TLS providers needed for these deployments.
- **./versions.tf** - The required provider source/versions and terraform version.
- **./main.tf** - The main terraform file being applied - utilises modules for easy readability and maintenance.
- **./variables.tf** - Any repeated static variables that would likely change between environments - can be "managed" via .tfvars files per environment.
- **./locals.tf** - Any repeated static variables that would likely **NOT** change between environments.

### Terraform Modules
- **vpc** - Creates the VPC, subnets, IGW, and the RT.
- **security-groups** - Creates the Public/Private SGs and their respective ingress/egress rules.
- **acm** - Uses TLS for generating the private key & self signed cert - import to ACM.
- **alb** - Creates the public ALB, TG, and both listeners.
- **route53** - Creates the R53 hosted zone and both alias records.
- **ec2** - Grabs the latest AWS Linux 2023 AMI, launch template, and ASG.