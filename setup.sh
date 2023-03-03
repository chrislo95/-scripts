#!/bin/bash

sudo apt update && sudo apt dist-upgrade -y

sudo apt install git curl wget ssh

# Sets my git account
myemail = "92557089+chrislo95@users.noreply.github.com"
git config --global user.name "$USER"
git config --global user.email "$myemail"

git config --global init.defaultBranch main
git config --global color.ui auto

git config --global pull.rebase false

# Test user name and user email

if [ git config --get user.name -eq $USER ] 
then 
    echo "looks good"
    exit 0
else
    echo "looks bad"
    exit 1
fi    

if [ git config --get user.name -eq $myemail ]
then
    echo "looks good"
    exit 0
else
    echo "looks bad"
    exit 2
fi

# Checks for the ssh key
ls ~/.ssh/id_ed25519.pub
if [ !echo $? -eq 0 ]
then
    ssh-keygen -t ed25519 -C $myemail
else
    "Looks good"
    exit 0
fi 

# Check for the file again 
cat ~/.ssh/id_ed25519.pub

# check if nmap is already installed
if [ -f /usr/bin/nmap ]
then
    echo "Nmap is already installed"
else
    echo "Nmap not found. Will install now..."
    sleep 0.3
    sudo apt install nmap
fi

# install zsh if it is not there
if [ -f /usr/bin/zsh ]
then
    echo "Zsh is already installed"
else
    echo "Zsh not found. Will install now..."
    sleep 0.3
    sudo apt install zsh
fi

# Gets oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# it's gonna ask for password


# Install zsh plug-ins
# zsh-autosuggestion plug in
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

sleep 0.3

# zsh-highlighting plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

sleep 0.3

# fzf install
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

sleep 0.3

# sets the zshr with the new plugins
mylinenumber=$(sed -n '/plugins=(git/=' /home/$USER/.zshrc)
sed -i '$mylinenumber r plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf)' /home/$USER/.zshr

