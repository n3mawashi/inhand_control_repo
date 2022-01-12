# Change hyper-v default VM path to a converged path

[CmdletBinding()]
Param(
  [Parameter(Mandatory,
    ParameterSetName="Path")]
  [String[]]$Path,

  [Parameter(ParameterSetName="CreatePath")]
  [Switch[]]$createPath
)
begin {}

process {
  if ( $createPath -and !(Test-Path -Path $Path -PathType Leaf)) {
    try {
      New-Item -ItemType Directory -Force -Path $Path
    }
    catch {
      throw $_.Exception.Message
    }
  } else {
  # if($PSCmdlet.ShouldProcess("Set-VMHost", "Writing TestString '$TestString'")){
  #         Write-Output "Test string: $TestString"
  #       }
  #
    Set-VMHost -VirtualHardDiskPath "$Path\Virtual Hard Disks" -VirtualMachinePath "$Path\Virtual Machines"
  }
}
