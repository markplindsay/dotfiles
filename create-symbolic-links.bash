#!/bin/bash
ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
mkdir -p $HOME/.config/nvim
ln -s $HOME/dotfiles/init.vim $HOME/.config/nvim/init.vim
ln -s $HOME/dotfiles/coc-settings.json $HOME/.config/nvim/coc-settings.json
