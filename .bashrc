#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias vim=nvim
alias notify-send=twmnc
export TERMINAL=alacritty
set TERMINAL alacritty
PS1='[\u@\h \W]\$ '

