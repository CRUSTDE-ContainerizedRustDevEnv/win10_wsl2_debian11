# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignorespace:ignoredups:erasedups
HISTIGNORE='ls:bg:fg:history'
# Prepend permanently stored commands into history. These are manually maintained, because they are often used.
cat  ~/.bash_history ~/.bash_history_permanent > ~/.bash_history_tmp 2>/dev/null
# deduplicate, but preserve order
awk '!a[$0]++' ~/.bash_history_tmp > ~/.bash_history
rm ~/.bash_history_tmp

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

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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

# Luciano 2023-11-13: I added some commands for my configuration of Debian (for Rust development)
# ~/.bashrc is executed by bash for non-login interactive shells every time.  (not for login non-interactive scripts)
# Append to ~/.bashrc
# Then if you don't want to restart the terminal and use immediately, run
# source ~/.bashrc
# I tried to add this to ~/.bash_profile, but it didn't work well.

alias l="ls -al"
alias ll="ls -l"

# Added to bashrc for easy sshadd and postgres
export PATH=$HOME/bin:$PATH

# region: ssh-agent and sshadd
SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    printf "  \033[33m Starting ssh-agent as in the background (look up with \033[32m'ps -ef'\033[33m)  \033[0m\n"
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;

}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

printf "  \033[33m Use the global command \033[32m'sshadd'\033[33m to simply add your private SSH keys to ssh-agent $SSH_AGENT_PID.  \033[0m\n"
alias sshadd="printf 'sh ~/.ssh/sshadd.sh\n'; sh ~/.ssh/sshadd.sh"

# endregion: ssh-agent and sshadd

# postgresql-client needs this language variables
export LANGUAGE="en_US.UTF-8"
export LC_ALL="C"

# . "$HOME/.cargo/env"

export WASMTIME_HOME="$HOME/.wasmtime"
export PATH="$WASMTIME_HOME/bin:$PATH"

# set nano as my default editor
export VISUAL=nano
export EDITOR="$VISUAL"

# dev_bestia_cargo_completion
complete -C dev_bestia_cargo_completion cargo

# disable XON/XOFF flow control
# because ctrl-s suddenly blocks the terminal
# and nobody knows what really happened. This is unintuitive.
stty -ixon
bind -r "\C-s"  
# disable ctrl-b, because I want VSCode to use it.
bind -r "\C-b"  

# shorten the prompt
export PS1='\[\033[01;32m\]\u@WSL:Debian\[\033[01;34m\]:\W\[\033[00m\]\$ '

printf "  \033[33m The container CRUSTDE must be initialized once after reboot and then follow instructions: \033[0m\n"
printf "\033[32m sshadd crustde \033[33m\n"
printf "\033[32m sh ~/rustprojects/crustde_install/crustde_pod_after_reboot.sh \033[0m\n"
