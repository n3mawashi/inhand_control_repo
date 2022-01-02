# Powershell
# install chocolatey from powershell

[CmdletBinding(SupportsShouldProcess=$True)]
Param(
  [Parameter(Mandatory = $False)]
  [String[]]$installScript,

  [Parameter(Mandatory = $False)]
  [Switch]$NoOperation
)
begin {

  if (-not($installScript)) {
    $installScript = 'https://community.chocolatey.org/install.ps1'
  }
  $tempfile = "$env:TEMP\choco-install.ps1"


  #discover if choocolatey is installed
  if ($env:ChocolateyInstall -and (Test-Path -Path $env:ChocolateyInstall)) {
    Write-verbose "Chocolatey detected"
    $chocoinstalled = $true
  }
}

process {
  if($PSCmdlet.ShouldProcess($env:Computername, "Install chocolatey using $installScript to $tempfile")){
    try {
      if (-Not($NoOperation -or $chocoinstalled)) {
        Write-Verbose 'Chocolatey installing and OP mode'
        Set-ExecutionPolicy Bypass -Scope Process -Force
        #force TLS1.2
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-WebRequest -Uri "$installScript" -OutFile "$tempfile" -ErrorAction Stop
        & $tempfile
      } elseif ($chocoinstalled) {
          Write-Verbose "$application installed already, No change"
      } else {
          Write-Verbose 'Noop Mode chosen, do nothing'
      }
    }
    catch {
      throw $_
    }
  }
}
end {
    #clean  up
    Remove-item $tempfile
    Write-Verbose 'Chocolatey install Complete!'
}
