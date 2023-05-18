#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
alias vim="nvim"
alias sudo="sudo " # make sudo check for aliases too
complete -cf sudo
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
eval "kitty @ set-colors -c $HOME/.config/base16-kitty/colors/$(cat $HOME/.base16_theme).conf"
