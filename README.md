# Power off Virtual Environment
Powershell Script for powering off a Virtual Environment
I created this script to assist with powering down a Lab Environment which can be time consuming. 
The Script also generates a report that will tell you what Virtual Machines are running on at the time of powering down. 


#Note
Under Function PowerOff-LabVCSA01 - Make sure that you update the Shutdown-VMGuest with the Name of the VM that you are trying to power off before you run this script or it will fail. 
