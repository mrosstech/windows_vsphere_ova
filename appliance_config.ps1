# Remove original scheduled task
Unregister-ScheduledTask -TaskName "Initconfig" -Confirm:$false

# Dump OE contents
$command = @'
cmd.exe /C vmtoolsd.exe --cmd "info-get guestinfo.ovfEnv" > c:\oe.txt
'@
Invoke-Expression -Command:$command

# GET XML Content
$xml = [xml](get-content C:\oe.txt)

# GET OE Properties
$values = $xml.Environment.PropertySection.Property

# Loop through Properties to assign to variables
foreach ($me in $values) {
    write-host "Tag: " $me.key
    write-host "Value: " $me.value

    if ($me.key -eq "win.ip") {$ip=$me.value}
    if ($me.key -eq "win.mask") {$mask = $me.value}
    if ($me.key -eq "win.gateway") {$gateway = $me.value}
    if ($me.key -eq "win.dns") {$dns = $me.value}
    if ($me.key -eq "win.hostname") {$hostname = $me.value}
    if ($me.key -eq "win.domainuser") {$domainuser = $me.value}
    if ($me.key -eq "win.domainpass") {$domainpass = $me.value}
    if ($me.key -eq "win.domainname") {$domainname = $me.value}
	if ($me.key -eq "dc.create") {$createdc = $true}
	if ($me.key -eq "dc.domain") {$dcdomain = $me.value}
}


# Change IP
write-host "IP Address: $ip"
write-host "DNS: $dns"
write-host "Gateway: $gateway"
write-host "Mask: $mask"

Invoke-command {
netsh interface ip set address "Ethernet0" static $ip $mask $gateway
netsh interface ip add dns "Ethernet0" $dns}

# Change Name and Reboot
Invoke-command {
Rename-Computer -ComputerName $env:COMPUTERNAME -NewName $hostname -Force
}

# Configure new scheduled task to join domain and reboot


