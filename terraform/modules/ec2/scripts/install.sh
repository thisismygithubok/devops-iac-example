#!/bin/bash

# exit if any command fails so instance launch not successful
set -e

# install ansible and git
dnf install ansible git -y

# clone repo
git clone https://github.com/thisismygithubok/tmgm-devops-challenge.git /tmp/git

# run cloudwatch agent install playbook
ansible-playbook /tmp/git/ansible-playbooks/cloudwatch-agent.yml

# run webserver install playbook
ansible-playbook /tmp/git/ansible-playbooks/webserver-install.yml