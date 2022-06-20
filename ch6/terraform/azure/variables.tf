/* variable "subscription_id" {
  type        = string
  description = "The azure subscription id"
}
variable "client_id" {
  type        = string
  description = "The azure service principal appId"
}
variable "client_secret" {
  type        = string
  description = "The azure service principal password"
  sensitive   = true
}
variable "tenant_id" {
  type        = string
  description = "The azure tenant id"
} */
variable "rg_name" {
  type        = string
  description = "The resource group name"
  default     = "test"
}
variable "rg_location" {
  type        = string
  description = "The resource group location"
  default     = "eastus"
}