# TMGM DevOps Challenge v3
This is the necessary terraform for the TMGM DevOps Challenge v3

## Basic Goals

### Terraform Code
This is written in a way where infrastructure is grouped into modules for easy management and reusability.
- **./modules/\*** - contains all modules needed to deploy the infra for this publicly accessible, highly secure, high-availability web service.
- **./envs/\*** - contains prod.tfvars file for deployment. Can easily add other envs.
- **./providers.tf** - The AWS and TLS providers needed for these deployments.
- **./versions.tf** - The required provider source/versions and terraform version.
- **./main.tf** - The main terraform file being applied - utilises modules for easy readability and maintenance.
- **./variables.tf** - Any repeated static variables that would likely change between environments - can be "managed" via .tfvars files per environment.
- **./locals.tf** - Any repeated static variables that would likely **NOT** change between environments.

### TF Modules
- **vpc** - Creates the VPC, subnets, IGW, and the private RT. This also creates NAT gateways, RTs, and assocations for the private subnets for the EC2 instances to be able to install packages and deploy the ansible playbook.
- **security-groups** - Creates the Public/Private SGs and their respective ingress/egress rules.
- **acm** - Uses TLS for generating the private key & self signed cert - import to ACM.
- **alb** - Creates the public ALB, TG, and both listeners.
- **route53** - Creates the R53 hosted zone and both alias records.
- **ec2** - Grabs the latest AWS Linux 2023 AMI, creates a launch template and ASG, and checks for the ASG service linked role.
    - Also contains a /scripts directory which contains the install.sh script used in the launch template for ansible install, repo clone, and playbook run.

### TF Vars
- Ideally you don't have tfvars files commited for secrets - but this is commited as it doesn't contain sensitive details and allowed easier deployment testing.

### Additional Info
- Profile of "terraform" was added into providers.tf as this is the aws profile I used to test my deployments.

## Additional Challenges

### Ansible Config Management
This utilises ansible to install an apache httpd webserver and then deploy a basic html webpage. Accomplishing this did require extending the VPC infra to include NAT gateways and RTs for the private subnets. This is so the EC2 instances had internet access to be able to run the install.sh script, clone the repo, and deploy the ansible playbook.
- **./ansible-playbooks/\*** - contains the ansible playbook used to install httpd and the basic webpage.
- **./ansible-playbooks/files/** - contains the basic index.html deployed to the httpd server.
