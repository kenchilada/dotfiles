# .bash_profile
#
# Runs only for login shells.  If you want commands to run for both login and
# non-login shells, put them in .bashrc instead of here.
#

# capture subshell depth (do this before PS1)
SSDEPTH=$(($(pstree -s $$ | sed -r 's/-+/\n/g' | grep -Ec '\<(bash|zsh|sh|dash|ksh|csh|tcsh)\>') - 1))

for file in ~/.{extra,bash_prompt,exports,aliases,functions};
do
	[ -r "$file" ] && source "$file"
done
unset file

# here's LS_COLORS
# github.com/trapd00r/LS_COLORS
#command -v gdircolors >/dev/null 2>&1 || alias gdircolors="dircolors"
if which dircolors > /dev/null; then
	eval "$(dircolors -b ~/.dircolors)"
fi

## user specific environment and startup programs
export PATH=$HOME/bin:$HOME/.local/bin:$PATH
export PERL5LIB=~/perllib/lib/perl5/site_perl/5.8.8

# require two ^D sequences to logout instead of one
export IGNOREEOF=1

# enable this to use screen by default upon logon
#exec screen -RR

# see .gitconfig 'http.sslCAinfo' for notes on this
export GIT_SSL_CAINFO="${HOME}/certs/ca-bundle.crt"

# start ssh-agent
SSHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s"
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
	eval `$SSHAGENT $SSHAGENTARGS`
	trap "kill $SSH_AGENT_PID" 0
fi

export LESSHISTFILE="/dev/null"

# use vi-style movement keys in shell
set -o vi

export EDITOR="vim"

### external
export TERRAGRUNT_AUTO_INIT=false
export COMPOSER_NO_AUDIT=1
export TERMINUS_HIDE_GIT_MODE_WARNING=1

# NVM config
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load Angular CLI autocompletion.
if command -v ng 2>&1 >/dev/null
then
	source <(ng completion script)
fi

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Correct spelling errors in arguments supplied to cd
shopt -s cdspell;

# Autocorrect on directory names to match a glob.
shopt -s dirspell 2> /dev/null

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Enable tab completion for `g` by marking it as an alias for `git`
if type __git_complete &> /dev/null; then
    __git_complete g __git_main
fi;

# for fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

