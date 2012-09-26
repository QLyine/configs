# Some is take from spider's zshrc, some from meqif's and
# guckes's zshrc. Some stuff is totally random. Most of this mutated
# over time and eventually went to separate files, like xterminus has.
 
#Load the super duper completion stuff
autoload -U compinit
compinit
 
# Prompt
autoload -U promptinit
promptinit

autoload -U zmv

# SCREENDIR will screw screen up
unset SCREENDIR
 
# Make sure no cores can be dumped while zsh is in charge. I don't know if
# this limit thing uses ulimit or what, but it seems to work..
limit coredumpsize 0
 
# History things
HISTFILE=$HOME/.zsh/history
SAVEHIST=500
HISTSIZE=800
TMPPREFIX=/tmp

. ~/.zsh/function
. ~/.zsh/completion
. ~/.zsh/zstyle
. ~/.zsh/aliases
. ~/.zsh/exports
. ~/.zsh/terms
. ~/.zsh/prompt
. ~/.zsh/opts
 
 
