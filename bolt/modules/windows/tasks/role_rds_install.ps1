<#
#Requires -RunAsAdministrator -Version 5.1
.SYNOPSIS
Install Hyper-V roles on windows servers.
.TODO:
Check server vs desktop
check not core.
Check running as admin
Which role - subroles, tools, addons
Parse error in catch so it can be fed back to bolt via JSON
assumptions:
#>

[CmdletBinding(SupportsShouldProcess)]
Param(
  [Parameter(Mandatory,
    ParameterSetName="Roles")]
  [ValidateSet('Remote-Desktop-Services','RDS-Connection-Broker','RDS-Gateway','RDS-Licensing','RDS-RD-Server','RDS-Virtualization','RDS-Web-Access')]
  [String[]]$Roles,

  [Parameter(Mandatory = $False,
    ParameterSetName="IncludeSubFeatures")]
  [Boolean]$IncludeSubFeatures = $false,

  [Parameter(Mandatory = $False,
    ParameterSetName="IncludeTools")]
  [Boolean]$IncludeTools = $false,

  [Parameter(Mandatory = $False,
    ParameterSetName="Restart")]
  [Boolean]$Restart = $false,

  [Parameter(Mandatory = $False)]
  [Switch]$NoOperation = $false

)
begin {
  $IsAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator" )
  $IsServer = (Get-ComputerInfo).OsProductType

  If (-not ($IsAdmin)) {
    Write-Warning "You do not have Administrator rights to run this script! `Please re-run this script as an Administrator!"
  }
  if (-not ($IsServer -match "Server")) {
    Write-Warning "System $env:ComputerName does not have a Server OS installed! `Please run this script on a system with Windows Server 2016 and greater"
  }
}
process {
  if($PSCmdlet.ShouldProcess($env:Computername, "Installing Roles of: $Roles with subfeatures being: $IncludeSubFeatures, with Tools being: $Includetools and restart being: $Restart")){
    if (-Not($NoOperation -or $Roles)) {
      try {
        Install-WindowsFeature $Roles -IncludeAllSubFeature:$IncludeSubFeatures -IncludeManagementTools:$IncludeTools -Restart:$restart -Whatif:$NoOperation
      }
      catch {
        throw $_
      }
    }
  }
}
end {
  $checkRoles = (Get-WindowsFeature $Roles)
  Write-Output "The following roles have being installed: $checkRoles"
}
