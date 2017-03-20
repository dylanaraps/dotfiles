# Dylan's Dotfiles

Welcome to my dotfiles repo. Around 6 months ago I stopped using Linux on my main PC due to university requiring some Windows only programs. University is over and I can run Linux on my PC again so I've decided to redo my dotfiles from scratch.

My dotfiles are now managed with GNU stow so you can easily install and uninstall parts of it with ease. This should satisfy those who find my setup and ask for help installing it. \^\^

**[Screenshots](https:/dylanaraps.com/pages/rice)**

![scrot](https://i.imgur.com/rD8BJyF.png)

## Setup

- Application Launcher: `rofi`
- Bar: `none`
- Compositor: `compton`
- Icons: `flattr (modified)`
- Music Player: `spotify`
- Notifications: `dunst`
- Shell: `bash`
- Terminal Emulator: `urxvt`
- Text Editor: `neovim`
- Theme: `Arc (modified)`
- Video Player: `mpv`
- Web Browser: `Firefox`
- Window Manager: `i3-gaps`


## Scripts

You can find my scripts in this repo:

https://github.com/dylanaraps/bin


## Installation

My dotfiles can now be easily installed using `stow`.

1. Clone this repo.
    - `git clone https://github.com/dylanaraps/dotfiles`
2. Change directory to `dotfiles`
    - `cd dotfiles`
3. Install dotfiles using stow.


```sh
# Install i3 config
stow i3

# Install termite config
stow termite

# Uninstall i3 config
stow -D i3
```
