#!/bin/sh
# This script symlinks my dotfiles to their required locations

# Set dotfiles directory
dotfiledir="$HOME/dotfiles"

# Set ln flags
ln="ln -s -f -v -n -i"

# Create directories

mkdir "$HOME/.config/nvim"
mkdir "$HOME/.config/qutebrowser"
mkdir "$HOME/.config/ranger"
mkdir "$HOME/.config/ranger/colorschemes"
mkdir "$HOME/.mpd"
mkdir "$HOME/.ncmpcpp"
mkdir "$HOME/.weechat"
mkdir "$HOME/pwd.sh"
mkdir "$HOME/bin"

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
$ln "$dotfiledir/.dircolors" "$HOME/"
$ln "$dotfiledir/.config/mpv" "$HOME/.config"
$ln "$dotfiledir/.weechat/irc.conf" "$HOME/.weechat"
$ln "$dotfiledir/.weechat/weechat.conf" "$HOME/.weechat"
$ln "$dotfiledir/.config/qutebrowser/qutebrowser.conf" "$HOME/.config/qutebrowser"
$ln "$dotfiledir/.config/qutebrowser/keys.conf" "$HOME/.config/qutebrowser"
$ln "$dotfiledir/scripts/*.sh" "$HOME/bin"
$ln "$dotfiledir/scripts/*/*.sh" "$HOME/bin"
$ln "$dotfiledir/.config/ranger/rc.conf" "$HOME/.config/ranger"
$ln "$dotfiledir/.config/ranger/rifle.conf" "$HOME/.config/ranger"
$ln "$dotfiledir/.config/ranger/scope.sh" "$HOME/.config/ranger"
$ln "$dotfiledir/.config/ranger/colorschemes/ryuuko.py" "$HOME/.config/ranger/colorschemes"
