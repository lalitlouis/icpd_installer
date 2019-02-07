#!/bin/sh

SCP_USERNAME=$1
SCP_PASSWORD=$2
BUILD_VERSION=$3
IGC_DOWNLOAD=$4
MASTER_IP=$5

#Install Prerequisites
yum -y install sshpass


# Downloading ICPD installer
sshpass -p $SCP_PASSWORD scp -o StrictHostKeyChecking=no $SCP_USERNAME@9.30.110.240:/big_dir/jenkins/jobs/icp-embedded-install-md5-test/builds/$BUILD_VERSION/archive/* /ibm 
mkdir /ibm/modules
cd /ibm/modules
wget $4

cd /ibm
chmod +x install.x86_64.$BUILD_VERSION

echo "Please ssh into $MASTER_IP and run ./ibm/installer.x86_64.$BUILD_VERSION."



