$vmName = "AddVMNameHere"

# Add vApp Properties to the VM
$spec = New-Object VMware.Vim.VirtualMachineConfigSpec
$spec.vAppConfig = New-Object VMware.Vim.VmConfigSpec
$spec.vAppConfig.property = New-Object VMware.Vim.VAppPropertySpec[] (1)
$spec.vAppConfig.property[0] = New-Object VMware.Vim.VAppPropertySpec
$spec.vAppConfig.property[0].operation = "add"
$spec.vAppConfig.property[0].info = New-Object VMware.Vim.VAppPropertyInfo
$spec.vAppConfig.property[0].info.key = 0
$spec.vAppConfig.property[0].info.classId = "Property1ClassID"
$spec.vAppConfig.property[0].info.instanceId = "Property1InstanceID"
$spec.vAppConfig.property[0].info.id = "Property_1"
$spec.vAppConfig.property[0].info.category = "Property1Category"
$spec.vAppConfig.property[0].info.label = "Property 1"
$spec.vAppConfig.property[0].info.type = "string"
$spec.vAppConfig.property[0].info.userConfigurable = $true
$spec.vAppConfig.property[0].info.defaultValue = "Property1DefaultValue"
$spec.vAppConfig.property[0].info.value = ""
$spec.vAppConfig.property[0].info.description = "Property1Description"
 
 
$vm = Get-VM -Name vm3
$vm.ExtensionData.ReconfigVM_Task($spec)
