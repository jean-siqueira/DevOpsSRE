# Projeto responsável por criar uma instância de Gitlab-Runner com Ansible.

### Install Runner Docker Gitlab

ansible-playbook -i inventory.cfg runner_docker_install.yml -b --private-key /run/media/jean/806bddf9-c349-4840-9337-8d26125fb1e6/development/study/devops-sre/cursos/coffeeandit/repo/personal/DevOpsSRE/terraform/ec2/id_rsa_aws -u ubuntu

### Adiciona Runner Shell Gitlab

ansible-playbook -i inventory.cfg runner_shell_install.yml -b --private-key /run/media/jean/806bddf9-c349-4840-9337-8d26125fb1e6/development/study/devops-sre/cursos/coffeeandit/repo/personal/DevOpsSRE/terraform/ec2/id_rsa_aws -u ubuntu

### Install Kubectl Gitlab

ansible-playbook -i inventory.cfg kubectl_install.yml -b --private-key /run/media/jean/806bddf9-c349-4840-9337-8d26125fb1e6/development/study/devops-sre/cursos/coffeeandit/repo/personal/DevOpsSRE/terraform/ec2/id_rsa_aws -u ubuntu


### Install Cliente AWS

ansible-playbook -i inventory.cfg aws-cli_install.yml -b --private-key /run/media/jean/806bddf9-c349-4840-9337-8d26125fb1e6/development/study/devops-sre/cursos/coffeeandit/repo/personal/DevOpsSRE/terraform/ec2/id_rsa_aws -u ubuntu

### Configure AWS

ansible-playbook -i inventory.cfg aws-configure.yml -b --private-key /run/media/jean/806bddf9-c349-4840-9337-8d26125fb1e6/development/study/devops-sre/cursos/coffeeandit/repo/personal/DevOpsSRE/terraform/ec2/id_rsa_aws -u ubuntu


### Kube Config

ansible-playbook -i inventory.cfg kubeconfig_install.yml -b --private-key /run/media/jean/806bddf9-c349-4840-9337-8d26125fb1e6/development/study/devops-sre/cursos/coffeeandit/repo/personal/DevOpsSRE/terraform/ec2/id_rsa_aws -u ubuntu


