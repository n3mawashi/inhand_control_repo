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
packer_output_dir = D:\images\

# 1. run bolt tasks/plan to confirm hyper is install/setup as we expect
bolt task run hyperv::install --target hvserver
bolt task run hyperv::configure --target hvserver

# 2. Create image with installation and inital configuration done


# 3. Run terraform apply to create VM and import packer image.
# 3.a because terraform
# 4. Run bolt to configure RDS server further.

# 5. Run UAT tests in inspec
