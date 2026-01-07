variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "ec2-instance-key"
  type        = string
  default     = "ec2-instance-key" 
}

variable "admin_ip" {
  description = "Admin public IP allowed to SSH into EC2"
  type        = string
}


