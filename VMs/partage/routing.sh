#######################
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
function show_ipv4_routes(){
	ip route
}
function show_ipv6_routes(){
	ip -6 route
}

################# Script ####################
BLUE "Showing routes:"
YELLOW "------------------------------------"
YELLOW "\tIPv4 routes:"
show_ipv4_routes
YELLOW "\tIPv6 routes:"
show_ipv6_routes
YELLOW "------------------------------------"
