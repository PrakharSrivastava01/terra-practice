resource "aws_key_pair" "my_key" {
    key_name = "my_key"
    public_key = file("terra-for-practice.pub")
}
resource "aws_default_vpc" "project-vpc" {
    tags = {
        Name = "project-vpc"
    }
}
resource "aws_security_group" "my-project-security-group" {
    name = "Project-SG"
    description = "an automated sceurity group for mumbai region"
    vpc_id = aws_default_vpc.project-vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        description = "This is Port Open for SSH" 
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        description = "This is Port Open for HTTP"
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "This is open for all out-bound requests"
    }
}
resource "aws_instance" "project-instance" {
    for_each = {
        ansible-master = {
            instance_type = var.ansible_instance_type
            disk_size = var.ansible_disk_size
        }
        ansible-slave-1 = {
            instance_type = var.ansible_instance_type
            disk_size = var.ansible_disk_size
        }
        ansible-slave-2 = {
            instance_type = var.ansible_instance_type
            disk_size = var.ansible_disk_size
        }
        jenkins-master = {
            instance_type = var.jenkins_instance_type
            disk_size = var.jenkins_disk_size
        }
        jenkins-slave-1 = {
            instance_type = var.jenkins_instance_type
            disk_size = var.jenkins_disk_size
        }
        jenkins-slave-2 = {
            instance_type = var.jenkins_instance_type
            disk_size = var.jenkins_disk_size
        }
    }
    ami = var.ami-id
    instance_type = each.value.instance_type
    key_name = aws_key_pair.my_key.key_name
    vpc_security_group_ids  = [aws_security_group.my-project-security-group.id]
    root_block_device {
      volume_size = 10
      volume_type = "gp2"
      delete_on_termination = "true"
    }
    tags = {
        Name = "each.key"
}
}
