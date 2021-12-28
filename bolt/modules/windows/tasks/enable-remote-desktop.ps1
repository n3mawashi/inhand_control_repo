# https://github.com/StefanScherer/packer-windows
# Credit to Stefan Scherer
# TODO: add scope to  firewall rule down to just the local network/domain
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
