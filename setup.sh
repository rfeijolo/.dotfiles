#!/bin/bash

function update_packages {
  sudo apt update
  sudo apt upgrade -y
}

function install_dev_tools {
  sudo apt install vim-gnome -y
  sudo apt install git -y
  sudo apt install gnome-tweak-tool -y
  sudo apt install tmux -y
  sudo apt install curl -y
  sudo apt install xclip -y
  sudo apt install golang-go -y
  sudo apt install openvpn easy-rsa -y
  sudo apt install python python-pip -y
  sudo apt install libpq-dev -y
  sudo apt install apt-transport-https ca-certificates software-properties-common -y
  pip install awscli --upgrade --user
}

function install_fzf {
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
}

function install_spotify {
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt-get update
  sudo apt-get install spotify-client -y
}

function install_enpass {
  wget -O - https://dl.sinew.in/keys/enpass-linux.key | sudo apt-key add -
  echo "deb http://repo.sinew.in/ stable main" | sudo tee /etc/apt/sources.list.d/enpass.list
  sudo apt-get update
  sudo apt-get install enpass -y
}

function install_nvm {
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
}

function setup_tmux {
  echo 'Setting up tmux'
  ln -s $PWD/.tmux.conf $HOME
}

function setup_vim {
  echo 'Setting up vim'
  mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
  mkdir -p ~/.vim/backup
  mkdir -p ~/.vim/swap
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  git clone git://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
  ln -s $PWD/.vimrc $HOME
  vim +PluginInstall +qall
}

function configure_git {
  echo 'Configuring git'
  git config --global pull.rebase true
  git config --global log.decorate=short
}

function install_docker {
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get update
  sudo apt-get install docker-ce -y
  sudo gpasswd -a $USER docker
  newgrp docker
  sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

function install_fd {
  curl -o /tmp/fd -L https://github.com/sharkdp/fd/releases/download/v7.0.0/fd_7.0.0_amd64.deb
  sudo dpkg -i /tmp/fd
}

update_packages
install_dev_tools
install_spotify
install_enpass
install_nvm
install_fzf
setup_tmux
setup_vim
configure_git
install_docker
install_fd
