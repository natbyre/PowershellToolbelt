# gets date of last reboot

param(
    [Parameter(Mandatory = $True,valueFromPipeline=$true)][String] $serverName
    )

Get-WmiObject -Class Win32_OperatingSystem -ComputerName $serverName | Select-Object CSName, LastBootupTime