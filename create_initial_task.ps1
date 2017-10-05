$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument 'c:\Windows\System32\appliance_config.ps1'

$trigger =  New-ScheduledTaskTrigger -AtStartup

Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Initconfig" -Description "Initial configuration of appliance"