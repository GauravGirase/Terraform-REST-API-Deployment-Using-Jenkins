variable "vpc_cidr" {
    description = "CIDR Range For VPC"
}

variable "vpc_name" {
    description = "VPC Name"
}

variable "cidr_public_subnet" {
    description = "CIDR For Public Subnet"

}

variable "cidr_private_subnet" {
    description = "CIDR For Private Subnet"
}

variable "ap_availability_zone" {
    description = "AZs"
}