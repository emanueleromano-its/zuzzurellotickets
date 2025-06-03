variable "ARM_client_id" {
  description = "ID del client ARM"
  type        = string
  default = "" # Modifica questo valore con il tuo ID client ARM
}

variable "ARM_client_secret" {
  description = "Segreto del client ARM"
  type        = string
  default = "" # Modifica questo valore con il tuo segreto client ARM
}

variable "ARM_tenant_id" {
  description = "ID del tenant ARM"
  type        = string
  default = "" # Modifica questo valore con il tuo ID tenant ARM
}

variable "ARM_subscription_id" {
  description = "ID della sottoscrizione ARM"
  type        = string
  default = "" # Modifica questo valore con il tuo ID di sottoscrizione ARM
}