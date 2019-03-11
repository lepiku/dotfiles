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
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
# added by Anaconda3 5.3.0 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/home/dimas/Programs/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/home/dimas/Programs/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/dimas/Programs/anaconda3/etc/profile.d/conda.sh"
##        CONDA_CHANGEPS1=false
        conda activate base
    else
		echo "it exports it"
        \export PATH="/home/dimas/Programs/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
conda activate std

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/dimas/.sdkman"
[[ -s "/home/dimas/.sdkman/bin/sdkman-init.sh" ]] && source "/home/dimas/.sdkman/bin/sdkman-init.sh"

# add snap applications to terminal
PATH="/snap/bin:$PATH"

# alias for remove to trash = rmtt
alias rmtt="gio trash"

# function to rename multiple files
rename() {
	for s in $1*
	do
		mv "$s" "${s/$1/$2}"
	done
}

# django key
export django_SECRET_KEY_1='7Z!2ff)&+=-wf9=kc^+po$c1#)a6r^hh0w#k6cosd81x#-1@zl9'

# it-force settings
export SECRET_KEY='!vvs2qy%@p1#9xyq1w=k@2_xxsv%(71mmzd1=2$p8rqhwz$)t)'
export ALLOWED_HOSTS='127.0.0.1'

# kawung functions
alias kawung='ssh muhammad.oktoluqman@kawung.cs.ui.ac.id'
# kawung mount with sshfs
kawung-mount() {
	if [ ! "$(ls -A ~/kawung)" ]; then
		sshfs muhammad.oktoluqman@kawung.cs.ui.ac.id:/home/fasilkom/mahasiswa/m/muhammad.oktoluqman/ ~/kawung/
	else
		echo "kawung: already mounted"
	fi

	cd ~/kawung/
}
# kawung unmount with fusermount
kawung-unmount() {
	if [ "$(ls -A ~/kawung)" ]; then
		fusermount -u ~/kawung/
	else
		echo "kawung: is not mounted"
	fi
}

# alias for update ubuntu
alias update='sudo apt update && sudo apt upgrade'

# so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

# fzf plugin settings
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='find -maxdepth 8 -type f 2> /dev/null'
export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'
export FZF_ALT_C_COMMAND='find -maxdepth 8 -type d 2> /dev/null'

# alias for home navigation
alias ~='cd ~'
alias ..='cd ..'

