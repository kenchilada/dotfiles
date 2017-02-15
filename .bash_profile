# .bash_profile
#
# Runs only for login shells.  If you want commands to run for both login and
# non-login shells, put them in .bashrc instead of here.
#

## pull in aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

## user specific environment and startup programs
export PATH=$HOME/bin:$PATH
export PERL5LIB=~/perllib/lib/perl5/site_perl/5.8.8

# require two ^D sequences to logout instead of one
export IGNOREEOF=1

# enable this to use screen by default upon logon
#exec screen -RR

#export GIT_SSL_CAINFO="${HOME}/certs/cacert.pem"

## only ask for my SSH key passphrase once!
#use existing ssh-agent if possible
if [ -f ${HOME}/.ssh-agent ]; then
   . ${HOME}/.ssh-agent > /dev/null
fi
if [ -z "$SSH_AGENT_PID" -o -z "`/usr/bin/ps -a|/usr/bin/egrep \"^[ ]+$SSH_AGENT_PID\"`" ]; then
   /usr/bin/ssh-agent > ${HOME}/.ssh-agent
   . ${HOME}/.ssh-agent > /dev/null
fi
[ -z "$SSH_AGENT_PID" ] && ssh-add ~/.ssh/id_rsa

# todo@ken: could use below if we had a way to detect if we are running in mintty
## ssh-pageant
# nice for mintty.exe, authenticate against pageant.exe
# 
# https://github.com/cuviper/ssh-pageant
#
#SOCKDIR=$(cygpath ${LOCALAPPDATA})
#echo sockdir is $SOCKDIR
#if [ -d ${SOCKDIR} ]; then
#	echo found sockdir
#	eval $(/usr/bin/ssh-pageant -r -a "${SOCKDIR}/ssh-pageant-$USERNAME.sock")
#fi


