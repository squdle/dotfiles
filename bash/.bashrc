#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set python to user sandbox (set before prompt as this modifies PS1)
source ~/python/venv/bin/activate

# PROMPT
# ======
# Set the value of PS1

nested_shell_name ()
{
  # Returns the location of the current nested shell or none.
  echo $0 | grep -v "-"
}

git_current_branch ()
{
  # Returns the current git branch.
  git branch 2> /dev/null | grep '*' | python -c \
  "import sys; x=sys.stdin.read().replace('* ', '*').rstrip(); print(x)" 2>/dev/null
}

# Set up some prompts that may be switched at runtime.
PS1_DEFAULT='[\u@\h \W]\$ '
PS1A="$ "
PS1B="$PS1_DEFAULT"
_PROMPT_COMMAND_1='PS1="$(whoami)@$(hostname):$(basename $(pwd))$(git_current_branch) $ "'
_PROMPT_COMMAND_2='PS1="$(whoami)@$(hostname):$(pwd)$(git_current_branch) - $( date +"%Y-%m-%d %H:%M")\n$ "'
_PROMPT_COMMAND_3='PS1="($(nested_shell_name)) $(whoami)@$(hostname):$(pwd)$(git_current_branch) - $( date +"%Y-%m-%dT%H%M%S")\n$ "'

# switch prompt aliases
alias p='PS1=${PS1A} PROMPT_COMMAND=""'
alias pp='PS1=${PS1B} ; PROMPT_COMMAND=""'
alias P='PROMPT_COMMAND=${_PROMPT_COMMAND_1}'
alias PP='PROMPT_COMMAND=${_PROMPT_COMMAND_2}'
alias PPP='PROMPT_COMMAND=${_PROMPT_COMMAND_3}'
alias ppp='P'
alias ppp='PP'
alias ppp='PPP'

# Use prompt command with fallback to PS1.
PROMPT_COMMAND=$_PROMPT_COMMAND_2
PS1=$PS1A

# DOTFILE EDITS
# =============
alias rc='source ~/.bashrc'
alias vrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'

# ALIASES
# =======
alias ls='ls --color=auto'
alias ll='ls --color=auto -la'
alias l='ls'
alias v='vim'
alias g='git'

alias wifimenu="termite -e 'sudo wifi-menu -o'"
