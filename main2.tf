resource "aws_key_pair" "my_key" {
  key_name   = "my_key"
  public_key = file("terra-for-practice.pub")
}

resource "aws_default_vpc" "project-vpc01" {
  tags = {
    Name = "project-vpc01"
  }
}

resource "aws_security_group" "my_project_security_group" {
  name        = "project-sg"
  description = "an automated security group for mumbai region"
  vpc_id      = aws_default_vpc.project-vpc01.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "This is Port Open for SSH"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "This is Port Open for HTTP"
  }
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "This is Port Open for HTTP/HTTPS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "This is open for all outbound requests"
  }
}

resource "aws_instance" "project_instance" {
  for_each = tomap({
    ansible-master  = var.ansible_instance_type
    ansible-slave-1 = var.ansible_instance_type
    ansible-slave-2 = var.ansible_instance_type
    jenkins-master  = var.jenkins_instance_type
    jenkins-slave-1 = var.jenkins_instance_type
    jenkins-slave-2 = var.jenkins_instance_type
  })

  ami           = var.ami-id
  instance_type = each.value
  key_name      = aws_key_pair.my_key.key_name

  vpc_security_group_ids = [aws_security_group.my_project_security_group.id]

  root_block_device {
    volume_size           = 10
    volume_type           = "gp2"
    delete_on_termination = true
  }

  user_data = file(
    each.key == "jenkins-master" ? "install_jenkins.sh" :
    each.key == "ansible-master" ? "install_ansible.sh" :
    "base_setup.sh"
  )

  tags = {
    Name = each.key
  }
}
