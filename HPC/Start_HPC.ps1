$vmList = @("HEAD001","Compute003","Compute004")

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
Change-VmStatus -vmList $vmList -azureResourceGroup ATPHPC2K8 -AzureCred $(Get-Credential -Credential "jje@atp.dk") -action start