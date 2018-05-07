# options below can be overridden in ~/.zshrc.local
# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="onet"
export DEFAULT_USER="dirk"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git osx brew brew-cask zsh-syntax-highlighting history-substring-search autojump)

# Needs https://github.com/zsh-users/zsh-syntax-highlighting/
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# Locale settings (utf-8)
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8

# load ~/.zshrc.local
[[ -s $HOME/.zshrc.local ]] && source "$HOME/.zshrc.local"

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# ============== Custom tweaks below this line ==============
for config_file ($HOME/.zsh/*.zsh) source $config_file

#History Settings
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

# bind UP and DOWN arrow keys
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# completion cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# ignore duplicate entries
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Load ENV Variables
export EDITOR=emacs
export PAGER=less

# Put custom $PATH settings into ~/.zprofile or ~/.zshrc.local
export PATH=$PATH:$HOME/.bin:$HOME/.mac:/Library/TeX/Root/bin/x86_64-darwin:/usr/local/opt/coreutils/libexec/gnubin
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH

#077 would be more secure, but 022 is generally quite realistic
umask 022

#Auto Escape URLS
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# SSH Stuff
if [ -r $HOME/.ssh/config ]; then
    hosts=(`cat $HOME/.ssh/config | egrep '^Host.*' | sed "s/^Host[ ]*\(.*\)$/\1/"`)
fi
if [ -r /etc/hosts ]; then
    hosts=( $hosts $(cat /etc/hosts | grep -v '^\#' | awk '{print $2}') )
fi
if [ -d $HOME/.ssh ]; then
  for file in $HOME/.ssh/*; do
    if [ "$file" != "known_hosts" -o "$file" != "authorized_keys" ]; then
      ssh-add $file > /dev/null 2>&1
    fi
  done
fi

zstyle '*' hosts $hosts
#zstyle ':completion:*:*:*:*:*' menu complete

# show fortune cookie
type fortune &>/dev/null && fortune -a
# load grc aliases for colored shell output
type grc &>/dev/null && source $HOME/.zsh/grc_aliases.zsh

# misc settings for tools installed via homebrew
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# EOF
