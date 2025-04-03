variable "bucket_name" {
  description = "Nombre del bucket S3 para subida de archivos"
  type        = string
}

variable "common_tags" {
  description = "Etiquetas comunes para aplicar a los recursos"
  type        = map(string)
  default     = {}
}

variable "allowed_origins" {
  description = "Lista de orígenes permitidos para CORS"
  type        = list(string)
  default     = null
}

variable "enable_lifecycle_rules" {
  description = "Habilita reglas de ciclo de vida para el bucket"
  type        = bool
  default     = false
}

variable "temp_file_expiration_days" {
  description = "Número de días antes de eliminar archivos temporales"
  type        = number
  default     = null
}

variable "cors_max_age_seconds" {
  description = "Tiempo máximo (en segundos) que los navegadores pueden cachear los resultados de una solicitud CORS"
  type        = number
  default     = 3000
}

variable "temp_files_prefix" {
  description = "Prefijo para los archivos temporales que serán afectados por la regla de expiración"
  type        = string
  default     = "temp/"
} 