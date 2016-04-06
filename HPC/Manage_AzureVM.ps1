$vmList = @("CN-000","CN-001","CN-002","CN-003","CN-004");
$resourceGroup = "HPC2K12";
$location = "northeurope";

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

Workflow Install-RDMA {
 param($vmList,$azureResourceGroup,$AzureCred,$location)
    foreach -parallel($vm in $vmList){
        Login-AzureRmAccount -Credential $AzureCred
        Set-AzureRmVMExtension -ResourceGroupName $azureResourceGroup -VMName $vm -Location $location  -ExtensionName HpcVmDrivers -TypeHandlerVersion 1.1 -Publisher "Microsoft.HpcCompute" -ExtensionType HpcVmDrivers
        }

}


Change-VmStatus -vmList $vmList -azureResourceGroup $resourceGroup -AzureCred $(Get-Credential -Credential "jje@atp.dk") -action start
Install-RDMA -vmList $vmList -azureResourceGroup $resourceGroup -AzureCred $(Get-Credential -Credential "jje@atp.dk") -location $location
