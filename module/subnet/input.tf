variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "description" {
  type        = string
  description = "The description for the subnet"
}

variable "subnets" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
  }))
  description = "The subnets for the VPC"
}

variable "tags" {
  type        = map(string)
  description = "The tags for the subnet"
}
