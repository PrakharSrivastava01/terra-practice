🚀 Terraform Multi-Node Setup (Jenkins + Ansible)

This project provisions a multi-node infrastructure on AWS using Terraform.
It automatically installs Jenkins on the jenkins-master node, Ansible on the ansible-master node, and sets up base tools on all slave nodes.

📌 Infrastructure Overview

VPC: Default AWS VPC

Security Group: Opens ports:

22 → SSH

80 → HTTP

8080 → Jenkins (inside script, Jenkins runs on this port)

Key Pair: SSH key for accessing instances

Instances (created with for_each):

jenkins-master → Jenkins installed & running

jenkins-slave-1, jenkins-slave-2 → Base setup (tools only)

ansible-master → Ansible installed

ansible-slave-1, ansible-slave-2 → Base setup (tools only)

⚙️ How It Works

Terraform uses for_each to create multiple EC2 instances from a map.

Each instance gets a different user_data script depending on its role (jenkins-master, ansible-master, or slaves).

Scripts are executed on first boot using cloud-init.

 📂 Project Structure
 
  ├── main.tf                # Main Terraform configuration
  ├── variables.tf           # Input variables (AMI ID, instance types, etc.)  
  ├── install_jenkins.sh     # Installs Jenkins + Java
  ├── install_ansible.sh     # Installs Ansible
  ├── base_setup.sh          # Installs common tools (git, curl, unzip)
  └── README.md              # Documentation




  



