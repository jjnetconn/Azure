#Deploy Azure HPC Cluster
$RgName = "AtpPi"
$DeploymentName = "atppihpc"
#Login-AzureRmAccount
New-AzureRmResourceGroup -Name $RgName -Location "North Europe"

$Time = [System.Diagnostics.Stopwatch]::StartNew()
New-AzureRmResourceGroupDeployment -Name $DeploymentName -ResourceGroupName $RgName -TemplateUri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/create-hpc-cluster/azuredeploy.json -TemplateParameterUri https://raw.githubusercontent.com/jjnetconn/Azure/master/HPC/azuredeploy.parameters.json
$Time.Stop
$Time.Elapsed