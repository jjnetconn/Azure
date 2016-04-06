#AzureRM Auto login
$username = "NTATP\jje"
$password = ConvertTo-SecureString "buDs76Cs!" -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential ` -argumentlist $username, $password

Login-AzureRmAccount -Credential $cred
Get-