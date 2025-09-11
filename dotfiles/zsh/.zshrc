#----------------#
# PRE-INIT       #
#----------------#

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#----------------#
# Set Paths      #
#----------------#

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#----------------#
# Theme          #
#----------------#

# Set name of the theme to load or "random" (echo $RANDOM_THEME)
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Random theme pool to use with "random"
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

#----------------#
# OMZ Config     #
#----------------#

# Case sensitive completion
# CASE_SENSITIVE="true"

# Hyphen-insensitive completion
# HYPHEN_INSENSITIVE="true"

# Auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Auto-update frequency (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Disable colors in ls
# DISABLE_LS_COLORS="true"

# Disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Enable command auto-correction.
# ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under VCS as dirty
# This makes repository status check for large repositories much, much faster
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Change the command execution time stamp shown in the history command output.
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd" or see 'man strftime' for details
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

#----------------#
# Plugin Loading #
#----------------#

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
git
# Using FZF instead of normal completions
fzf-tab
zsh-autosuggestions
# Syntax highlighting loads last
zsh-syntax-highlighting
)

#----------------#
# Completions    #
#----------------#

# Load zsh-completions, does not work as plugin
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

#----------------#
# Source OMZ     #
#----------------#

# Starts up OMZ
source $ZSH/oh-my-zsh.sh

#----------------#
# User Conf      #
#----------------#

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

#----------------#
# Alias          #
#----------------#

# Set personal aliases
# Users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias ls="ls --color"
alias vim="nvim"
alias nano="nvim"
alias cls="clear"

#----------------#
# Coloring       #
#----------------#

COLOR_MAIN_LIGHT=81
COLOR_MAIN=75
COLOR_MAIN_DARK=69
COLOR_MAIN_DARKER=68

COLOR_ALT_LIGHT=141
COLOR_ALT=135
COLOR_ALT_DARK=99
COLOR_ALT_DARKER=97

COLOR_OK=119
COLOR_WARN=221

#----------------#
# Keybinds       #
#----------------#

# Keybinds for search history

#----------------#
# History        #
#----------------#

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

#----------------#
# Zstyle         #
#----------------#

# Enables case insensitive completion
zstyle ':completion:*' matcher-list 'm:{A-Za-z}={A-Za-z}'

# Colorful LS
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

#----------------#
# Autocomplete   #
#----------------#

ZSH_HIGHLIGHT_STYLES[command]="fg=${COLOR_MAIN_LIGHT}"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=${COLOR_WARN},bold,underline"
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=${COLOR_ALT_LIGHT},bold"
ZSH_HIGHLIGHT_STYLES[arg0]="fg=${COLOR_MAIN_LIGHT}"
ZSH_HIGHLIGHT_STYLES[suffix-alias]="fg=${COLOR_MAIN_LIGHT},underline"

#----------------#
# Autosuggest    #
#----------------#

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=${COLOR_ALT_DARKER}"
ZSH_AUTOSUGGEST_STRATEGY=(
completion
history
)

bindkey '^ ' autosuggest-accept
bindkey '^e' autosuggest-execute
bindkey '^s' autosuggest-fetch
bindkey '^t' autosuggest-toggle

#----------------#
# Bat (Batcat)   #
#----------------#

export BAT_THEME='Catppuccin Macchiato'
# Fix Debian naming weirdness
if command -v batcat >/dev/null; then
  alias bat=batcat
fi
alias cat=bat

#----------------#
# FD (fd-find)   #
#----------------#

# Fix Debian naming weirdness
if command -v fdfind >/dev/null; then
  alias fd=fdfind
fi

#----------------#
# FZF            #
#----------------#

# Shell Integrations (needs to be loaded before fzf-tab)
# FZF via CtrlR
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
  source /usr/share/fzf/key-bindings.zsh
elif [ -f /usr/share/fzf/examples/key-bindings.zsh ]; then
  source /usr/share/fzf/examples/key-bindings.zsh
elif [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
else
  echo "Unable to locate FZF key-bindings.zsh"
fi

if [ -f /usr/share/fzf/completion.zsh ]; then
  source /usr/share/fzf/completion.zsh
elif [ -f /usr/share/fzf/examples/completion.zsh ]; then
  source /usr/share/fzf/examples/completion.zsh
elif [ -f /usr/share/doc/fzf/examples/completion.zsh ]; then
  source /usr/share/doc/fzf/examples/completion.zsh
else
  echo "Unable to locate FZF completion.zsh"
fi

# Theme (Cattpucchin Macchiato, No BG)
FZF_THEME="\
--color=spinner:#f4dbd6,hl:#ed8796,\
fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6,\
marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

# Reverses the order
FZF_DEFAULT_OPTS="--layout reverse --multi ${FZF_THEME}"

# Using FD instead of Find
FZF_FD_OPTS="--hidden --follow --exclude '.git'"
FZF_DEFAULT_COMMAND="fd ${FZF_FD_OPTS}"
FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
FZF_ALT_C_COMMAND="${FZF_DEFAULT_COMMAND} --type d"

# Preview
FZF_DEFAULT_OPTS+=" --preview '~/.config/functions/fzf-preview.sh {}'"
FZF_CTRL_R_OPTS="--no-preview"

#----------------#
# FZF-Tab        #
#----------------#

# Allow dotfile search
# _comp_options+=(globdots)

# Disable default completion menu
zstyle ':completion:*' menu no

# Set min heigt
zstyle ':fzf-tab:complete:*' fzf-min-height 16

# Set theme
zstyle ':fzf-tab:*' fzf-flags ${FZF_THEME}

# Preview files and directories
zstyle ':fzf-tab:complete:*' fzf-preview '~/.config/functions/fzf-preview.sh $realpath'

# Enable TMUX Popup
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# zstyle ':fzf-tab:*' popup-min-size 64 16

# Enable FZF-Tab
enable-fzf-tab

#----------------#
# Zoxide         #
#----------------#

alias cd=z

eval "$(zoxide init zsh)"

#----------------#
# Other          #
#----------------#

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Setting QEMU vars
export LIBVIRT_DEFAULT_URI="qemu:///system"
