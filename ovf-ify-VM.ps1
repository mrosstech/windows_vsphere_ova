$vmName = "AddVMNameHere"

# Create the spec object
$spec = New-Object VMware.Vim.VirtualMachineConfigSpec
$spec.vAppConfig = New-Object VMware.Vim.VmConfigSpec
$spec.vAppConfig.property = New-Object [System.Collections.ArrayList]VMware.Vim.VAppPropertySpec



Function Add-vAppProperty($propArray, $label, $datatype, $userConfigurable, $defaultValue, $value, $description) {


	$thisSpec = New-Object VMware.Vim.VAppPropertySpec
	$thisSpec.operation = "add"
	$thisSpec.info = New-Object VMware.Vim.VAppPropertyInfo
	$thisSpec.info.key = $propArray.Count
	$thisSpecinfo.info.classId = "Property1ClassID"
	$thisSpec.info.instanceId = "Property1InstanceID"
	$thisSpec.info.id = "Property_1"
	$thisSpec.info.category = "Property1Category"
	$thisSpec.info.label = $label
	$thisSpec.info.type = $dataType
	$thisSpec.info.userConfigurable = $userConfigurable
	$thisSpec.info.defaultValue = $defaultValue
	$thisSpec.info.value = $value
	$thisSpec.info.description = $description
	
	$propArray.Add($thisSpec)

}

Add-vAppProperty($spec.vAppConfig.property, "win.ip", "string", $false, "<enter ip>", "<enter ip>", "IP to assign to the VM")
Add-vAppProperty($spec.vAppConfig.property, "win.mask", "string", $false, "<enter mask>", "<enter mask>", "SN Mask to assign to the VM")
Add-vAppProperty($spec.vAppConfig.property, "win.gateway", "string", $false, "<enter GW>", "<enter GW>", "GW to assign to the VM")
Add-vAppProperty($spec.vAppConfig.property, "win.dns", "string", $false, "<enter DNS>", "<enter DNS>", "DNS to assign to the VM")
Add-vAppProperty($spec.vAppConfig.property, "win.hostname", "string", $false, "<enter hostname>", "<enter hostname>", "Hostname to assign to the VM")
Add-vAppProperty($spec.vAppConfig.property, "win.domainuser", "string", $false, "<enter ip>", "<enter ip>", "IP to assign to the VM")
Add-vAppProperty($spec.vAppConfig.property, "win.domainpass", "string", $false, "<enter ip>", "<enter ip>", "IP to assign to the VM")
Add-vAppProperty($spec.vAppConfig.property, "win.domainname", "string", $false, "<enter ip>", "<enter ip>", "IP to assign to the VM")
Add-vAppProperty($spec.vAppConfig.property, "dc.create", "string", $false, "<enter ip>", "<enter ip>", "IP to assign to the VM")
Add-vAppProperty($spec.vAppConfig.property, "dc.domain", "string", $false, "<enter ip>", "<enter ip>", "IP to assign to the VM")
 
$vm = Get-VM -Name $vmName
$vm.ExtensionData.ReconfigVM_Task($spec)
