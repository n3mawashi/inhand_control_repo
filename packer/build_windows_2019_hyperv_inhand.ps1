$output_dir = 'D:\Templates\windows_2019_hyperv-iso'

if (Test-Path $output_dir) {
  Remove-Item -Recurse -Force $output_dir
}

packer build --only=hyperv-iso `
  -var hyperv_switchname=mgmt `
  -var iso_url=..\..\ISOs\2019_SERVER_EVAL_x64FRE_en-us.iso `
  -var iso_checksum='none' `
  -var output_directory=$output_dir
  windows_2019_hyperv_inhand.json
