# Powershell
# install chocolatey from powershell

[CmdletBinding(SupportsShouldProcess)]
Param(
  [Parameter(ParameterSetName="InstallScript")]
  [String[]]$InstallScript
)
begin {
  if (-not($InstallScript)) {
    $InstallScript = 'https://community.chocolatey.org/install.ps1'
  }
  $webClient = New-Object System.Net.WebClient
  $filename = "'env:%TEMP%'\choco-install.ps1"
}

process {
  if($PSCmdlet.ShouldProcess("$env:Computername", 'Install chocolatey using $InstallScript')){
    try {
      Set-ExecutionPolicy Bypass -Scope Process -Force
      [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
      Add-Content -Path $filename -Value $webClient.DownloadString($InstallScript)
      Invoke-Command -FilePath $filename
    } catch {
      throw $_.Exception.Message
    }
  }
}
end {
    Write-Verbose "Chocolatey install Complete!"
}
