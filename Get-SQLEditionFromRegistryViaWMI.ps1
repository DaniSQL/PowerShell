function Get-SQLEditionFromRegistryViaWMI {
    param ([Parameter(Mandatory=$True)]
           [string[]]$ComputerName = 'localhost')

    $hklm = 2147483650
    $key = 'SOFTWARE\Microsoft\Microsoft SQL Server\Instance Names\SQL'
    $computername | foreach-object {
        try {
            $current = $_
            Test-Connection $current -ErrorAction Stop -Count 1 -Quiet | Out-Null
            $wmi = get-wmiobject -list "StdRegProv" -namespace root\default -computername $current
            $instances = ($wmi.Enumvalues($hklm,$Key)).snames | foreach-object {
                $wmi.GetStringValue($hklm,$key,$_).sValue
            }
        }
        catch {
            Write-Host $_
            return
        }

        if($instances){
            $instances | foreach-object {
                [PSCustomObject]@{
                    PSComputerName = $current 
                    InstanceName = $_.split('.')[1]
                    Edition = $wmi.GetStringValue($hklm,"Software\Microsoft\Microsoft SQL Server\$_\Setup",'Edition').svalue
                    Version = $wmi.GetStringValue($hklm,"Software\Microsoft\Microsoft SQL Server\$_\Setup",'Version').svalue
                }
            }
        } else {
                [PSCustomObject]@{
                    PSComputerName = $current 
                    InstanceName = 'None'
                    Edition = 'None'
                    Version = 'None'
                }
        }
    }
} 

