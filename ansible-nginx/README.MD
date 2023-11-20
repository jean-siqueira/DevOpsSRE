# Projeto responsável por criar uma instância de NGINX com Ansible.

### Update Instance

ansible -i inventory.cfg web --private-key /run/media/jean/806bddf9-c349-4840-9337-8d26125fb1e6/development/study/devops-sre/cursos/coffeeandit/repo/personal/DevOpsSRE/terraform/ec2/id_rsa_aws -u ubuntu -a "sudo apt-get update"

### Install Nginx

ansible-playbook -i inventory.cfg nginx_install.yml -b --private-key /run/media/jean/806bddf9-c349-4840-9337-8d26125fb1e6/development/study/devops-sre/cursos/coffeeandit/repo/personal/DevOpsSRE/terraform/ec2/id_rsa_aws -u ubuntu

### Uninstall Nginx

ansible-playbook -i inventory.cfg nginx_uninstall.yml -b --private-key /home/cleber/Coffeeandit/Projetos/FullStack/aws/terraform/ec2/id_rsa -u ubuntu

### Install Balancer Nginx

ansible-playbook -i inventory.cfg nginx_install_balancer.yml -b --private-key /home/cleber/Coffeeandit/Projetos/FullStack/aws/terraform/ec2/id_rsa -u ubuntu
