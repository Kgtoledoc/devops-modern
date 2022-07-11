variable "client_secret" {
  type        = string
  description = "Client Secret"
}

variable "rg_name" {
  type        = string
  description = "The resource group name"
  default     = "test"
}
variable "rg_location" {
  type        = string
  description = "The resource group location"
  default     = "australiaeast"
}

variable "admin_password" {
  type        = string
  description = "Admin password"
}
variable "admin_username" {
  type        = string
  description = "Admin user"
}