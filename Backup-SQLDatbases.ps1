import-module -Name SqlServer -DisableNameChecking 
#if you have old version of SSMS installed use legacy SQLPS module instead of SQLServer module

$instanceName = 'localhost\sql2016'

#a. Backup a single database
Backup-SqlDatabase -ServerInstance $instanceName -Database 'TestDB'

#b. Backup single database
Set-Location SQLSERVER:\sql\$instancename\databases
Backup-SqlDatabase -Database 'TestDB'

#c. Backup ALL databases in an instance
Get-ChildItem SQLSERVER:\SQL\$instanceName\databases | Backup-SqlDatabase
