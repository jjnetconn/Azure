#Deploy Azure HPC Cluster
$RgName = "ATPHPC"
$DeploymentName = "atphpc"
Login-AzureRmAccount
New-AzureRmResourceGroup -Name $RgName -Location "North Europe"

$Time = [System.Diagnostics.Stopwatch]::StartNew()
New-AzureRmResourceGroupDeployment -Name $DeploymentName -ResourceGroupName $RgName -TemplateUri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/create-hpc-cluster/azuredeploy.json -TemplateParameterFile C:\Users\jje\Source\Repos\Azure\HPC\azuredeploy.parameters.json
$Time.Stop
$Time.Elapsed