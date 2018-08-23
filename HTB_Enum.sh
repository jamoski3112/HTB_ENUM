#!/bin/bash
#

RED='\033[0;41;30m'
STD='\033[0;0;39m'

 

pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

release(){
	echo -e "\e[44m ########## Release Version ########## \e[0m"
	cat /etc/issue && cat /etc/*-release

        pause
}
 

kernal(){
	echo -e "\e[44m ########## Kernal Version ########## \e[0m"
	cat /proc/version
        pause
}

env(){
	echo -e "\e[44m ########## Environment Variabes ########## \e[0m"

	cat ~/.bash_profile
		pause

} 

process(){
	echo -e "\e[44m ########## ROOT PROCESS ########## \e[0m"
	ps aux | grep root
		pause
}

cron_list(){
	echo -e "\e[44m ########## CRONS ########## \e[0m"
	crontab -l
		pause
}

nekernalrk(){
	echo -e "\e[44m ########## IP Config ########## \e[0m"
	ifconfig -a
	echo -e "\n"
	echo -e "\e[44m ########## Running Services ########## \e[0m"
	netstat -antup
	echo -e "\n"
		pause
}

user(){
	echo -e "\e[44m ########## List Users ########## \e[0m"
	cat /etc/passwd | cut -d: -f1 
		pause
}
dir(){
	echo -e "\e[44m ########## List Files In HOME Directory ########## \e[0m"
	ls -ahlR /var/www
	echo -e "\n"
	echo -e "\e[44m ########## List Files In HOME Directory ########## \e[0m"
	ls -ahlR /home/
		pause
}

sticky(){
	echo -e "\e[44m ########## SUID & GUID Binaries ########## \e[0m"
	for i in `locate -r "bin$"`; do find $i \( -perm -4000 -o -perm -2000 \) -type f 2>/dev/null; done
		pause
}

cron(){
	echo -e "\e[44m ########## Check Running CRONS ########## \e[0m"
	IFS=$'\n'

    old_process=$(ps -eo command)

	while true; do

  		new_process=$(ps -eo command)
  		diff <(echo "$old_process") <(echo "$new_process")
  		sleep 1
  		old_process=$new_process
	done
}
compile(){
	echo -e "\e[44m ########## List all Compilers ########## \e[0m"
	dpkg --list 2>/dev/null| grep compiler |grep -v decompiler 2>/dev/null && yum list installed 'gcc*' 2>/dev/null| grep gcc 2>/dev/null
		pause
}
show_menus() {
	clear
	echo -e "
\e[1;32m
                                                                         
 __   __  _______  _______    _______  __    _  __   __  __   __ 
|  | |  ||       ||  _    |  |       ||  |  | ||  | |  ||  |_|  |
|  |_|  ||_     _|| |_|   |  |    ___||   |_| ||  | |  ||       |
|       |  |   |  |       |  |   |___ |       ||  |_|  ||       |
|       |  |   |  |  _   |   |    ___||  _    ||       ||       |
|   _   |  |   |  | |_|   |  |   |___ | | |   ||       || ||_|| |
|__| |__|  |___|  |_______|  |_______||_|  |__||_______||_|   |_|


                                                                         
                               
\e[0m";
	echo "1. Show Release Version"
	echo "2. Show Kernal Version"
	echo "3. Show Environment Variabes"
	echo "4. Show Process run By ROOT"
	echo "5. CRON Jobs"
	echo "6. Netwoking Stuffs"
	echo "7. List USERS"
	echo "8. List Intresting Contents"
	echo "9. SUID & GUID Binaries"
	echo "10. Check Crons"
	echo "11. List all compilers"
	echo "12. Exit"
}

read_options(){
	local choice
	read -p "Enter choice [ 1 - 12] " choice
	case $choice in
		1) release ;;
		2) kernal ;;
		3) env ;;
		4) process ;;
		5) cron_list ;;
		6) nekernalrk ;;
		7) user ;;
		8) dir ;;
		9) sticky ;;
		10) cron ;;
		11) compile ;;
		12) exit ;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}
 

while true
do
 
	show_menus
	read_options
done
