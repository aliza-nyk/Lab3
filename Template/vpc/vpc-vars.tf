variable "vpc_type" {
  description = "Type of VPC to create"
}

variable "blue_cidr" {
  type = string
  default = "100.64.0.0/16"
}

variable "green_cidr" {
  type = string
  default = "192.168.0.0/16"
}

variable "blue_cidr_blocks" {
    type = list(string)
    default = [ "100.64.1.0/24", "100.64.2.0/24", "100.64.3.0/24"]
  
}

variable "green_cidr_blocks" {
    type = list(string)
    default = [ "192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  
}

variable "availability_zones"{
    type = list(string)
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}