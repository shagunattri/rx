#!/bin/bash
set -euo pipefail

show_menus() {
	clear
        echo -e "${GREEN}\

                          #####                          
  ####   #    #  #####   #     #  #    #  #    #  #    # 
 #       #    #  #    #        #  ##   #  #    #  ##  ## 
  ####   #    #  #####    #####   # #  #  #    #  # ## # 
      #  #    #  #    #        #  #  # #  #    #  #    # 
 #    #  #    #  #    #  #     #  #   ##  #    #  #    # 
  ####    ####   #####    #####   #    #   ####   #    # 
                                                         
                                                                    
        ${SET}"
    echo -e "${CYAN}sub3num will install all the recon tools you need${SET}"
    echo "Tools:"
    echo "   0. Install tool dependencies [GO, Python3, Ruby, etc...]"
    echo "   1. Assetfinder"
    echo "   2. httprobe"
    echo "   3. html-tool"
    echo "   4. subjack"
    echo "   5. waybackurls"
    echo "   6. nikto"
    echo "   7. gobuster"

    echo -e "\n\n  88. Install all tools"
    echo -e "  99. Exit\n"
}

read_option(){
	local choice
	read -p "Enter choice [ 1 - 99] " choice
	case $choice in
        0) install_dependencies ;;
        1) install_assetfinder ;;
        2) install_httprobe ;;
	    3) install_html-tool ;;
	    4) install_subjack ;;
	    5) install_waybackurls ;;
        6) install_nikto ;;
        7) install_gobuster ;;

        88) install_all ;;
	99) exit 0;;
	*) echo -e "${RED}Error...${SET}" && sleep 2
	esac
}

pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}
 
load_colors() {
    # https://www.shellhacks.com/bash-colors/
    DARKGRAY='\033[1;30m'
    RED='\033[0;31m'    
    LIGHTRED='\033[1;31m'
    GREEN='\033[0;32m'    
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'    
    PURPLE='\033[0;35m'    
    LIGHTPURPLE='\033[1;35m'
    CYAN='\033[0;36m'    
    WHITE='\033[1;37m'
    SET='\033[0m'
}

install_dependencies() {
    echo -e "${GREEN}Installing tool dependencies ${SET}"
    sudo pacman -S --noconfirm python3 wget unzip make libpcap python-pip ruby go
    sudo ln -s /usr/bin/python3 /usr/bin/python
    echo -e "${YELLOW}Finished installing tools' dependencies ${SET}\n"
    pause
}

install_assetfinder() {
    # https://github.com/tomnomnom/assetfinder
    echo -e "${GREEN}Installing assetfinder ${SET}"
    go get -u github.com/tomnomnom/assetfinder
    sudo cp $HOME/go/bin/assetfinder /usr/local/bin
    echo -e "${YELLOW}Finished installing assetfinder ${SET}\n"
    pause

}

install_httprobe() {
    # https://github.com/tomnomnom/httprobe
    echo -e "${GREEN}Installing httprobe ${SET}"
    go get -u github.com/tomnomnom/httprobe
    sudo cp $HOME/go/bin/httprobe /usr/local/bin
    echo -e "${YELLOW}Finished installing httprobe ${SET}\n"
    pause

}

install_html-tool() {
    # https://github.com/tomnomnom/hacks/tree/master/html-tool
    echo -e "${GREEN}Installing html-tool ${SET}"
    go get -u github.com/tomnomnom/hacks/html-tool
    sudo cp $HOME/go/bin/httprobe /usr/local/bin
    echo -e "${YELLOW}Finished installing html-tool ${SET}\n"
    pause

}

install_subjack() {
    # https://github.com/haccer/subjack
    echo -e "${GREEN}Installing subjack ${SET}"
    go get github.com/haccer/subjack
    sudo cp $HOME/go/bin/subjack /usr/local/bin
    echo -e "${YELLOW}Finished installing subjack ${SET}\n"
    pause

}

install_waybackurls() {
    # https://github.com/tomnomnom/waybackurls
    echo -e "${GREEN}Installing waybackurls ${SET}"
    go get -u github.com/tomnomnom/waybackurls
    sudo cp $HOME/go/bin/httprobe /usr/local/bin
    echo -e "${YELLOW}Finished installing waybackurls ${SET}\n"
    pause

}

install_nikto() {
    # https://github.com/sullo/nikto
    echo -e "${GREEN}Installing nikto ${SET}"
    sudo pacman -S nikto
    echo -e "${YELLOW}Finished installing nikto ${SET}\n"
    pause

}

install_gobuster() {
    # https://github.com/OJ/gobuster
    echo -e "${GREEN}Installing gobuster ${SET}"
    go get github.com/OJ/gobuster
    sudo cp $HOME/go/bin/httprobe /usr/local/bin
    echo -e "${YELLOW}Finished installing gobuster ${SET}\n"
    pause

}


add_to_path() {
    if [[ ":$PATH:" == *":$HOME/tools/$1:"* ]] || grep -q "$HOME/tools/$1" $HOME/.bash_profile; then
        echo -e "${RED}$1 dir already in path${SET}"
    else
        PATH_EXPORT=$(sed -n "/export PATH/p" ~/.bash_profile)
        if [ -z "$PATH_EXPORT" ]; then
            PATH_EXPORT=$PATH:$HOME/tools/$1
            echo $PATH_EXPORT
            echo "export PATH=${PATH_EXPORT}" >> $HOME/.bash_profile && source $HOME/.bash_profile
        else
            PATH_EXPORT=$(sed -n "/export PATH/p" ~/.bash_profile):$HOME/tools/$1
            echo $PATH_EXPORT
            sed -i '/^export PATH/d' $HOME/.bash_profile > $HOME/.bash_profile
            echo "export PATH=${PATH_EXPORT}" >> $HOME/.bash_profile && source $HOME/.bash_profile
        fi
        echo -e "${GREEN}Added $1 to PATH ${SET}"
    fi
}

install_all () {
    install_assetfinder
    install_amass
    install_httprobe
    install_nmap
    install_gowitness
    install_subjack
    pause
}

trap '' SIGINT SIGQUIT SIGTSTP

while true
do
    load_colors
    show_menus
    read_option
done
