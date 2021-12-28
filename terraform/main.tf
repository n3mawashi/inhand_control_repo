# source https://github.com/taliesins/terraform-provider-hyperv/blob/master/examples/vm-from-scratch/main.tf
terraform {
  required_providers {
    hyperv = {
      version = "1.0.3"
      source = "registry.terraform.io/taliesins/hyperv"
    }
  }
}

provider "hyperv" {
	user     = "${var.ad_domain ? ".${var.env_name}" : "."}\${var.ad_username}"
	password = "${var.ad_password}"
}


# This should likely go in bolt configuration
#resource "hyperv_network_switch" "dmz_network_switch" {
resource "hyperv_network_switch" "${var.vswtch}" {

  name = "${var.vswtch_name}"
}

resource "hyperv_vhd" "${var.hostname}-vhd" {
  path = "${var.vmpath}-${var.hostname}" #Needs to be absolute path
  size = 10737418240 #10GB
}

resource "hyperv_machine_instance" "${var.hostname}" {
  name = "${var.hostname}"
  generation = 1
  processor_count = 2
  static_memory = true
  memory_startup_bytes = 536870912 #512MB
  wait_for_state_timeout = 10
  wait_for_ips_timeout = 10

  vm_processor {
    expose_virtualization_extensions = true
  }

  network_adaptors {
      name = "wan"
      switch_name = hyperv_network_switch.dmz_network_switch.name
      wait_for_ips = false
  }

  hard_disk_drives {
    controller_type = "Ide"
    path = hyperv_vhd.web_server_g1_vhd.path
    controller_number = 0
    controller_location = 0
  }

  dvd_drives {
    controller_number = 0
    controller_location = 1
    #path = "ubuntu.iso"
  }
}

resource "hyperv_vhd" "web_server_g2_vhd" {
  path = "c:\\vhdx\\web_server_g2.vhdx" #Needs to be absolute path
  size = 10737418240 #10GB
}

resource "hyperv_machine_instance" "web_server_g2" {
  name = "web_server_g2"
  generation = 2
  processor_count = 2
  static_memory = true
  memory_startup_bytes = 536870912 #512MB
  wait_for_state_timeout = 10
  wait_for_ips_timeout = 10

  vm_firmware {
    pause_after_boot_failure = "Off"
  }

  vm_processor {
    expose_virtualization_extensions = true
  }

  network_adaptors {
      name = "wan"
      switch_name = hyperv_network_switch.dmz_network_switch.name
      wait_for_ips = false
  }

  hard_disk_drives {
    path = hyperv_vhd.web_server_g2_vhd.path
    controller_number = 0
    controller_location = 0
  }

  dvd_drives {
    controller_number = 0
    controller_location = 1
    #path = "ubuntu.iso"
  }
}
