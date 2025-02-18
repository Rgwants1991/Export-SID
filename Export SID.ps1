[CmdletBinding()]
param()

$sidFilePath = Join-Path $env:USERPROFILE "Downloads\Sid.txt"

$whoamiOutput = whoami /user

$lines = $whoamiOutput -split "`r?`n"

$filtered = $lines | Where-Object { $_ -match 'S-1-5-' }

if ($filtered) {
    $parts = $filtered -split '\s+'
    $sid   = $parts[-1]

    Set-Content -Path $sidFilePath -Value $sid
    Write-Host "User SID has been written to: $sidFilePath"
    Write-Host "SID: $sid"
}
else {
    Write-Host "Could not parse a valid SID from 'whoami /user'."
}
