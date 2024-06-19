#!/usr/bin/env bash


# SETUP
which -s brew
if [[ $? != 0 ]] ; then
    echo "Installing Homebrew"
    /usr/bin/bash -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
echo "Upgrading Homebrew"
brew upgrade
echo "Updating Homebrew"
brew update
echo "Installing brew cask"
brew tap caskroom/cask
echo # newline


# INSTALL BREW APPS
declare -a apps=(
    'git'
    'fzf'
    'fd'
    'bat'
    'ripgrep'
    'git-delta'
    'tree'
    'neovim'
    'htop'
    'pyenv'
    'rustup'
    'go'
    'node'
    'pipx'
    'docker-compose'
    'redis'
    'tmux'
)
echo "Installing brew apps"
for app in "${apps[@]}"; do
    echo "      Installing ${app}"
    brew install "$app"
done
echo # newline


# INSTALL BREW CASK APPS
declare -a cask_apps=(
    'docker'
    'iterm2'
    'firefox'
    'google-chrome'
    'postgresql'
    'slack'
    'spotify'
    'visual-studio-code'
    'sonos'
)
echo "Installing brew cask apps"
for cask_app in "${cask_apps[@]}"; do
    echo "      Installing ${cask_app}"
    brew install --cask "$cask_app"
done
echo # newline


# CLEANUP
brew cleanup
