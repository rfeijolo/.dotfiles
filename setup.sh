#!/bin/bash

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
  git config --global alias.hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
  git config --global alias.lol "log --graph --decorate --pretty=oneline --abbrev-commit --all"
}

function install_docker {
#  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
#  sudo apt-get update
#  sudo apt-get install docker-ce -y
  sudo gpasswd -a $USER docker
  newgrp docker
  sudo curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}


function install_kubectl {
  sudo apt-get update && sudo apt-get install -y apt-transport-https
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
  sudo apt update
  sudo apt install -y kubectl
}

function configure_bash {
  cat << EOF >> ~/.bashrc
# make tab cycle through commands after listing
bind '"\t":menu-complete'
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"
bind "set menu-complete-display-prefix on"

# use vi mode
set -o vi

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
EOF
}

function install_peek {
  sudo add-apt-repository ppa:peek-developers/stable
  sudo apt-get update
  sudo apt-get install peek
}

setup_vim
ln -ls /etc/X11/xorg.conf.d/00-keyboard.conf ~/.dotfiles/00-keyboard.conf
ln -ls ~/.config/i3/config ~/.dotfiles/i3.config
