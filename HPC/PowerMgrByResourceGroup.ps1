param(
[string]$power,
[string]$azureResourceGroup
)

$AzureCred = Get-Credential -Credential 'jje@atp.dk'
$i = 0

if (!$power){Write-host "No powerstate specified. Use -Power start|stop"}
if (!$azureResourceGroup){Write-host "No Azure Resource Group specified. Use -azureResourceGroup 'ResourceGroupName'"}


write-host "Enumerating VM's from AzureRM in Resource Group '"$azureResourceGroup "'"
$vms = Get-AzureRMVM -ResourceGroupName $azureResourceGroup  
$vmrunninglist = @()
$vmstoppedlist = @()

Foreach($vm in $vms)
    {
        $vmstatus = Get-AzureRMVM -ResourceGroupName $azureResourceGroup -name $vm.name -Status       
        $PowerState = (get-culture).TextInfo.ToTitleCase(($vmstatus.statuses)[1].code.split("/")[1])
          
        write-host "VM: '"$vm.Name"' is" $PowerState
        if ($Powerstate -eq 'Running')
        {
            $vmrunninglist = $vmrunninglist + $vm.name
        }
        if ($Powerstate -eq 'Deallocated')
        {
            $vmstoppedlist = $vmstoppedlist + $vm.name
        } 
    }
    
Workflow Change-VmStatus {
    param($vmList,$action,$azureResourceGroup,$AzureCred)
    if($action -eq 'start'){
        ForEach -Parallel($vm in $vmList){
            Login-AzureRmAccount -Credential $AzureCred
            Start-AzureRMVM -ResourceGroupName $azureResourceGroup -Name $vm -Verbose
        }
    }
    if($action -eq 'stop'){
        ForEach -Parallel($vm in $vmList){
            Login-AzureRmAccount -Credential $AzureCred
            Stop-AzureRMVM -ResourceGroupName $azureResourceGroup -Name $vm -Verbose -Force
        }
    }
    
}
$Time = [System.Diagnostics.Stopwatch]::StartNew()
if($power -eq 'start'){
    Change-VmStatus -vmList $vmstoppedlist -action $power -azureResourceGroup $azureResourceGroup -AzureCred $AzureCred
    }
if($power -eq 'stop'){
    Change-VmStatus -vmList $vmrunninglist -action $power -azureResourceGroup $azureResourceGroup -AzureCred $AzureCred
    }
$Time.Stop
$Time.Elapsed
