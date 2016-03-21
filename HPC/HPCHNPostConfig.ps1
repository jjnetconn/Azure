Add-PSSnapin Microsoft.HPC

while($true)
{
    Get-HpcNode -HealthState Unapproved -Name HPCDemoCN* | Assign-HpcNodeTemplate -Name "Default ComputeNode Template" -Confirm:$false
    Get-HpcNode -State Offline -Name HPCDemoCN* | Set-HpcNodestate -State online -Confirm:$false
    $onlineCNs = @(Get-HpcNode -State online -Name HPCDemoCN*)
    if($onlineCNs.Count -eq 2)
    {
        break
    }
    else
    {
        Start-Sleep -Seconds 120
    } 
} 
