variable "project" {
  type        = string
  description = "Project or service identifier used in naming."
  default     = "contoso-ops"
}

variable "environment" {
  type        = string
  description = "Environment name."
  default     = "prod"
}

variable "primary_location" {
  type        = string
  description = "Primary Azure region location."
  default     = "eastus"
}

variable "secondary_location" {
  type        = string
  description = "Secondary Azure region location."
  default     = "westeurope"
}

variable "tags" {
  type        = map(string)
  description = "Common resource tags."
  default = {
    Owner      = "platform-team"
    Env        = "prod"
    Project    = "contoso-ops"
    CostCenter = "cc-4102"
  }
}

variable "automation_principal_object_id" {
  type        = string
  description = "Object ID of the automation principal (service principal / managed identity principalId)."
  default     = "00000000-0000-0000-0000-000000000000"
}
