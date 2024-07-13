[CmdletBinding()]
Param(
   [Parameter(Mandatory=$True)]
   [ValidateSet("text","csv","json", "list")]
   [string] $Format 
)

$HostsFilePath = "$($Env:WinDir)\system32\Drivers\etc\hosts"

$Pattern = '^(?<IP>\d{1,3}(\.\d{1,3}){3})\s+(?<Host>.+)$'
$OutputObjects = (Get-Content $HostsFilePath) | ForEach-Object{
    If ($_ -match $Pattern) {        
            
        New-Object PSObject -Property @{
            IP = $Matches.IP.Trim()
            Host = $Matches.Host.Trim()
            Comment = ($_ -split '#', 2)[1]
        }
    }
}



Switch ($Format) {

    'text' {$OutputObjects  | Format-Table -AutoSize | Out-String -Width 4096 | Write-Host}

    'csv'  {$OutputObjects | ConvertTo-Csv -NoTypeInformation | Out-String -Width 4096 | Write-Host}

    'json' {$OutputObjects | ConvertTo-Json | Out-String -Width 4096 | Write-Host}

    'list' {$OutputObjects  | Format-List  | Out-String -Width 4096  | Write-Host}
}
