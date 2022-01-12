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
  [ValidateSet('Hyper-V','Hyper-V-Tools','Hyper-V-Powershell')]
  [String[]]$Roles,

  [Parameter(Mandatory = $False,
    ParameterSetName="IncludeSubFeatures")]
  [Boolean[]]$IncSF = $false,

  [Parameter(Mandatory = $False,
    ParameterSetName="IncludeTools")]
  [Boolean[]]$IncTools = $false,


  [Parameter(Mandatory = $False,
    ParameterSetName="RestartAllowed")]
  [Boolean[]]$restart = $false,

  [Parameter(Mandatory = $False)]
  [Switch]$NoOperation = $false

)
begin {
  $IsAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator" )
  $ProductType = (Get-ComputerInfo).OsProductType

  If (-not ($IsAdmin)) {
    Write-Warning "You do not have Administrator rights to run this script!\nPlease re-run this script as an Administrator!"
  }
  if (-not ($ProductType -match "Server")) {
    Write-Warning "System $env:ComputerName does not have a Server OS installed!\nPlease run this script on a system with Windows Server 2016 and greater"
  }
}
process {
  if($PSCmdlet.ShouldProcess($env:Computername, "Installing Roles of: $Roles with subfeatures being: $IncludeSF, with Tools being: $Intools and restart being: $Restart")){
    if (-Not($NoOperation -or $Roles)) {
      try {
        Install-WindowsFeature $Roles -IncludeAllSubFeature:$IncSF -IncludeManagementTools:$IncTools -Restart:$restart -Whatif:$NoOperation
      }
      catch {
        throw $_
      }
    }
  }
}
end {
  $checkRoles = (Get-WindowsFeature | rd*)
  Write-Output "The following roles have being installed: $checkRoles"
}
