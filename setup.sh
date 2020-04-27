#!/bin/bash

#######################################################
## Below sections are all for anything user prompted ##
#######################################################
#######################################################
#######################################################

PS3="Whatchoo wanna do? ----> # "

echo """
  _____   _____  _______ _     _ _______ _______ . _______      _______ _  _  _ _______ _______ _______                         
 |_____] |     | |       |____/  |______    |    ' |______      |______ |  |  | |______ |______    |                            
 |       |_____| |_____  |    \_ |______    |      ______|      ______| |__|__| |______ |______    |                            
                                                                                                                                
 ______  _______ _______ _     _      _______ _______ _______ _     _  _____       _______ _______  ______ _____  _____  _______
 |_____] |_____| |______ |_____|      |______ |______    |    |     | |_____]      |______ |       |_____/   |   |_____]    |   
 |_____] |     | ______| |     |      ______| |______    |    |_____| |            ______| |_____  |    \_ __|__ |          |   
                                                                                                                                
"""

## Aliases creation
aliases () {
	touch /root/.bash_aliases
	echo -e "\n# listing directories all nice like
	alias ll='ls -l'
	alias la='ls -la' 
	alias dirsearch='python3 /opt/dirsearch/dirsearch.py'" | tee -a /root/.bash_aliases
}

echo "=====Do you want to create some aliases?====="
select choice in "Yes" "No"; do
	case $choice in
		Yes ) aliases; break;;
		No ) break;;
	esac
done


## Regex for grepping for ip addresses
regex () {
	echo -e "\n# environmental variable for ip address grepping
export IPREGEX='[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'" | tee -a /root/.bashrc
}

echo "=====Would you like to create a regex for grepping for ip addresses?====="
select choice in "Yes" "No"; do
	case $choice in
		Yes ) regex && echo "regex created as \$IPREGEX"; break;;
		No ) break;;
	esac
done

# installing sublime-test including GPG keys, https transport, and repo source
sublime () {
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -	
	apt-get install apt-transport-https
	echo "deb https://download.sublimetext.com/ apt/stable/" | tee -a /etc/apt/sources.list.d/sublime-text.list
	apt-get update -y
	apt-get install -y sublime-text
}

# creating SSL bypass rules for the intercept while on-site
sublime_ssl_bypass () {
	echo -e 'Acquire::https::download.sublimetext.com::Verify-Peer "false";
Acquire::https::download.sublimetext.com::Verify-Host "false";' | tee /etc/apt/apt.conf.d/80ssl-exceptions

}

echo "=====Would you like to install sublime text?====="
select choice in "Yes" "No"; do
	case $choice in
		Yes ) echo "Do you need to bypass the SSL intercept?" && select choice2 in "Yes" "No"; do
				case $choice2 in
					Yes ) sublime_ssl_bypass && sublime; break 2;;
					No ) break 2;;
				esac
			done
			;;
		No ) break;;
	esac
done


#######################################################
## Below sections are for unprompted (runs silently) ##
#######################################################
#######################################################
#######################################################

## install chromium
echo "=====installing chromium====="
apt-get install chromium
# change the chromium flags to be able to run appropriately, run as root and disable web security
echo 'export CHROMIUM_FLAGS="$CHROMIUM_FLAGS --password-store=basic --ignore-certificate-errors --no-sandbox --user-data-dir --disable-web-security --proxy-server=127.0.0.1:8088 --proxy-bypass-list=<-loopback>"' | tee -a /etc/chromium.d/default-flags

## install terminator
echo "=====installing terminator====="
apt-get install -y terminator

## install cherrytree
echo "=====installing cherrytree====="
apt-get install -y cherrytree

## install flameshot
echo "=====installing flameshot====="
apt-get install -y flameshot

## install bettercap
echo "=====installing bettercap====="
apt-get install -y bettercap

## install ufw
echo "=====installing ufw====="
apt-get install -y ufw

## install python 3
echo "=====installing python 3 and python3-pip====="
apt-get install -y python3 python3-pip

## install gobuster
echo "=====installing gobuster====="
apt-get install -y gobuster

## install crackmapexec
echo "=====installing crackmapexec====="
apt-get install -y crackmapexec

## install bloodhound
echo "=====installing bloodhound====="
apt-get install -y bloodhound

########## github repos ##########

# BloodHound
echo "=====grabbing Bloodhound repo====="
git clone https://github.com/BloodHoundAD/BloodHound.git /opt/BloodHound/

# SharpHound3
echo "=====grabbing SharpHound3 repo====="
git clone https://github.com/BloodHoundAD/SharpHound3.git /opt/SharpHound3/

# gnmap-parser
echo "=====grabbing gnmap-parser repo====="
git clone https://github.com/jasonjfrank/gnmap-parser.git /opt/gnmap-parser/

# PowerSploit dev branch
echo "=====grabbing Powersploit (dev branch) repo====="
git clone -b dev https://github.com/PowerShellMafia/PowerSploit.git /opt/PowerSploit/

# Citrix Netscaler
echo "=====grabbing Citrix Netscaler repo====="
git clone https://github.com/trustedsec/cve-2019-19781.git /opt/cve-2019-19781/

# SecLists
echo "=====grabbing SecLists repo======"
git clone https://github.com/danielmiessler/SecLists.git /opt/SecLists/

# impacket
echo "=====grabbing impacket repo====="
git clone https://github.com/SecureAuthCorp/impacket.git /opt/impacket/

# EyeWitness
echo "=====grabbing EyeWitness repo====="
git clone https://github.com/FortyNorthSecurity/EyeWitness.git /opt/EyeWitness/

# john
echo "=====grabbing john repo====="
git clone https://github.com/magnumripper/JohnTheRipper.git /opt/JohnTheRipper/

# Rubeus
echo "=====grabbing Rubeus repo====="
git clone https://github.com/GhostPack/Rubeus.git /opt/Rubeus/

# SharpUp
echo "=====grabbing SharpUp repo====="
git clone https://github.com/GhostPack/SharpUp.git /opt/SharpUp/

# Seatbelt
echo "=====grabbing Seatbelt repo====="
git clone https://github.com/GhostPack/Seatbelt.git /opt/Seatbelt/

# dirsearch
echo "=====grabbing dirsearch repo====="
git clone https://github.com/maurosoria/dirsearch.git /opt/dirsearch/

# mitm6
echo "=====grabbing mitm6 repo====="
git clone https://github.com/fox-it/mitm6.git /opt/mitm6/

# SIET
echo "=====grabbing SIET repo====="
git clone https://github.com/Sab0tag3d/SIET.git /opt/SIET/
