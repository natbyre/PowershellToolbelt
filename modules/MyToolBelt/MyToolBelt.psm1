<#

.SYNOPSIS
My general tools

#>

function Set-MytbServerList {

    <#

    .SYNOPSIS
    Sets my server list.

    .DESCRIPTION
    Sets list of servers in a User environment variable named MytbServerList.

    .PARAMETER ServerList
    Comma separated list of servers

    .EXAMPLE 
    Set-MytbServerList "server1,server2"
    Sets environment variable named MytbServerList to "server1,server2"

    .NOTES
    The variable is used to save time spent typing out server names.

    #>

    param(
        [Parameter(Mandatory = $True, valueFromPipeline = $true)][String] $ServerList
    )

    [Environment]::SetEnvironmentVariable("MytbServerList", $ServerList, "User")

}

function Get-MytbServerList {

    <#

    .SYNOPSIS
    Gets my server list.

    .DESCRIPTION
    Gets the list of servers from User environment variable named MytbServerList.

    .EXAMPLE 
    Get-MytbServerList
    Gets the list of servers from User environment variable named MytbServerList.

    .EXAMPLE
    Get-MytbServerList | Get-MytbLastBootTime
    Pipes list of servers to Get-MytbLastBootTime to see last boot time for each server.

    .NOTES
    The variable is used to save time spent typing out server names.

    #>

    [Environment]::GetEnvironmentVariable("MytbServerList", "User").Split(",")

}

function Get-MytbLastBootTime {

    <#

    .SYNOPSIS
    Gets last boot time

    .DESCRIPTION
    Gets date and time of last boot up for server.

    .PARAMETER ComputerName
    Name of computer(s) that you wish to know last boot time for

    .EXAMPLE 
    Get-MytbLastBootTime localhost
    Gets the last boot time of local machine

    .EXAMPLE
    Get-MytbServerList | Get-MytbLastBootTime
    Pipe list of my servers to Get-MytbLastBootTime to see last boot time for each server.
    #>

    param(
        [Parameter(Mandatory = $True, valueFromPipeline = $true)][string[]] $ComputerName
    )

    BEGIN {}

    PROCESS {
        
        Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ComputerName | 
        Select-Object CSName, 
        @{
            Name = "LastBootupTime"; 
            Expression = { "$($($_.LastBootupTime).SubString(0,4))-$($($_.LastBootupTime).SubString(4,2))-$($($_.LastBootupTime).SubString(6,2)) $($($_.LastBootupTime).SubString(8,2)):$($($_.LastBootupTime).SubString(10,2))" } 
        }
    }

    END {}

}

