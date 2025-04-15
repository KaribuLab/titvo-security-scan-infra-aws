variable "service_name" {
  description = "Nombre del servicio que se usará para formar el nombre del rol y la política"
  type        = string
}

variable "role_description" {
  description = "Descripción del rol IAM"
  type        = string
  default     = ""
}

variable "role_policy_json" {
  description = "Documento de política de confianza en formato JSON que define quién puede asumir este rol"
  type        = string
}

variable "policy_description" {
  description = "Descripción de la política IAM"
  type        = string
  default     = ""
}

variable "policy_json" {
  description = "Documento de política en formato JSON que define los permisos del rol"
  type        = string
}


variable "tags" {
  description = "Mapa de etiquetas a asignar al rol y la política"
  type        = map(string)
}
