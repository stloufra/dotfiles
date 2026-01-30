# ~/.bashrc - minimal enhanced

# only run for interactive shells
case $- in
  *i*) ;;
  *) return;;
esac

# basic PATH
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# history
HISTSIZE=10000
HISTCONTROL=ignoreboth
shopt -s histappend

# show only last 2 directories in the path
PROMPT_DIRTRIM=2

# colored prompt
PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '

# handy small aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias mg='cd /data/frstlouk/madgraph4gpu/MG5aMC/mg5amcnlo'
alias eos='cd /eos/home-f/frstlouk/shared'
alias nvim='vim'
alias cadna='cd /data/frstlouk/CADNA_tools_for_MadGraph5'

# load user aliases if present
[ -f "$HOME/.bash_aliases" ] && . "$HOME/.bash_aliases"

# enable completion if available
[ -f /etc/bash_completion ] && . /etc/bash_completion

# -------------------------------------------------------------
# 🪄 Quality of life: syntax highlighting + autosuggestions
# -------------------------------------------------------------
# Install these with:
#   sudo apt install bash-completion bash-preexec
#   git clone https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --key-bindings --completion --no-update-rc
#   git clone https://github.com/dvorka/hstr.git ~/.hstr && cd ~/.hstr && sudo make install
#   git clone https://github.com/rcaloras/bash-preexec ~/.bash-preexec && echo 'source ~/.bash-preexec/bash-preexec.sh' >> ~/.bashrc
#   git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.bash-syntax-highlighting

# bash-preexec (needed for autosuggestions)
if [ -f ~/.bash-preexec/bash-preexec.sh ]; then
  . ~/.bash-preexec/bash-preexec.sh
fi

# Syntax highlighting (fast & lightweight)
if [ -f ~/.bash-syntax-highlighting/fast.bash ]; then
  . ~/.bash-syntax-highlighting/fast.bash
fi

# Command autosuggestions from history (similar to fish/zsh)
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Highlight matches when typing
bind 'set show-all-if-ambiguous on'
bind 'set colored-completion-prefix on'
bind 'set colored-stats on'
bind 'set completion-ignore-case on'
bind 'set menu-complete-display-prefix on'

# optional: enable fzf for powerful interactive search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash
# History configuration
HISTSIZE=50000
HISTFILESIZE=100000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# Ensure history is written on every command (safe with bash-preexec)
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export HISTIGNORE="ls:ll:la:l:cd:pwd:exit:clear"

