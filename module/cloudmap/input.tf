variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to create the private DNS namespace in"
}

variable "namespace" {
  type        = string
  description = "The name of the private DNS namespace"
}

variable "description" {
  type        = string
  description = "The description of the private DNS namespace"
}

variable "tags" {
  type        = map(string)
  description = "The tags to apply to the private DNS namespace"
}