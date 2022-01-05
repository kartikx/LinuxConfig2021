autoload -U colors && colors
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M%{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
PS1="%B%{$fg[green]%}[%{$fg[blue]%}~/%1d%{$fg[green]%}]%{$reset_color%}$%b "

# History in Cache Directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Auto/Tab Complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# VIM Config
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Keybindings 
bindkey '^H' backward-kill-word
# bindkey '^[[3;5~' kill-word

# Alias
alias spd="spotifyd"
alias tm="tmux -f cft"
alias e="exit"
alias st="sh /home/kartik/.local/scripts/startup.sh"
alias spot="spotifyd && sleep 0.5 && spt"
alias c="clear"
alias cls="clear; ls"
alias g++cf="g++ -o o -O2 -std=c++17"
alias gc="gcalccmd"
alias ba="sh /home/kartik/.local/scripts/battery.sh & disown"

## Global Alias
alias -g sm="~/StudyMaterial"
alias -g v="vim"
alias -g nh="nohup"
alias -g cfv="~/.config/nvim/init.vim"
alias -g cfz="~/.config/zsh/.zshrc"
alias -g cfa="~/.config/alacritty/alacritty.yml"
alias -g cft="~/.config/tmux/.tmux.conf"
alias -g ev="nh evince"
alias -g ok="nh okular"
alias -g s="sudo"
alias -g ff="nh firefox wn"
alias -g wn=">/dev/null 2>&1 &"
alias -g CP="~/Code/CP"
alias -g xc="xclip -selection clipboard"

## Functional Alias
mvdl() {
    if [ $# -lt 2 ]
    then
        echo "mvdl . 2"
        return -1
    fi

    for i in {1..$2}
    do
        lastFile=$(ls -rt ~/Downloads | tail -1)
        mv "/home/kartik/Downloads/""$lastFile" $1
        echo "Successfully Moved: "" $lastFile"
    done
}

mkcd() {
    mkdir $1 && cd $1
}

# Must be at the end
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

export PATH=$PATH:$PATH:/usr/local/go/bin:/home/kartik/go/bin
export PYTHONPATH="/home/kartik/behavioral-model/tools"
