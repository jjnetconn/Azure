#Deploy Azure HPC Cluster
$RgName = "HPCtest"
Login-AzureRmAccount -Credential Get-Credential
New-AzureRmResourceGroup -Name $RgName

$Time = [System.Diagnostics.Stopwatch]::StartNew()
New-AzureRmResourceGroupDeployment -Name $RgName -ResourceGroupName $RgName -TemplateUri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/create-hpc-cluster/ -TemplateParameterUri https://raw.githubusercontent.com/jjnetconn/Azure/master/HPC/azuredeploy.parameters.json
$Time.Stop
$Time.Elapsed
