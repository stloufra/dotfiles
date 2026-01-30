# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export EDITOR=nvim 
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export PATH="$PATH:$HOME/MG5_aMC_v3.6.4/bin"
export CADNA_PATH="/home/stloufra/git/cadnaForPromise"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gallifrey"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

#vim like movement

plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use) #zsh-vi-mode)
bindkey '^ ' autosuggest-accept
#fzf magic is happening bellow
# Enable fzf keybindings and autocompletion (apt install)
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh

## Use fd (if installed) for better file search; fall back to find
#if command -v fd &>/dev/null; then
#  export FZF_DEFAULT_COMMAND='fd --type f'
#  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#else
#  export FZF_DEFAULT_COMMAND='find . -type f'
#  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#fi
#
## Use bat to preview files in Ctrl+T
#export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range=:500 {} 2>/dev/null || cat {}'"

# Custom fzf-file-widget
fzf-file-widget-custom() {
  LBUFFER_ORIG=$LBUFFER
  RBUFFER_ORIG=$RBUFFER
  local selected
  selected=$(find . -type f 2>/dev/null | \
    fzf --height 40% --info inline --border \
        --preview '[[ $(file --mime {}) =~ text ]] && bat --style=numbers --color=always {} || file {}' \
        --preview-window=right:70%:wrap)
  [[ -z "$selected" ]] && return

  if [[ -z "$LBUFFER_ORIG$RBUFFER_ORIG" ]]; then
    # If line is empty, open file
    case "$selected" in
      *.pdf)       nohup zathura "$selected" >/dev/null 2>&1 & ;;
      *.png|*.jpg) nohup sxiv "$selected" >/dev/null 2>&1 & ;;
      *.vtk|*.vtu|*.stl) nohup paraview "$selected" >/dev/null 2>&1 & ;;
      *.html)      nohup ${BROWSER:-firefox} "$selected" >/dev/null 2>&1 & ;;
      *.mp4|*.avi|*.ogv) nohup mpv "$selected" >/dev/null 2>&1 & ;;
      *)           $EDITOR "$selected" ;;
    esac
  else
    # Insert file path into command line
    LBUFFER+="$selected"
  fi
}

zle -N fzf-file-widget-custom
bindkey '^T' fzf-file-widget-custom

source $ZSH/oh-my-zsh.sh

function fe() {
  local query="${1:-error}"
  local result=$(rg --vimgrep --case-sensitive "$query" \
    | fzf --ansi \
        --preview 'bat --style=numbers --color=always --highlight-line $(cut -d: -f2 <<< {}) --line-range $(( $(cut -d: -f2 <<< {}) > 60 ? $(cut -d: -f2 <<< {}) - 60 : 1 )):$(( $(cut -d: -f2 <<< {}) + 60 )) "$(cut -d: -f1 <<< {})"')
  
  if [[ -n "$result" ]]; then
    echo "$result" | awk -F: '{print "+"$2, $1}' | xargs nvim
  fi
}
# User configuration

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
# Bind Print Screen key to copy screenshot to clipboard
if [[ "$DISPLAY" != "" ]]; then
  # Using 'maim' for full-screen screenshot
  bindkey -s '^[[2~' 'maim | xclip -selection clipboard -t image/png\n'
fi


# Start xbindkeys if not already running
if ! pgrep -x "xbindkeys" > /dev/null; then
    xbindkeys >/dev/null 2>&1 & disown
fi

# Start feh if not already running
#if ! pgrep -x "feh" > /dev/null; then
#    ~/.fehbg >/dev/null 2>&1 & disown
#fi

# --- 🌤️ Fancy CERN Weather Banner (once per day) ---
if [[ $- == *i* ]]; then
    CYAN="\033[1;36m"
    YELLOW="\033[1;33m"
    RESET="\033[0m"

    CACHE_DIR="$HOME/.cache"
    CACHE_FILE="$CACHE_DIR/cern_weather.txt"
    TODAY=$(date +%Y-%m-%d)

    mkdir -p "$CACHE_DIR"

    # Only fetch if cache is missing or outdated
    if [[ ! -f "$CACHE_FILE" ]] || ! grep -q "$TODAY" "$CACHE_FILE"; then
        {
            echo "$TODAY"
            echo
            curl -s 'wttr.in/Geneva?1n' \
              | sed '1,/^$/d' \
              | sed '/^Location:/,$d' \
              | sed '/^Follow/d'
        } > "$CACHE_FILE"
    fi

    echo
    echo -e "${CYAN}┌──────────────────────────────────────────┐${RESET}"
    echo -e "${CYAN}│${RESET}   ${YELLOW}Weather at CERN (Geneva) 🌤️${RESET}"
    echo -e "${CYAN}└──────────────────────────────────────────┘${RESET}"
    sed '1d' "$CACHE_FILE"  # skip date line
    echo
fi

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias arth="cd ~/git/tnl/src/TNL/Arithmetics" 
alias spharth="cp -r /home/stloufra/git/tnl/src/TNL/Arithmetics /home/stloufra/tnl-sph/build/_deps/tnl-src/src/TNL/"
alias venv="python3 -m venv .venv
source .venv/bin/activate"
alias spt="ncspot"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias k='kate'
alias ferret='ssh ferretgpu.fsid.cvut.cz'
alias sshcern='ssh fstlouka@lxplus.cern.sh'
