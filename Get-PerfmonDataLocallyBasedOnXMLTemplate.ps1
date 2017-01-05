
<#
.SYNOPSIS
 Import Perfmon XML template and create a Perfmon Data Collector Set.
.NOTES
 This is based on original script written by Boo Radely https://blogs.technet.microsoft.com/brad_rutkowski/2009/02/18/interacting-with-data-collector-sets-via-powershell/  
.EXAMPLE
 SCollect-PerfmonDataLocallyBasedOnXMLTemplate -XMLTemplatePath "C:\Perflogs\Templates\SQL2008R2.xml -DataCollectorName "PAL_SQL2008R2_Counters"
#>

function Get-PerfmonDataLocallyBasedOnXMLTemplate (
    $XMLTemplatePath,
    $DataCollectorName
)
{

#$ComputernName = 'localhost'


 #Check if XML Perfmon Template exists
if (Test-Path $XMLTemplatePath) {
    
    $XMLTemplate = Get-Content $XMLTemplatePath
    $datacollectorset = New-Object -COM Pla.DataCollectorSet
    $datacollectorset.SetXml($XMLTemplate)
    $datacollectorset.Commit("$DataCollectorName" , $null , 0x0003) | Out-Null
    $datacollectorset.start($false)
    }

}
