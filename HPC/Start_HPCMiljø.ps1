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

$azureCred = Get-Credential -Credential "jje@atp.dk"

$Time = [System.Diagnostics.Stopwatch]::StartNew()

$vmList = @("hpc2k12");

Change-VmStatus -vmList $vmList -azureResourceGroup HPC2K12 -AzureCred $azureCred -action start

$Time = [System.Diagnostics.Stopwatch]::StartNew()
$vmList = @("CN-000","CN-001","CN-002","CN-003","CN-004");

Change-VmStatus -vmList $vmList -azureResourceGroup HPC2K12 -AzureCred $azureCred -action start

$Time.Stop
$Time.Elapsed