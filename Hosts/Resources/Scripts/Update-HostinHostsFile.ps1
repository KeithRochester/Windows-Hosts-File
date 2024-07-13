[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True)]
    [String]$IPAddress,
    [Parameter(Mandatory = $True)]
    [String]$HostName
)

$HostsFilePath = "$($Env:WinDir)\system32\Drivers\etc\hosts"

Function Add-HostToHostFile{
[CmdletBinding(SupportsShouldProcess=$True)]
  Param ($HostName, $IPAddress, $HostsFilePath)

    $HostsFile = Get-Content $HostsFilePath
    if($PSCmdlet.ShouldProcess($HostsFilePath,"Add $HostName $IPAddress")){
        Add-Content -Encoding UTF8  $HostsFilePath ("$IPAddress".PadRight(20, " ") + "$HostName")
    }
}

Function Test-HostinHostFile{
 Param ($HostName, $HostsFilePath)
    $HostsFile = Get-Content $HostsFilePath
    if($HostsFile -match [Regex]::Escape($HostName)){
        $True
    }else{
        $False
    }
}

Function Remove-HostFromHostFile{
[CmdletBinding(SupportsShouldProcess=$True)]
  Param ($HostName, $HostsFilePath)

    if(Test-HostinHostFile -HostName $HostName -HostsFilePath $HostsFilePath){
        $HostsFile = Get-Content $HostsFilePath
        if($PSCmdlet.ShouldProcess($HostsFilePath,"Remove $HostName")){
            $HostsFile -notmatch ".*\s+$([Regex]::Escape($Hostname)).*" | Out-File $hostsFilePath 
        }     
         
    }else{         
         Write-Error -Exception "Could not remove $HostName from in $HostsFilePath" 
    }

}

if(Test-HostinHostFile -HostName $HostName -HostsFilePath $HostsFilePath){
 #Remove existing entry
 Remove-HostFromHostFile -HostName $HostName -HostsFilePath $HostsFilePath
}

#Add new entry
Add-HostToHostFile -HostName $HostName -IPAddress $IPAddress -HostsFilePath $HostsFilePath

# Output Entries in file

$Pattern = '^(?<IP>\d{1,3}(\.\d{1,3}){3})\s+(?<Host>.+)$'
(Get-Content $HostsFilePath) | ForEach-Object{
    If ($_ -match $Pattern) {        
            
        New-Object PSObject -Property @{
            IP = $Matches.IP.Trim()
            Host = $Matches.Host.Trim()
            Comment = ($_ -split '#', 2)[1]
        }
    }
}
