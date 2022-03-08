#!/bin/bash

yay -S moreutils
yay -S yay-bin
yay -S firefox
yay -S gvim
yay -S tree
xcape -e 'Caps_Lock=Escape'
yay -S --needed base-devel
yay -S xclip
yay -S xorg-xclipboard
yay -S pulseaudio
yay -S pulseaudio-jack
yay -S pulseaudio-bluetooth
yay -S pamixer
yay -S pavucontrol
yay -S xfce4-terminal
yay -S wavpack
yay -S openvpn
yay -S flameshot
yay -S jq
yay -S fd
yay -S keybase-bin
yay -S i3-swallow


yay -S openssh
yay -S physlock
yay -S kubectx
yay -S kubectl
yay -S zip
yay -S gnome-keyring
yay -S python2
yay -S xss-lock
npm config set python /usr/bin/python2

function install_nvm {
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
}

function install_dependencies {
 echo 'Installing dependencies' 
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


#function configure_bash {
#  cat << EOF >> ~/.bashrc
## make tab cycle through commands after listing
#bind '"\t":menu-complete'
#bind "set show-all-if-ambiguous on"
#bind "set completion-ignore-case on"
#bind "set menu-complete-display-prefix on"
#
## use vi mode
#set -o vi
#
## Setting fd as the default source for fzf
#export FZF_DEFAULT_COMMAND='fd --type f'
#
## To apply the command to CTRL-T as well
#export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#EOF
#}

setup_tmux
setup_vim
configure_git
# ln -s ~/.dotfiles/00-keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf
# ln -s ~/.dotfiles/i3.config ~/.config/i3/config 
