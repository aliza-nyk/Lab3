variable "ami" {
    type = string
    default = "ami-07dc835d76f1c56bc"
  
}

variable "chassis" {
    type = string
    default = "t2.micro"
}

data "aws_ami" "ami_img" {
  owners = ["458704138567"]
  filter {
    name   = "name"
    values = ["lab3"]
  }
}

variable "sg-id" { }
variable "subnet" {}
variable "vpc_id" {}