 [CmdletBinding()]
Param(
   [Parameter(Mandatory=$True)]
   [string] $HostName 
)

$HostsFilePath = "$($Env:WinDir)\system32\Drivers\etc\hosts"
   
$HostsFile = Get-Content $HostsFilePath
if($HostsFile -match [Regex]::Escape($HostName)){
    Write-host "$HostName found in $HostsFilePath"
}else{
    Write-host "$HostName NOT found in $HostsFilePath"
}
