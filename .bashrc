# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


GRADLE_HOME=/opt1/soft/java/gradle-1.10
CXF_HOME=/opt1/soft/java/apache-cxf-2.7.4
JAVA_HOME=/opt1/soft/java/jdk1.8.0
MAVEN_PATH=/opt1/soft/java/apache-maven-3.2.1
NODE_BASE_PATH=/opt1/soft/node-v0.10.32-linux-x64
NODE_PATH=$NODE_PATH:npm

PATH=\
$GRADLE_HOME/bin:\
$NODE_BASE_PATH/bin:\
~/node_modules/.bin/:\
$JAVA_HOME/bin:\
/opt1/soft/doctorjs/bin:\
$MAVEN_PATH/bin:\
$CXF_HOME/bin:\
$HOME/.bin:\
$HOME/.local/bin:\
:$PATH



ANDROID_HOME=/opt1/soft/adt-bundle-linux-x86_64-20131030/sdk

export NODE_PATH=${NODE_BASE_PATH}:/usr/local/lib/jsctags:${NODE_BASE_PATH}/bin:${NODE_BASE_PATH}/lib/node_modules

alias cd_mbg='cd ~/work/netM/mbg'
alias cd_mbg_uk='cd ~/work/netM/mbg/mbg-extern-ukthree3api'
alias cd_mbg_fr='cd ~/work/netM/mbg/mbg-extern-frbouyguesisis'
alias cd_mbg_swiss='cd ~/work/netM/mbg/mbg-extern-chswisscomce'
alias cd_mbg_at='cd ~/work/netM/mbg/mbg-extern-atdcb3vasbilling'
alias cd_pg='cd ~/work/GTM/gae-gtm-pg'

alias cd_symos='cd ~/work/altom_symos/symos-server'

export EDITOR=vim
alias svnkdiff='svn diff --diff-cmd kdiff3'
alias cd_gcb='cd ~/work/netM/GCB/'


export CXF_HOME JAVA_HOME MAVEN_PATH NODE_PATH ANDROID_HOME GRADLE_HOME

# with source-highlight package it makes syntax colouring for source code
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '
export TERM="xterm-256color"



PA_PID=$( pgrep pulseaudio -U $(id -u) )
if [ -z $PA_PID ]; then
  echo "Pulseaudio not running - starting new instance per-user"; 
  pulseaudio -D;
#else 
  #echo "Pulseaudio already running with pid=$PA_PID";
fi



