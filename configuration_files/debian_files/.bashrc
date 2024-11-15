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

# .bashrc is used by git-bash.exe to start a session
# Here we start ssh-agent.exe in a background process that is accessible from windows.
# It is used by ssh client, git and VSCode remote extension.

# Luciano 2024-03-17: I added some commands for my configuration of git-bash (for Rust development)
# ~/.bashrc is executed by bash for non-login interactive shells every time.  (not for login non-interactive scripts)

alias l="ls -al"
alias ll="ls -l"

# region: ssh-agent and sshadd

env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" | /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; printf $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    printf "  \033[33m Starting ssh-agent as a windows process in the background... \033[0m\n"
    printf "  \033[33m Look up process in Task Manager \033[32m'powershell -Command \"Start-Process taskmgr -Verb RunAs\"' \033[0m\n"
    agent_start
    # printf "Setting Windows SSH user environment variables (pid: $SSH_AGENT_PID, sock: $SSH_AUTH_SOCK)\n"
    setx SSH_AGENT_PID "$SSH_AGENT_PID" > /dev/null
    setx SSH_AUTH_SOCK "$SSH_AUTH_SOCK" > /dev/null
fi

printf "  \033[33m Use this script to simply add your private SSH keys to ssh-agent $SSH_AGENT_PID: \033[0m\n"
printf "\033[32m sshadd \033[33m\n"

alias sshadd="printf 'sh ~/.ssh/sshadd.sh\n'; sh ~/.ssh/sshadd.sh"

# endregion: ssh-agent and sshadd

printf " \n"

unset env

# set nano as my default editor
export VISUAL=nano
export EDITOR="$VISUAL"

# shorten the prompt
export PS1='\[\033[01;35m\]\u@git-bash\[\033[01;34m\]:\W\[\033[00m\]\$ '

printf "  \033[33m The container CRUSTDE must be initialized once after reboot and follow instructions: \033[0m\n"
printf "\033[32m MSYS_NO_PATHCONV=1 wsl sh /home/luciano/rustprojects/crustde_install/crustde_pod_after_reboot.sh \033[0m\n"
