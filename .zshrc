HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000

autoload -U compinit promptinit
compinit
promptinit

# This will set the default prompt to the walters theme
prompt walters

source ~/.includes/aliases
source ~/.includes/exports
source ~/.includes/colors

source ~/.scripts/functions.sh
