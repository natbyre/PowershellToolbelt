# gets date of last reboot

param(
    [Parameter(Mandatory = $True,valueFromPipeline=$true)][String] $serverName
    )

Get-WmiObject -Class Win32_OperatingSystem -ComputerName $serverName | Select-Object CSName, @{Name='LastBootupTime'; Expression={"$($($_.LastBootupTime).SubString(0,4))-$($($_.LastBootupTime).SubString(4,2))-$($($_.LastBootupTime).SubString(6,2)) $($($_.LastBootupTime).SubString(8,2)):$($($_.LastBootupTime).SubString(10,2))"}}
