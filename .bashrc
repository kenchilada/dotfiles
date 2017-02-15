# ~/.bashrc: executed by bash(1) for non-interactive, non-login shells.
#
# Put functions and aliases here.  For examples, see:
# 	/usr/share/doc/bash/examples/startup-files
#
######
######
#
# A bash shell may be a login shell, and may or may not be interactive.  A login
# shell is prefixed with a hyphen (look for "-bash" in ps output for example).
# A shell is interactive if it responds to your input (stdin) and displays
# output (to stdout).
#
# When bash runs as an interactive login shell, or as a non-interactive shell
# with the --login option, it reads and executes "/etc/profile" and then tries
# to find and execute "~/.bash_profile", "/.bash_login", "~/.profile" in order,
# stopping after the first that is found.
#
# When an interactive shell that is not a login shell is started, bash tries to
# execute "~/.bashrc".
#
# When run non-interactively, bash will check $BASH_ENV for the name of a file
# to read and execute.  Shell expansion is performed on the value first.
#
# If bash is run as 'sh', it mimics legacy sh behavior and tries to find and
# execute "/etc/profile" and then "~/.profile".  Bash then checks for $ENV and
# will treat its value as a file to read and execute.  Bash enters posix mode.
#
# If bash started in posix mode, $ENV is checked but no startup files are read.
#
######

export LESSHISTFILE="/dev/null"
export EDITOR="vim"

# try to figure out if we are a screen subshell
LSHLVL="$SHLVL"
if [ "$TERM" == "screen-bce" ]; then
	(( LSHLVL-- ))
fi

# use vi-style movement keys in shell
set -o vi

# user specific aliases and functions
alias vi=vim
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ls='ls --color'
alias ll='ls -l --color'

#export MANPAGER='col -b | ~/bin/vimman'

# this is why Sun sucks
alias vboxmanage='VBoxManage --nologo'

VIMVER=`vim --version|head -n 1| awk '{print $5}'|sed 's/\.//'`
alias vess="/usr/share/vim/vim${VIMVER}/macros/less.sh"
#export PAGER='vimpager'
#alias less=$PAGER

# possibly colorize things
#if [ "$TERM" != "dumb" ]; then
#	# this first one sets $LS_COLORS
#	if [ $(which dircolors) ]; then
#		eval "`dircolors -b`"
#	fi
#	alias ls='ls --color=auto'
#	if [ `grep -m 1 --color : /etc/passwd &>/dev/null && test $? -eq 0 && echo 1` ]; then
#		alias grep='grep --color'
#	fi
#fi

# returns true if we are in a vim subshell; MYVIMRC is not defined
# if no .vimrc was found
pid_is_vim()
{
	PID="$1"
	CMD=`ps -p $PID -o comm=`

	if [ "$CMD" == "vim" ]; then
		return 0
	fi
	return 1
}

# source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#NOCOLOR="\[\033[0m\]"
#LIGHT_WHITE="\[\033[1;37m\]"
#WHITE="\[\033[0;37m\]"
#GRAY="\[\033[1;30m\]"
#BLACK="\[\033[0;30m\]"
#
#RED="\[\033[0;31m\]"
#LIGHT_RED="\[\033[1;31m\]"
#GREEN="\[\033[0;32m\]"
#LIGHT_GREEN="\[\033[1;32m\]"
#YELLOW="\[\033[0;33m\]"
#LIGHT_YELLOW="\[\033[1;33m\]"
#BLUE="\[\033[0;34m\]"
#LIGHT_BLUE="\[\033[1;34m\]"
#MAGENTA="\[\033[0;35m\]"
#LIGHT_MAGENTA="\[\033[1;35m\]"
#CYAN="\[\033[0;36m\]"
#LIGHT_CYAN="\[\033[1;36m\]"

function XCOLOR () { echo -ne "\[\033[38;5;$1m\]"; }

# set a prompt to super fancy
#export PS1="\[[\e[36;1m\]\u@\h \[\e[34m\]\t\[\e[0m\] \[\e[33m\]\W\[\e[0m\]](${LSHLVL})$ \[\e[0m\]"
#export PS1="`EXT_COLOR 172`[\u@\h \W]\$${NO_COLOUR} "
PS1="[`XCOLOR 172`\u@\h `XCOLOR 39`\t${NOCOLOR} `XCOLOR 220`\W${NOCOLOR}](${LSHLVL})$ ${NOCOLOR}"
export PS1

## check if this is a login shell.  require that 'logout' command be used to exit
## shell instead of 'exit' if we are in a login shell.  this is to prevent
## accidental logout in cases where we forget we are in a subshell
if shopt -q login_shell; then
    enable -n exit
    echo ">>> this is a login shell; use logout to end session"
	alias exit="echo 'this is a login shell, use logout instead if you really want to exit session'"
else
	if [[ "$-" == *i* ]]; then
		pid_is_vim $PPID
		if [ $? -eq 0 ]; then
			echo ">>> this looks like a Vim subshell (depth $SHLVL); use exit to return to the editor"
			PS1="[vim:${PPID}]${PS1}"
		else
			echo ">>> this is a non-login shell; use exit to end session"
		fi
		echo
	fi
    enable exit
fi

beans() {
	echo "I LOVE BEANS"
}
