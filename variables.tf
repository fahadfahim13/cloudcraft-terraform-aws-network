variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-2"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr1" {
  description = "Public Subnet CIDR block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr2" {
  description = "Public Subnet CIDR block"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr1" {
  description = "Private Subnet CIDR block"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_cidr2" {
  description = "Private Subnet CIDR block"
  type        = string
  default     = "10.0.4.0/24"
}

variable "private_subnet_cidr3" {
  description = "Private Subnet CIDR block"
  type        = string
  default     = "10.0.5.0/24"
}

variable "private_subnet_cidr4" {
  description = "Private Subnet CIDR block"
  type        = string
  default     = "10.0.6.0/24"
}

