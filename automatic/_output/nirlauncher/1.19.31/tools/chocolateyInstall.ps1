$packageName = 'nirlauncher'
$url = 'http://download.nirsoft.net/nirsoft_package_1.19.31.zip'
$checksum = '169e7fd869b0f0f3e325ced1cc0857aa6ec62f6e'
$checksumType = 'sha1'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installFile = Join-Path $toolsDir "$($packageName).exe"

$chocTempDir = Join-Path $Env:Temp "chocolatey"
$tempDir = Join-Path $chocTempDir "$packageName"
if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}
$zipFile = Join-Path $tempDir "$($packageName).zip"

$referer = "http://launcher.nirsoft.net/download.html"
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("Referer", $referer)
$wc.DownloadFile($url, $zipFile)

Get-ChecksumValid -File "$zipFile" `
                  -Checksum "$checksum" `
                  -ChecksumType "$checksumType"

Get-ChocolateyUnzip -FileFullPath "$zipFile" `
                    -Destination "$toolsDir" `
                    -PackageName "$packageName"

Set-Content -Path ("$installFile.gui") `
            -Value $null