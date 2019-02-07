#!/bin/sh


#CONFIG
#FYRE_API_KEY can be obtained from Fyre Account details page 
#Git API Key can be obtained by logging into enterprise github account -> settings -> developer settings -> Personal access tokens
#Cluster name needs to be unique across Fyre systems
FYRE_USER={}
FYRE_API_KEY={}
FYRE_PASSWORD={}
CLUSTER_NAME={}
GIT_API_KEY={}
BUILD_VERSION={}
SCP_USERNAME=ibmuser
SCP_PASSWORD=wdp4fun
VIRTUAL=virtual
VIRTUAL_CLUSTER_NAME=$CLUSTER_NAME$BUILD_VERSION$VIRTUAL
#modules 
IGC_DOWNLOAD={link without the tar file}

# PRE REQUISITES
# install zlib-devel, git and sshpass
yum -y install zlib-devel
yum -y install git
yum -y install sshpass

# install python and setuptools/pip
chmod +x install_python.sh
./install_python.sh

# install package paramiko and requests
pip install paramiko
pip install requests

# CLUSTER SETUP
# Clone the Install repo and run script to setup cluster
git clone https://$GIT_API_KEY@github.ibm.com/PrivateCloud/InstallAndGo.git
cd InstallAndGo
git checkout updateCreateFyre
cd helper_scripts
python ./create_fyre_cluster.py --user=$FYRE_USER --key=$FYRE_API_KEY --cluster=$CLUSTER_NAME$BUILD_VERSION --icp-base --docker-raw-disk

# Get the Master node IP 
cd ..
cd ..
MASTER_IP="$(python -W ignore curl.py $CLUSTER_NAME$BUILD_VERSION $FYRE_USER $FYRE_API_KEY)"
echo "Master IP is $MASTER_IP"

#shutdown virtual clusters
curl -X GET -k -u $FYRE_USER:$FYRE_API_KEY 'https://api.fyre.ibm.com/rest/v1/?operation=shutdown&cluster_name='$VIRTUAL_CLUSTER_NAME'[&shutdown_type=pull_the_plug]'

# INSTALLATION BEGINS
# Operating in the master node...
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no root@$CLUSTER_NAME$BUILD_VERSION-master-1.fyre.ibm.com 'bash -s' -- < remote_script.sh $SCP_USERNAME $SCP_PASSWORD $BUILD_VERSION $IGC_DOWNLOAD $MASTER_IP







