#!/bin/bash
#
# setup.sh
# Install my dotfiles
#
# The folder containing the dotfiles must be at:
# "$HOME/dotfiles"
# Some of the configs are hardcoded to that directory
# so for the time being until I fix the issue you'll have
# to have the folder there.

# Vars
dotfile_dir="$HOME/dotfiles"
flags="-s"


# .config

# Create ".config" if it doesn't exist
mkdir -p "$HOME/.config"

ln $flags "${dotfile_dir}/.config/cava" "$HOME/.config/cava"
ln $flags "${dotfile_dir}/.config/cmus" "$HOME/.config/cmus"
ln $flags "${dotfile_dir}/.config/mpv" "$HOME/.config/mpv"
ln $flags "${dotfile_dir}/.config/openbox" "$HOME/.config/openbox"


# Scripts

# Create "bin" if it doesn't exist
mkdir -p "$HOME/bin"

# scripts
ln $flags "${dotfile_dir}/scripts/"*.sh "$HOME/bin"
ln $flags "${dotfile_dir}/scripts/"**/*.sh "$HOME/bin"

# Drop the ".sh" from all scripts.
for script in "$HOME/bin/"*.sh; do mv "$script" "${script/'.sh'}"; done


# .files

# We use cp here instead of ln because cp excludes folders
# from linking.
cp $flags "${dotfile_dir}"/.* "$HOME"


# Neovim

# Create ".config/nvim" if it doesn't exist
mkdir -p "$HOME/.config/nvim"

ln $flags "${dotfile_dir}/init.vim" "$HOME/.config/nvim"


# GTK Theme

# Create ".themes" if it doesn't exist
mkdir -p "$HOME/.themes"

ln $flags "${dotfile_dir}/themes/yellow" "$HOME/.themes"
