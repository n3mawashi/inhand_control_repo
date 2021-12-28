# Change hyper-v default VM path to a converged path

[CmdletBinding()]
Param(
  [Parameter(Mandatory,
    ParameterSetName="Path")]
 [String[]]
  $Path
)

Set-VMHost -VirtualMachinePath $Path
