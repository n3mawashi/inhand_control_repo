# variable "domain" {
#   description = "AD domain"
#   type        = string
# }
#
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

variable "vmpath" {
  description = "Absolute path for virtual machine"
  type        = string
  default     = "D:\\Hyper-V\\Virtual Machines\\"
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
  default     = "34359738368"
}

variable "template" {
  description = "TS Guest template image"
  type        = string
}

variable "ts_vhd_size02" {
  description = "TS Guest second drive size"
  type        = string
  default     = "536870912000" # 500G
}
