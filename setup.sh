#!/bin/sh
# This script symlinks my dotfiles to their required locations

# Set dotfiles directory
dotfiledir="$HOME/dotfiles"

# Set ln flags
ln="ln -s -f -v -n -i"

# Create directories

mkdir "$HOME/.config/nvim"
mkdir "$HOME/.mpd"
mkdir "$HOME/.ncmpcpp"
mkdir "$HOME/pwd.sh"

# Link dotfiles

$ln "$dotfiledir/init.vim" "$HOME/.config/nvim"
$ln "$dotfiledir/.mpd/mpd.conf" "$HOME/.mpd/"
$ln "$dotfiledir/.mpd/playlists" "$HOME/.mpd/"
$ln "$dotfiledir/.muttrc" "$HOME/"
$ln "$dotfiledir/.ncmpcpp/bindings" "$HOME/.ncmpcpp"
$ln "$dotfiledir/.ncmpcpp/config" "$HOME/.ncmpcpp"
$ln "$dotfiledir/pwd.sh.safe" "$HOME/pwd.sh"
$ln "$dotfiledir/.tmux.conf" "$HOME/"
$ln "$dotfiledir/.xinitrc" "$HOME/"
$ln "$dotfiledir/.Xresources" "$HOME/"
$ln "$dotfiledir/.zsh_aliases" "$HOME/"
$ln "$dotfiledir/.zshrc" "$HOME/"
$ln "$dotfiledir/.config/mpv" "$HOME/.config"
