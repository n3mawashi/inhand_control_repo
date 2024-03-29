variable "domain" {
  description = "AD domain"
  type        = string
  default     = "EXAMPLE"
}

variable "username" {
  description = "AD/hyperv administrator password"
  type        = string
  default     = "Administrator"
}

variable "password" {
  description = "AD/hyperv administrator password"
  type        = string
  sensitive   = true
}

variable "winrm_username" {
  description = "guest administrator password"
  type        = string
  default     = "vagrant"
}

variable "winrm_password" {
  description = "guest administrator password"
  type        = string
  sensitive   = true
  default     = "vagrant"
}


variable "vmpath" {
  description = "Absolute path for virtual machine"
  type        = string
  default     = "D:\\Hyper-V"
}

variable "vswitch_name" {
  description = "Hyperv virtual switch name"
  type        = string
}

variable "ts_hostname" {
  description = "TS Guest hostname"
  type        = string
}

variable "ts_ram" {
  description = "TS Guest RAM size"
  type        = string
  default     = "34359738368" #32Gb
}

variable "template" {
  description = "TS Guest template image"
  type        = string
}

variable "ts_vhd_size02" {
  description = "TS Guest second drive size"
  type        = string
  default     = "549755813888" # 500G
}
