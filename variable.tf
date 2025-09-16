variable "ami-id" {
    description = "This AMI used for EC2 Instance"
    default = "ami-02d26659fd82cf299"
    type = string
}
variable "ansible_instance_type" {
    description = "This is the type of EC2 Instance for Ansible instances"
    default = "t2.micro"
    type = string
}
variable "ansible_instance_count" {
    description = "This is the number of instances to create"
    default = 1
    type = number
}
variable "jenkins_instance_type" {
    description = "type of instances for Jenkins instances"
    default = "t2.medium"
    type = string
}
variable "jenkins_instance_count" {
    description = "This is the number of instances to create"
    default = 1
    type = number
}
variable "ansible_disk_size" {
    description = "Root disk size for Ansible instances (in GB)"
    type = number
    default = 20
}
variable "jenkins_disk_size" {
    description = "Root disk size for Jenkins instances (in GB)"
    type = number
    default = 15
}
