# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k"
source ~/powerlevel10k/powerlevel10k.zsh-theme

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Use manjaro zsh prompt
# if [[ -e $HOME/.zsh/zsh-prompt ]]; then
#   source $HOME/.zsh/zsh-prompt
# fi


# nvm bash completion
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# 
# Mounting laptop with NFS 
# mount -t nfs {remote_pc_address}:/remote/dir /some/local/dir
# sshfs -o allow_other,default_permissions user@hostname:/remote/dir /some/local/dir/"
alias mntmjolnir="sudo sshfs -o allow_other,default_permissions andrew@mjolnir.local:/home/andrew/ /home/andrew/mnt/mjolnir/"

# freyr - music downloader - https://github.com/miraclx/freyr-js
alias freyr='sudo docker run -it --rm -v ~/music/freyr:/data freyrcli/freyrjs' --no-header

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/andrew/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/andrew/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/andrew/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/andrew/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<



# /////// setting up config alias and .dotfile config repo ///////
# git init --bare $HOME/.dotfiles                                                                                                                                                              10:59:29 AM
# alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# config config --local status.showUntrackedFiles no
# echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc
alias config='/usr/bin/git --git-dir=/home/andrew/.dotfiles/ --work-tree=/home/andrew'
alias nvimcfg='nvim $HOME/.config/nvim'


# Flutter env setup
export PATH="$PATH:$HOME/dev/webdev/flutter/bin"
export CHROME_EXECUTABLE="$HOME/dev/webdev/chrome-linux64/chrome"

# git autocompletion is slow..
__git_files () { 
    _wanted files expl 'local files' _files     
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
