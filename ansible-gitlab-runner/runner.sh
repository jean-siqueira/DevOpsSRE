#!/bin/bash
cd /home/cleber/Coffeeandit/Projetos/FullStack/ansible-gitlab-runner
ls
ansible-playbook -i inventory.cfg runner_shell_install.yml -b --private-key /home/cleber/Coffeeandit/Projetos/FullStack/aws/terraform/ec2/id_rsa -u ubuntu
ansible-playbook -i inventory.cfg aws-cli_install.yml -b --private-key /home/cleber/Coffeeandit/Projetos/FullStack/aws/terraform/ec2/id_rsa -u ubuntu
ansible-playbook -i inventory.cfg aws-configure.yml -b --private-key /home/cleber/Coffeeandit/Projetos/FullStack/aws/terraform/ec2/id_rsa -u ubuntu
ansible-playbook -i inventory.cfg kubectl_install.yml -b --private-key /home/cleber/Coffeeandit/Projetos/FullStack/aws/terraform/ec2/id_rsa -u ubuntu
ansible-playbook -i inventory.cfg kubeconfig_install.yml -b --private-key /home/cleber/Coffeeandit/Projetos/FullStack/aws/terraform/ec2/id_rsa -u ubuntu