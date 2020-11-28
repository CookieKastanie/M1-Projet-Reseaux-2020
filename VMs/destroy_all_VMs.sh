#!/bin/bash 
################ Colors #######################
RED=`tput bold && tput setaf 1`
GREEN=`tput bold && tput setaf 2`
YELLOW=`tput bold && tput setaf 3`
BLUE=`tput bold && tput setaf 4`
NC=`tput sgr0`
function RED(){ echo -e ${RED}${1}${NC} ;}
function GREEN(){ echo -e ${GREEN}${1}${NC} ;}
function YELLOW(){  echo -e ${YELLOW}${1}${NC} ;}
function BLUE(){ echo -e ${BLUE}${1}${NC} ;}
##############################################
################# Functions ##################

# $1 is the folder of the VM.
function destroy_VM(){
	vagrant destroy -f
}
function destroy_master_VM(){
	rm -f ~/.vagrant.d/boxes/m1reseaux/0/virtualbox/master_id
}

function destroy_all_VMs(){
	i=1
	for VM in `find -name "VM*"`; do
		YELLOW "\t[ ${NC}$i${YELLOW} ] - Destroying VM in: ${NC}{$VM}${YELLOW} ...\c"
		cd $VM
		output=$(destroy_VM $VM)
		destroy_exit_code=$?
		cd ..

		treat_exit_code ${VM} ${destroy_exit_code} ${output}
		(( i++ ))
	done
}

# $1 is the VM's folder
# $2 is the exit code after destroying a VM
# $3 is the output of vagrant
function treat_exit_code(){
	if [ $2 -eq 0 ]; then
		GREEN "\t\t[Done]"
	else
		RED "\nError encountered in the destruction of ${NC}{$1}${RED}."
		YELLOW "Here is the output of vagrant:"
		echo $3
	fi
}

################## Script ####################
YELLOW "Destroying all VMs in the current folder ..."
destroy_all_VMs
YELLOW "Destroying vagrant's master VM ...\c"
destroy_master_VM
GREEN " [DONE]"
