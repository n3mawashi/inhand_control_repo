if (Test-Path ..\..\output-hyperv-iso) {
  Remove-Item -Recurse -Force ..\..\output-hyperv-iso
}

packer build --only=hyperv-iso `
  --var hyperv_switchname=mgmt
  --var iso_url=..\..\ISOs\2019_SERVER_EVAL_x64FRE_en-us.iso `
  --var iso_checksum="none" `
  windows_2019_hyperv_inhand.json
