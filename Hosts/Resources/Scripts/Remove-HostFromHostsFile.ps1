[CmdletBinding()]
Param(
   [Parameter(Mandatory=$True)]
   [string] $HostName 
)

$HostsFilePath = "$($Env:WinDir)\system32\Drivers\etc\hosts"

Function Test-HostinHostFile{
 Param ($HostName, $HostsFilePath)
   
    $HostsFile = Get-Content $HostsFilePath
    if($HostsFile -match [Regex]::Escape($HostName)){
        $true
    }else{
        $false
    }
}

if(Test-HostinHostFile -HostName $HostName -HostsFilePath $HostsFilePath){
    $HostsFile = Get-Content $HostsFilePath
    $HostsFile -notmatch ".*\s+$([Regex]::Escape($Hostname)).*" | Out-File $hostsFilePath 

}else{         
    Write-Host -Exception "$HostName not found in $HostsFilePath" 
}

$Pattern = '^(?<IP>\d{1,3}(\.\d{1,3}){3})\s+(?<Host>.+)$'
(Get-Content $HostsFilePath) | ForEach-Object{
    If ($_ -match $Pattern) {        
            
        New-Object PSObject -Property @{
            IP = $Matches.IP
            Host = $Matches.Host
            Comment = ($_ -split '#', 2)[1]
        }
    }
}
