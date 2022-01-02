# source https://github.com/taliesins/terraform-provider-hyperv/blob/master/examples/vm-from-scratch/main.tf
terraform {
  required_providers {
    hyperv = {
      version = "1.0.3"
      source  = "registry.terraform.io/taliesins/hyperv"
    }
    # windowsnetwork = {
    #   version = "0.2"
    #   source  = "github.com/claudusd/terraform-windows-network"
    # }
  }
}

provider "hyperv" {
  user     = var.username
  password = var.password
}

# provider "windowsnetwork" {
#    host = <ad_system>
#    port = "5986"
#    endpoint = "wsman"
#    username = ""
#    password = ""
# }

# This should likely go in bolt configuration
# resource "hyperv_network_switch" "network_switch" {
#   name = var.vswitch_name
#   switch_type = external
# }

#Primary disk
resource "hyperv_vhd" "ts_hostname-vhdx-01" {
  source = var.template
  path   = "${var.vmpath}${var.ts_hostname}\\Virtual Disks\\" #Needs to be absolute path
}
#secondary disk
resource "hyperv_vhd" "ts_hostname-vhdx-02" {
  path = "${var.vmpath}${var.ts_hostname}\\Virtual Disks\\" #Needs to be absolute path
  size = var.ts_vhd_size02
}

resource "hyperv_machine_instance" "ts_host" {
  name                   = var.ts_hostname
  generation             = 1
  processor_count        = 4
  static_memory          = true
  memory_startup_bytes   = var.ts_ram #32Gb
  wait_for_state_timeout = 10
  wait_for_ips_timeout   = 10
  automatic_start_action = "StartIfRunning"
  automatic_start_delay  = 0
  automatic_stop_action  = "Save"
  checkpoint_type        = "Production"

  vm_processor {
    expose_virtualization_extensions = true
  }

  integration_services = {
    Shutdown = true
    VSS      = true
  }

  network_adaptors {
    name         = "lan"
    switch_name  = var.vswitch_name
    wait_for_ips = false
  }

  hard_disk_drives {
    controller_type           = "Scsi"
    path                      = "hyperv_vhd.ts_hostname-vhdx-02.path"
    controller_number         = 0
    controller_location       = 0
    override_cache_attributes = "WriteCacheEnabled"
  }

  hard_disk_drives {
    controller_type           = "Scsi"
    path                      = "hyperv_vhd.ts_hostname-vhdx-02.path"
    controller_number         = 0
    controller_location       = 1
    override_cache_attributes = "WriteCacheEnabled"

  }

  dvd_drives {
    controller_number   = 1
    controller_location = 0
    #path = "ubuntu.iso"
  }
}
