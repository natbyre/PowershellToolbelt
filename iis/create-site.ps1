#Requires -RunAsAdministrator

param(
    [Parameter(Mandatory = $True,valueFromPipeline=$true)][String] $siteName,
    [Parameter(Mandatory = $True,valueFromPipeline=$true)][int] $portNumber,
    [Parameter(valueFromPipeline=$true)][String] $path = $PSScriptRoot,
    [Parameter(valueFromPipeline=$true)][String] $logFileLocation = (($pwd).Drive.Name + ":\LogFiles")
    )

   
# Create app pool
New-WebAppPool -Name $siteName

# create folder
$path = New-Item -ItemType Directory "$path\$siteName"

# give app pool identity folder permissions if required
# $acl = Get-Acl
# $permission = "IIS APPPOOL\$siteName", "Modify, Read, ReadAndExecute, Write", "ContainerInherit, ObjectInherit", "None", "Allow"
# $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
# $acl.SetAccessRule($accessRule)
# Set-Acl $path $acl

# create website
New-WebSite -Name $siteName -Port $portNumber -PhysicalPath $path -ApplicationPool $siteName -Id $portNumber

# set log file location
Set-ItemProperty "IIS:\Sites\$siteName" -name logFile.directory -value $logFileLocation

# create poolmaintenance.txt
"$portNumber $siteName
$env:COMPUTERNAME
PASSED" | Out-File -Encoding default -FilePath $path\PoolMaintenance.txt -NoNewline
