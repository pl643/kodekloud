#### bashrc.kk ####

# File is intended to be sourced from .bashrc
# Aliases and bash options

# Bash options
shopt -s autocd  # allows changing folder without the cd command, just type folder name.
set -o vi
bind '";;":vi-movement-mode'

# Aliases
alias ssh='ssh -o "StrictHostKeyChecking no"'
alias sd='sudo'
alias s='ls -F'    # short ls
alias h='cd ~'
alias b='cd -'
alias sa='ls -AF'
alias l='ls -lF'   # long ls
alias la='ls -lAF'
alias a1='ssh  stapp01 -l tony'
alias a2='ssh stapp02 -l steve'
alias a3='ssh stapp03 -l banner'
alias l1='ssh stlb01 -l loki'
alias d1='ssh stdb01 -l peter'
alias s1='ssh ststor01 -l natasha'
alias b1='ssh stbkp01 -l clint'
alias m1='ssh stmail01 -l groot'
