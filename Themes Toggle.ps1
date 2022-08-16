function themes-enable { start-service -name themes 
REG add "HKLM\SYSTEM\CurrentControlSet\services\Themes" /v Start /t REG_DWORD /d 2 /f}
function themes-disable { stop-service -name themes 
REG add "HKLM\SYSTEM\CurrentControlSet\services\Themes" /v Start /t REG_DWORD /d 4 /f}
function test-registry { 
$key1 = Get-ItemProperty -path "HKLM:\SYSTEM\CurrentControlSet\services\Themes" -Name "Start" | select-object -ExpandProperty Start
if ($key1 -ne 4) {
$global:status = "No"
}
Else { $global:status = "Yes"
}}
function text-message { 
Clear-host
Write-Host "Is multi-monitor VSync disabled?: $global:$status"
Write-Host "Enter 1 to enable     " 
Write-Host "      2 to disable    " }
$ErrorActionPreference= 'silentlycontinue'
$continue = $true
while($continue)
{
test-registry
text-message
$selection = Read-Host
switch ($selection)
{
'1' { themes-enable } 
'2' { themes-disable } 
}}