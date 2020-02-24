#!/bin/bash
###############################################################################################################
#   Filename: .bashrc                                                                                         #                                                          #
#                                                                                                             #
#                                                                                                             #
# Sections:                                                                                                   #
#   01. NonInteractive handling                                                                               #
#   02. History                                                                                               #
#   03. Some good mods                                                                                        #
#   04. Prompt Customization                                                                                  #
#   05. Aliases                                                                                               #
#   06. Completion                                                                                            #
#   07. Extras                                                                                                #
###############################################################################################################

###############################################################################################################
# 01. Non-Interactive Handling                                                                                #
###############################################################################################################

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

###############################################################################################################
# 02. History                                                                                                 #
###############################################################################################################

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# Append to the history file, don't overwrite it
shopt -s histappend
# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

###############################################################################################################
# 03. Some good Mods                                                                                          #
###############################################################################################################

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar
# Autocorrect typos in cd
shopt -s cdspell
# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


export EDITOR="vim"
###############################################################################################################
# 04. Prompt Customization                                                                                    #
###############################################################################################################

# Colors
txtblk='\[\e[0;30m\]' # Black - Regular
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;33m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;36m\]' # Cyan
txtwht='\[\e[0;37m\]' # Light Gray
litblk='\[\e[0;90m\]' # Black(Dark Gray) - Light
litred='\[\e[0;91m\]' # Red
litgrn='\[\e[0;92m\]' # Green
litylw='\[\e[0;93m\]' # Yellow
litblu='\[\e[0;94m\]' # Blue
litpur='\[\e[0;95m\]' # Purple
litcyn='\[\e[0;96m\]' # Cyan
litwht='\[\e[0;97m\]' # White
bldblk='\[\e[1;30m\]' # Black - Bold (actually light)
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldblu='\[\e[1;34m\]' # Blue
bldpur='\[\e[1;35m\]' # Purple
bldcyn='\[\e[1;36m\]' # Cyan
bldwht='\[\e[1;37m\]' # White
dimblk='\[\e[2;30m\]' # Black - Bold (actually light)
dimred='\[\e[2;31m\]' # Red
dimgrn='\[\e[2;32m\]' # Green
dimylw='\[\e[2;33m\]' # Yellow
dimblu='\[\e[2;34m\]' # Blue
dimpur='\[\e[2;35m\]' # Purple
dimcyn='\[\e[2;36m\]' # Cyan
dimwht='\[\e[2;37m\]' # White
undblk='\[\e[4;30m\]' # Black - Underline
undred='\[\e[4;31m\]' # Red
undgrn='\[\e[4;32m\]' # Green
undylw='\[\e[4;33m\]' # Yellow
undblu='\[\e[4;34m\]' # Blue
undpur='\[\e[4;35m\]' # Purple
undcyn='\[\e[4;36m\]' # Cyan
undwht='\[\e[4;37m\]' # White
bakblk='\[\e[40m\]'   # Black - Background
bakred='\[\e[41m\]'   # Red
bakgrn='\[\e[42m\]'   # Green
bakylw='\[\e[43m\]'   # Yellow
bakblu='\[\e[44m\]'   # Blue
bakpur='\[\e[45m\]'   # Purple
bakcyn='\[\e[46m\]'   # Cyan
bakwht='\[\e[47m\]'   # White
txtrst='\[\e[0m\]'    # Text Reset

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# Comment for a non-colored prompt, if the terminal has the capability; turned
# Off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

# Check if we have color-support
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

# Custom colors for prompt
if [ "$color_prompt" = yes ]; then
  #PROMPT_COMMAND='RET=$?; if [ $RET != 0 ]; then echo "rc: $RET"; fi; if [ $( ls -A | wc -l ) -lt 5 ]; then echo; ls -mF; fi'
  PROMPT_COMMAND="history -a"                            # New tabs have all history
  PS1="${debian_chroot:+($debian_chroot)}"               # For debian
  #PS1="${PS1}[\#] "                                     # Which number prompt
  PS1="${PS1}$txtgrn\u$txtrst:"                          # Username in green color appended
  PS1="${PS1}$litblu\W"                                  # Working directory in dim blue color appended
  PS1="${PS1}$litylw\\$ $txtrst"                         # Added $ prompt in light yellow color
  PS2="$litylw > $txtrst"                                # Colored secondary prompt
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '    # Useless normal prompt
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



###############################################################################################################
# 05. Aliases                                                                                                 #
###############################################################################################################

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
if [ -f ~/.exports ]; then
  . ~/.exports
fi

###############################################################################################################
# 06. Completion                                                                                              #
###############################################################################################################

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

###############################################################################################################
# 07. Extras        

[[ $- = *i* ]] && source ~/.liquidprompt/liquidprompt



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

