<#

.SYNOPSIS
Adds current folder to PSModulePath environment variable.

.DESCRIPTION
Provides access to all modules in folder by adding the path to the PSModulePath environment variable.

#>

$CurrentValue = [Environment]::GetEnvironmentVariable("PSModulePath", "Machine")
[Environment]::SetEnvironmentVariable("PSModulePath", $CurrentValue + [System.IO.Path]::PathSeparator + $PSScriptRoot, "Machine")