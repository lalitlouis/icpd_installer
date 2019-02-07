# icpd_installer
Automation script to install icpd 

Follow the steps to configure and run the installer

### Pre-requisite

Needs a Fyre VM to act as initiator. Clone this project on the vm to access the installer files.

### Install

ssh root@<Fyre_vm>
<enter password>

git clone 

cd icpd_installer

vi Installer.sh

Update the variables
Git API key can be found from Settings -> Developer Settings -> Personal access tokens 
Fyre API key can be found under Account management in Fyre portal 
Build Version is the required installer build you want to install 
Cluster name should be unique or the cluster will not be created

chmod +x Installer.sh
./Installer.sh

### Troubleshooting


