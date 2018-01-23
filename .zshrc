# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
	source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

bindkey -v
bindkey '^R' history-incremental-search-backward 

set -o vi
export EDITOR=vim
export VISUAL=vim
alias git='noglob git'
alias curl='noglob curl'
