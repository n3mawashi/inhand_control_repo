# powershell
<#
Objective: Stand up an rds instance on hyperV server
TODO:
1. encrypt secrets using eyaml-gpg
2. convert to bolt plan
3. write UAT tests inspec
3. take over hte world
#>
iso_dir = D:\ISO\
packer_output_dir = D:\Templates\windows_2019_hyperv-iso

# 1. run bolt tasks/plan to confirm hyper is install/setup as we expect
bolt task run windows::hyperv_install --target hvserver
bolt task run windows::hyperv_configure --target hvserver

# 2. Create image with installation and inital configuration done
# Gen 2 impage needs an additional step
#./packer/make_unattend_iso.ps1

if (-not (test-item -path $packer_out_dir)) {
  Remove-Item -Recurse -Force $packer_out_dir
}
#packer validate
packer build --only=hyperv-iso `
  -var hyperv_switchname=mgmt `
  -var iso_url=..\..\ISOs\2019_SERVER_EVAL_x64FRE_en-us.iso `
  -var iso_checksum='none' `
  -var output_directory=$packer_output_dir `
  windows_2019_hyperv_inhand.json

# 3. Run terraform apply to create VM and import packer image.
terraform init
terraform plan `
  -var vswitch_name="mgmt" `
  -var ts_hostname="TMS-S-RDS01" `
  -var vmpath="D:\\Hyper-V\\Virtual Machines\\" `
  -var template="D:\\Templates\\windows_2019_hyperv.box"

# 3.a because terraform
# 4. Run bolt to configure RDS server further.

# 5. Run UAT tests in inspec
