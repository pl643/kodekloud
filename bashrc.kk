#### bashrc.kk ####

# File is intended to be sourced from .bashrc
# Aliases and bash options

# Bash options/bindings
shopt -s autocd  # allows changing folder without the cd command, just type folder name.
set -o vi
bind '";;":vi-movement-mode'
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

SSHOPT="-o userknownhostsfile=/dev/null -o StrictHostKeyChecking=no -o LogLevel=quiet"  # these options prevent prompting
export EDITOR='[ -f ~/init.vim ] || curl -Os https://raw.githubusercontent.com/pl643/kodekloud/main/init.vim && nvim -u ~/init.vim'
passwordfile="passwords"

# Aliases
alias ssh="ssh $SSHOPT"
alias sd='sudo'
alias s='ls -F'    # short ls
alias h='cd ~'
alias b='cd -'
alias e="$EDITOR"
alias sa='ls -AF'
alias ht='history'
alias l='ls -lF'   # long ls
alias la='ls -lAF'
alias a1='ssh stapp01 -l tony'
alias a2='ssh stapp02 -l steve'
alias a3='ssh stapp03 -l banner'
alias l1='ssh stlb01 -l loki'
alias d1='ssh stdb01 -l peter'
alias s1='ssh ststor01 -l natasha'
alias b1='ssh stbkp01 -l clint'
alias m1='ssh stmail01 -l groot'
alias ta='tmux -2 -f ~/tmux.conf attach'
alias tn='tmux -2 -f ~/tmux.conf'
alias t='[ -f ~/tmux.conf ] || curl -Os https://raw.githubusercontent.com/pl643/kodekloud/main/tmux.conf && tmux -2 -f ~/tmux.conf attach || tmux -2 -f ~/tmux.conf'
