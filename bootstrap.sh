#!/bin/bash

dir=$(dirname $0)
dotdir=$($dir/bin/realpath $dir)
temp=/tmp

# Link dotfiles and special folders in $HOME if not exists
for file in $dotdir/*; do
  filename=$(basename $file)
  dotfile=$HOME/.$filename
  if [ $filename = $(basename $0) -o $filename = "README.md"\
    -o $filename = "Brewfile"     -o $filename = "Caskfile" ]; then
    continue
  fi
  if [ -e $dotfile ]; then
    if [ -L $dotfile ]; then
      printf "$dotfile is already a link!\n"
    else
      printf "$dotfile already exists. Remove it!\n"
    fi
  else
    printf "Linking $dotfile to $file\n"
    ln -s $file $dotfile
  fi
done
chsh -s /bin/zsh
source $HOME/.zshrc

# Set up zsh shell environment
if [ -d $HOME/.oh-my-zsh ]; then
  printf "OH-MY-ZSH is already installed, only updating ...\n"
  zsh $HOME/.oh-my-zsh/tools/upgrade.sh
else
  printf "Installing OH-MY-ZSH\n"
  git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
  rm $HOME/.zshrc*
fi

# Add themes to oh-my-zsh
for file in $dotdir/zsh/themes/*; do
  filename=$(basename $file)
  themefile=$HOME/.oh-my-zsh/themes/$filename
  if [ -e $themefile ]; then
    if [ -L $themefile ]; then
      printf "Theme $themefile is already a link!\n"
    else
      printf "Theme $themefile already exists!\n"
    fi
  else
    ln -s $file $themefile
    printf "Theme $themefile linked\n"
  fi
done

# Install powerline fonts
if [ ! -e $temp/fonts  ]; then
  echo "powerline fonts will be installed to the system..."
  git clone https://github.com/powerline/fonts.git $temp/fonts
  $temp/fonts/install.sh
  echo "fonts are installed."
fi

# Install vim bundles
if ! [ -d $HOME/.vim/bundle ]; then
    mkdir $HOME/.vim/bundle
fi
if [ -d $HOME/.vim/bundle/vundle ]; then
  printf "Updading vundle ...\n"
  cd $HOME/.vim/bundle/vundle; git pull; cd -
else
  git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
fi

vim -u ~/.vim/bundles.vim +BundleInstall +q +q

# If os is MacOS install Homebrew and install the programs in the Brewfile
# and in the Caskfile with Homebrew
if [ "$(uname)" == "Darwin" ]; then
  if ! which brew>/dev/null; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    font_dir="$HOME/Library/Fonts"
  fi
  brew update
  # Process Brewfile
  brew install $(cat Brewfile|grep -v "#")
  brew install caskroom/cask/brew-cask
  # Process Caskfile
  brew cask update
  brew cask install $(cat Caskfile|grep -v "#")
  brew cleanup
  brew cask cleanup
fi
