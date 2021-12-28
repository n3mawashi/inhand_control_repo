variable "ad_domain" {
  description = "AD domain"
  type        = string
}

variable "ad_username" {
  description = "AD/hyperv administrator password"
  type        = string
  default     = 'Administrator'
}

variable "ad_password" {
  description = "AD/hyperv administrator password"
  type        = string
  sensitive   = true
}

variable "vmpath" {
  description = "Absolute path for virtual machine"
  type        = string
}

variable "vmswtch_name" {
  description = "Hyperv virtual switch name"
  type        = string
}

variable "ts_name" {
  description = "Hyperv virtual switch name"
  type        = string
}

variable "ts_ram" {
  description = "Hyperv virtual switch name"
  type        = string
}

variable "ts_vhd_size01" {
  description = "Hyperv virtual switch name"
  type        = string
}

variable "ts_vhd_size02" {
  description = "Hyperv virtual switch name"
  type        = string
}
