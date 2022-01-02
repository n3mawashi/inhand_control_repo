# Install puppetlabs-bolt
# TODO:
# Params for different url
# isAdmin check, otherwise UAC...
# credential handling if not isAdmin.

$VerbosePreference = "continue"

Write-Output "Puppetlabs Bolt installation...."
$installer = "$env:TEMP\puppet-bolt-x64-latest.msi"

if (-not(Test-Path -Path $installer -PathType Leaf)) {
  Write-Verbose "$installer not downloaded, downloading..."
  try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $url = 'https://downloads.puppet.com/windows/puppet-tools/puppet-bolt-x64-latest.msi?_ga=2.80437847.1941147604.1640514065-354979957.1564620083'
    Write-Verbose "Downloading from $url to $installer"
    Invoke-WebRequest -Uri $url -OutFile $installer -ErrorAction Stop
  }
  catch {
    throw $_.Exception
  }
}
try {
  Start-Process -FilePath $env:SYSTEMROOT\system32\msiexec.exe -ArgumentList "/qb /i $env:TEMP\puppet-bolt-x64-latest.msi /log $env:TEMP\puppetlabs-bolt.log" -wait -ErrorAction Stop
  Write-Output "Installation Sucessfull..Installed Powershell Addon"
  # seems to hang packer configuration
  #Install-Module PuppetBolt -Confirm:$False -Force -ErrorAction Stop
  #Write-Verbose "Installation of Powershell Addon Sucessful"
}
catch {
  throw $_.Exception
}
finally {
  #clean up after oneself,leaving log for additional troubleshooting
  Remove-Item $installer -Confirm:$False -Force
}

Write-Output "Puppetlabs Bolt installation...Done..See log at $env:TEMP\puppetlabs-bolt.log"
