﻿$packageName = '{{PackageName}}'
$installerType = 'exe'
$silentArgs = '/install /quiet /norestart'
$url = '{{DownloadUrl}}'
$checksum = '{{Checksum}}'
$checksumType = 'sha256'
$validExitCodes = @(0)

$toolsPath = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$ahkFile = Join-Path $toolsPath 'chocolateyInstall.ahk'
Start-Process 'AutoHotKey' $ahkFile

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType"