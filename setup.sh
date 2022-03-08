function brew_install {
  echo 'Installing brew + tools'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  cat $PWD/.brew | xargs -I {} brew install {}
  cat $PWD/.brew-cask | xargs -I {} brew install --cask  {}
}

function configure_zsh {
  echo 'Installing prezto and configuring zsh'
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  for rcfile in $(find "${ZDOTDIR:-$HOME}/.zprezto/runcoms" -maxdepth 1 -type f ! -name README.md -exec basename {} \;); do
    ln -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/$rcfile" "${ZDOTDIR:-$HOME}/.$rcfile"
  done
  rm "${ZDOTDIR:-$HOME}/.zshrc"
  ln -s $PWD/.zshrc "${ZDOTDIR:-$HOME}/.zshrc"
  rm "${ZDOTDIR:-$HOME}/.zpreztorc"
  ln -s $PWD/.zpreztorc "${ZDOTDIR:-$HOME}/.zpreztorc"
}

function setup_tmux {
  echo 'Setting up tmux'
  ln -s $PWD/.tmux.conf $HOME
}

function setup_vim {
  echo 'Setting up vim'
  mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  ln -s $PWD/.vimrc $HOME
  vim +PluginInstall +qall
}

function set_zsh_as_default_shell {
  chsh -s /bin/zsh
}

function configure_git {
  echo 'Configuring git'
  git config --global pull.rebase true
  git config --global log.decorate=short
}

function configure_osx {
  defaults write -g InitialKeyRepeat -int 10
  defaults write -g KeyRepeat -int 1
  defaults write com.apple.AppleMultitouchTrackpad Clicking 1
  defaults write com.apple.dock autohide 1
  defaults write -g ApplePressAndHoldEnabled -bool false
}

#configure_git
#brew_install
#configure_zsh
#set_zsh_as_default_shell
#setup_tmux
#setup_vim
configure_osx
