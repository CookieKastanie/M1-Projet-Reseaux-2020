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
function launch_all_VMs(){
	i=1
	for VM in `find -name "VM*"`; do
		YELLOW "\t[ ${NC}$i${YELLOW} ] - Launching VM in: ${NC}{$VM}${YELLOW} ...\c"
		cd $VM
		vagrant up &
		cd ..
		(( i++ ))
	done
	wait
}
################## Script ####################
YELLOW "Launching all VMs in the current folder ..."
launch_all_VMs
GREEN " [DONE]"
