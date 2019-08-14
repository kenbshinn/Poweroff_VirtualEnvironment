# Power off Virtual Environment
Powershell Script for powering off a Virtual Environment
I created this script to assist with powering down a Lab Environment which can be time consuming. 

This Script is a multi-function script. Each function is able to be ran from the main menu and is selected by typing the number and pressing enter. 
The script also generates a report that will tell you what Virtual Machines are running on at the time of powering down. 

I will now break down each function of this script.

#Import Assemblies/Modules
This function installs PowerCLI from the Microsoft Powershell Store

# Create Error Logs
This section is blank at this point. I might add more into this section later.

#Global Parmeters
This section is blank at this point. I might add more into this section later.

#Function to power off virtual machine
This function will ask you for your VCSA Host name or ESXi Host and use it to fill in the $vcNames Variable.

It will then connect to that Virtual Host and prompt you for credentials. Once you authenticate to the VCSA Server it will do a Get-VM query of all Powered on VMs and save it to a text file called poweredonvms.txt

Then it will either do a Shutdown using VMWare Tools installed on the VM or Stop-VM to power off VMs that do not have VMware Tools.
It will then export the results to a results.csv.

#Function to Power off Lab Virtual Hosts
This function will ask you for your VCSA Host name or ESXi Host and use it to fill in the $vcNames Variable.

It will then connect to that Virtual Host and prompt you for credentials. Once you authenticate to the VCSA, the script will ask you what virtual host you want to power off. Once you enter the name it will power off the host using Stop-VMHost.

#Function to PowerOff-LabVCSA01
This function is pretty straight forward, it connects to a Virtual Host and then it will shutdown a VM that you specify

#Function to PowerOff-Infrastructure Hosts
This function connects to a host and powers it off. 

#Function to Report Powered on Virtual Machines only
This Function will request that you specify a VCSA Appliance to connect to. Once authenticated it will do a Get-VM on all Powered on Virtual Machines and Export it to a Text file. 

#Note
Under Function PowerOff-LabVCSA01 - Make sure that you update the Shutdown-VMGuest with the Name of the VM that you are trying to power off before you run this script or it will fail. 

#Begin Script
This section is what provides the graphical display and the number prompts that you use to run the various functions. 



#Future Planning
I would like to do the following:
Automatically check if PowerCLI is installed, if not Install it