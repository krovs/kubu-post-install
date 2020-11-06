#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 
   	exit 1
fi

#Update and Upgrade
echo "Updating and Upgrading"
add-apt-repository -y multiverse
apt update && apt upgrade -y

apt install dialog
cmd=(dialog --separate-output --checklist "Please Select Software you want \
    to install:" 22 76 16)

options=(
    1 "VSCode" off    # any option can be set to default to "on"
    2 "Typora" off
    3 "Build Essentials" off
    4 "Tilix" off
    5 "Git" off
    6 "Latte-dock" off
    7 "Neofetch & Lolcat" off
    8 "Virtualbox" off
    9 "Kubuntu Restricted Extras" off
    10 "VLC Media Player" off
    11 "Solaar" off
    12 "net-tools" off
    13 "Nmap" off
    14 "Gimp" off
    15 "curl" off
    16 "Steam" off
    17 "Insync" off
    18 "htop" off
    19 "Spotify" off
    20 "Ppapirus icon theme" off
    21 "Arc KDE theme" off
    22 "Gnome keyring" off
    23 "Pip" off
    24 "Docker" off
    25 "Docker-compose" off
    26 "Transmission" off
    27 "Logitech MX Master mapping" off
    28 "Generate SSH Keys" off
    29 "Todoist" off
    30 "Flameshot" off
    31 "Traceroute" off)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
    case $choice in
        1)
            echo "**** Installing VScode ****"
            apt install software-properties-common apt-transport-https wget -y
            wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | \
            apt-key add -
            add-apt-repository -y "deb [arch=amd64] \
            https://packages.microsoft.com/repos/vscode stable main"
            apt update
            apt install -y code
            ;;
        2)
            echo "**** Installing Typora ****"
            wget -qO - https://typora.io/linux/public-key.asc | \
            apt-key add -
            add-apt-repository -y 'deb https://typora.io/linux ./'
            apt update
            apt install -y typora
            ;;
        3)	
            echo "**** Installing Build Essentials ****"
            apt install -y build-essential
            ;;
        4)
            echo "**** Installing Tilix ****"
            apt install -y tilix
            ;;
        5)
            echo "**** Installing Git ****"
            apt install -y git
            echo "##### GIT global config #####"
            read -p 'Git username: ' gituser
            read -p 'Git email: ' gitemail
            git config --global user.name "$gituser"
            git config --global user.email $gitemail
            ;;
        6)  echo "**** Installing Latte-dock ****"
            apt install -y latte-dock
            cp ./*.layout.latte /home/${USER:=$(/usr/bin/id -run)}/.config/latte/.
            ;;
        7)
            echo "**** Installing Neofetch & lolcat ****"
            snap install lolcat
            apt install -y neofetch
            ;;
        8)
            echo "**** Installing Virtualbox ****"
            apt install -y virtualbox
            ;;
        9)
            echo "**** Installing Kubuntu Restricted Extras ****"
            apt install kubuntu-restricted-extras -y
            ;;
        10)
            echo "**** Installing VLC Media Player ****"
            apt install -y vlc
            ;;
        11)
            echo "**** Installing Solaar ****"
            apt install -y solaar
            ;;
        12)
            echo "**** Installing net-tools ****"
            apt install -y net-tools
            ;;
        13)
            echo "**** Installing Nmap ****"
            apt install -y nmap
            ;;
        14)
            echo "**** Installing Gimp ****"
            apt install -y gimp
            ;;
        15)
            echo "**** Installing Curl ****"
            apt install -y curl
            ;;
        16)
            echo "**** Installing Steam ****"
            apt install -y steam
            ;;
        17)
            echo "**** Installing Insync ****"
            apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
            add-apt-repository -y \
            "deb http://apt.insync.io/ubuntu $(lsb_release -cs) non-free contrib"
            apt update
            apt install insync
            ;;
        18)
            echo "**** Installing htop ****"
            apt install -y htop
            ;;
        19)
            echo "**** Installing Spotify ****"
            curl -sS https://download.spotify.com/debian/pubkey.gpg | \
            apt-key add -
            add-apt-repository -y \
            "deb http://repository.spotify.com stable non-free ****"
            apt update
            apt install -y spotify-client
            ;;
        20)
            echo "**** Installing Papirus icon theme ****"
            add-apt-repository -y ppa:papirus/papirus
            apt update
            apt install -y papirus-icon-theme
            ;;
        21)
            echo "**** Installing Arc KDE theme ****"
            add-apt-repository -y ppa:papirus/papirus
            apt update
            apt install -y --install-recommends arc-kde
            ;;
        22)
            echo "**** Installing Gnome keyring ****"
            apt install gnome-keyring
            ;;
        23)
            echo "**** Installing Pip ****"
            apt install python3-pip
            ;;
        24)
            #FIXME:
            #apt install -y apt-transport-https ca-certificates curl \
            #gnupg-agent software-properties-common
            #curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
            #apt-key add -
            #add-apt-repository \
            #"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
            #$(lsb_release -cs) stable"
            apt install -y docker.io
            #apt install -y docker-ce=5:19.03.9~3-0~ubuntu-focal \
            #docker-ce-cli=5:19.03.9~3-0~ubuntu-focal \
            #containerd.io
            # Post-installation steps
            groupadd docker
            usermod -aG docker ${USER:=$(/usr/bin/id -run)}
            echo "Log out and log back in so that your group membership \
            is re-evaluated"
            # Autostart at boot
            systemctl enable docker
            ;;
        25)
            echo "**** Installing Docker-compose ****"
            curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-Linux-x86_64" \
            -o /usr/bin/docker-compose
            chmod +x /usr/bin/docker-compose
            ;;
        26)
            echo "**** Installing Transmission ****"
            apt install -y transmission
            ;;
        27)
            echo "**** Installing Logitech MX Master mapping ****"
            git clone https://github.com/krovs/mxmaster-mapper-linux.git
            cd mxmaster-mapper-linux
            chmod +x setup.sh
            ./setup.sh
            cd ..            
            rm -r mxmaster-mapper-linux
            ;;
        28)
            echo "**** Generating SSH keys ****"
            ssh-keygen -t rsa -b 4096
            ;;
        29)
            echo "**** Installing Todoist ****"
            snap install todoist
            ;;
        30)
            echo "**** Installing Flameshot ****"
            apt install -y flameshot
            ;;
        31)
            echo "**** Installing traceroute ****"
            apt install -y traceroute
            ;;
    esac
done

neofetch