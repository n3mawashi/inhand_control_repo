# Install puppetlabs-bolt

if (-not(Test-Path -Path "C:\Windows\Temp\puppet-bolt-x64-latest.msi" -PathType Leaf)) {
  try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    url = "https://downloads.puppet.com/windows/puppet-tools/puppet-bolt-x64-latest.msi?_ga=2.80437847.1941147604.1640514065-354979957.1564620083"
    (New-Object System.Net.WebClient).DownloadFile($url, "$env:TEMP\puppet-bolt-x64-latest.msi")
  }
  catch {
    throw $_.Exception.Message
  }
 }
else {
  msiexec /qn /i C:\Windows\Temp\puppet-bolt-x64-latest.msi /log C:\Windows\Temp\puppetlabs-bolt.log
}
