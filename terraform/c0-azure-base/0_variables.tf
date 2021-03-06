///////////////////////////////////////////////
//////// Pivotal Customer[0] //////////////////
//////// Set Azure Variables //////////////////
///////////////////////////////////////////////

variable "env_name" {}

variable "env_short_name" {
  description = "Used for creating storage accounts. Must be a-z only, no longer than 10 characters"
}

variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "location" {}

variable "dns_suffix" {}

variable "pub_ip_opsman" {}
variable "pub_ip_id_opsman" {}

variable "pub_ip_pcf" {}
variable "pub_ip_id_pcf" {}

variable "pub_ip_tcp" {}
variable "pub_ip_id_tcp_lb" {}

variable "ops_manager_image_uri" {}
variable "vm_admin_username" {}
variable "vm_admin_password" {}
variable "vm_admin_public_key" {}
