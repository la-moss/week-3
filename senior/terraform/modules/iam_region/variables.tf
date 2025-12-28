variable "name_prefix" {
  type        = string
  description = "Prefix for resource naming."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "role_name" {
  type        = string
  description = "Custom role display name."
}

variable "principal_oid" {
  type        = string
  description = "Object ID of the principal to assign the role to."
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply."
}
