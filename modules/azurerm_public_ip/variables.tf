
variable "pip_name" {
	description = "The name of the Public IP address."
	type        = string
}

variable "rg_name" {
	description = "The name of the Resource Group."
	type        = string
}

variable "location" {
	description = "The Azure location where resources will be created."
	type        = string
}

variable "sku" {
	description = "The SKU of the Public IP address."
	type        = string
	default     = "Standard"
}

variable "tags" {
	description = "A map of tags to assign to the resource."
	type        = map(string)
	default     = {}
}
