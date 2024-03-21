#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias la='ls -la'
alias grep='grep --color=auto'
alias pacman='pacman --color=auto'
alias paru='paru --color=auto'
PS1='[\u@\h \W]\$ '
alias vim="nvim"
alias sudo="sudo " # make sudo check for aliases too
# alias mc="source ranger" # use /bin/ranger so that q exits to current dir
function mc() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

complete -cf sudo
alias dotfiles='/usr/bin/git --git-dir=$HOME/projects/dotfiles/ --work-tree=$HOME'
export PATH=$HOME/.local/bin:/opt/cuda/bin:$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
#PS1="\n\[\033[1;37m\]\342\224\214($(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;34m\]\u@\h'; fi)\[\033[1;37m\])\342\224\200(\$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\]\342\234\223\"; else echo \"\[\033[01;31m\]\342\234\227\"; fi)\[\033[1;37m\])\342\224\200(\[\033[1;34m\]\@ \d\[\033[1;37m\])\[\033[1;37m\]\n\342\224\224\342\224\200(\[\033[1;32m\]\w\[\033[1;37m\])\342\224\200(\[\033[1;32m\]\$(ls -1 | wc -l | sed 's: ::g') files, \$(ls -sh | head -n1 | sed 's/total //')b\[\033[1;37m\])\342\224\200> \[\033[0m\]"

PS1="\[\033[0;38;2;248;248;244m\]┌─[\[\033[0;38;2;188;190;254m\]\u\[\033[0;38;2;147;155;178m\]@\[\033[0;38;2;245;194;231m\]\h\[\033[0;38;2;248;248;244m\]\$([[ \$? != 0 ]] && echo \"[\[\033[0;38;2;245;82;95m\]✘\[\033[0;38;2;248;248;244m\]]\")─[\[\033[0;38;2;166;227;161m\]\w\[\033[0;38;2;248;248;244m\]]\n\[\033[0;38;2;248;248;244m\]└──╼ \[\033[0m\]"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

/usr/bin/keychain  --noask --nogui --agents ssh -Q -q --timeout 420 $HOME/.ssh/id_ed25519
[ -f $HOME/.keychain/$HOSTNAME-sh ] && source $HOME/.keychain/$HOSTNAME-sh

[[ "$TERM" == "xterm-kitty" ]] && alias ssh="TERM=xterm-256color ssh"
