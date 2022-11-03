variable "name" {
  type = string
}

variable "allocation_method" {
  type = string
}

variable "sku" {
  type = string
}

variable "zones" {
  type = list(string)
}
