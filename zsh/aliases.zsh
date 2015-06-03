# ZSH Aliases

alias ll='ls -ahl'
alias lt='ls -ahltr'
alias ducks='du -cks * | sort -rn |head -11'
alias ducksh='du -sk * | sort -rn | head -11 | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias grep='grep --color=auto'
alias less="less -r"
alias more="less -r"
alias ut='bsdtar -vx -f'
alias httpserver='python -mSimpleHTTPServer'
alias vi='vim'
alias pip='pip3'
alias python='python3'
