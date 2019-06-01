##########################
#
#  vCenter Shutdown Tool
#
#  
#
#  #  Ver 0.1
#  Written by: Kenneth B Shinn Jr.
#  Created 05/30/19
#  Updated --
##########################


########################################
#
# Import assemblies/modules 
#
########################################
Function Install_PowerCLI
{
Install-Module -Name VMware.PowerCLI
}



########################################
#
# Create Error Logs
#
########################################




########################################
#
# Global Parameters 
#
########################################






########################################################################################
#
# Function to power off virtual machines
#
#
########################################################################################

Function PowerOff-VirtualMachines
{
$vcNames = Read-Host -Prompt 'Input your VCSA Server Here'

Connect-VIServer -Server $vcNames
Get-VM | Where-Object {$_.powerstate -eq 'PoweredOn'-and $_.Name -notlike '*labvcsa01*'} | select Name | Out-File .\poweredonvms.txt
}
$VMList = Get-Content .\poweredonvms.txt

foreach($vmName in $VMList)
{
    $vm = Get-VM -Name $vmName
    if($vm.Guest.State -eq "Running"){
        Shutdown-VMGuest -VM $vm -Confirm:$false}
    else{    
        Stop-VM -VM $vm -confirm:$false
        write-host "Powering Down VM..."
      export ".\results.csv"}
    }
	
########################################################################################
#
# Function to power off lab virtual hosts
#
#x
########################################################################################

Function PowerOff-VirtualHosts

{
$vcNames = Read-Host -Prompt 'Input your VCSA Server Here'
Connect-VIServer -Server $vcNames

$vhnames = Read-Host -Prompt 'Input the Virtual Host you would like to power off (example: phlvh00a.domain.local,phlvh00b.domain.local)'
Stop-VMHost -server $vhnames -Confirm}


########################################################################################
#
# Function to power off labVCSA01
#
#
########################################################################################

Function PowerOff-LabVCSA01
{
 Connect-VIServer -Server 172.26.96.44
 Shutdown-VMGuest -VM labvcsa01.pcn.local -Confirm:$false
 }
 ########################################################################################
#
# Function to power off Infrastructure Virtual Host
#
#
########################################################################################

Function PowerOff-InfrastructureHosts
{
Connect-VIServer -Server 172.26.96.44
Stop-VMHost 172.26.96.44 -Confirm
}
########################################################################################
#
# Function to Report powered on virtual machines Only
#
#
########################################################################################

Function Report-PoweredOnVMs
{
$vcNames = Read-Host -Prompt 'Input your VCSA Server Here'

Connect-VIServer -Server $vcNames
Get-VM | Where-Object {$_.powerstate -eq 'PoweredOn'-and $_.Name -notlike '*labvcsa01*'} | select Name | Out-File C:\temp\vmware\scripts\poweredonvms.txt
}


 ###########################################
###########################################
# 
# Begin Script
#
###########################################
###########################################

Write-Host " "
Write-Host "     ***********************************" 		-ForegroundColor White
Write-Host "               Lab Power Down"			        -ForegroundColor White
Write-Host "               "			        -ForegroundColor White
Write-Host "               Created 05/30/19"			        -ForegroundColor White
Write-Host "     ***********************************"		-ForegroundColor White
Write-Host " "
Write-Host "       Select your specific operation" 	        -ForegroundColor White
Write-Host " "
Write-Host " "
Write-Host "         *** Power Down the Lab***"
Write-Host " "
Write-Host "          1.  Power off Virtual Machines"                -ForegroundColor Cyan
Write-Host " "
Write-Host "          2.  Power off Virtual Hosts"       -ForegroundColor Green
Write-Host " "
Write-Host " "
Write-Host "      *** Power Down Infrastructure Hosts ***"
Write-Host " "
Write-Host "          3.  Power Off LabVCSA01"       -ForegroundColor Magenta
Write-Host " "
Write-Host "          4.  Power Off Infrastructure Hosts"       -ForegroundColor Yellow
Write-Host " "
Write-Host "    *** Reports ***  "
Write-Host " "
Write-Host "          5.  Powered On Virutal Machines"       -ForegroundColor DarkGreen
Write-Host " "
Write-Host "    *** Install Tools *** "
Write-Host " "
Write-Host "          6.  Install PowerCLI "                 -ForegroundColor Blue
Write-Host " "
$strResponse = Read-Host "Enter Menu Option..."
If($strResponse -eq "1"){. PowerOff-VirtualMachines}
	elseif($strResponse -eq "2"){. PowerOff-VirtualHosts}
    	elseif($strResponse -eq "3"){. PowerOff-LabVCSA01}
	elseif($strResponse -eq "4"){. PowerOff-InfrastructureHosts}
    elseif($strResponse -eq "5"){. Report-PoweredOnVMs} 
    elseif($strResponse -eq "6"){. Install_PowerCLI}
		else{Write-Host "You did not supply a correct response, `
		Please run script again." -foregroundColor Red}

		