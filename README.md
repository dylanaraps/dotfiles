# Dylan's Dotfiles

These are my dotfiles for both my Desktop and my Laptop. The Laptop runs at 4K whereas the Desktop runs at 1080p, this means that I need to have wildly different configs for each system. I can't use my 7px bitmap font at 4K can I? The solution I've come up with is to use the system hostname as an identifier in my `.xinitrc` and my `.Xresources`.

This way I can set fonts, resolutions and other settings on a per system basis. I've also set it up so I can add a 3rd or 4th system if I ever need to. The only downside to this is that anyone who stumbles across my dotfiles will find them unusable unless their hostname matches one of the 2 machines in the config files.

This actually works out well because I'm against people just installing these dotfiles as a whole. I want you to to look at these configs, take what you like and then incorporate it into your own setup. These configs are very much a personal thing and I've made some very retarded decisions when it comes to hotkey choices and etc.

I get an endless amount of messages from people installing the dotfiles and then complaining that they don't know how to use their desktop afterwards. Again, take what you like and incorporate it into your own setup, you won't learn otherwise.


**Screenshots: https:/dylanaraps.com/pages/rice**

![scrot](https://dylanaraps.com/img/rice/0717/1.png)


## Setup

- Application Launcher: `rofi`
- Bar: `lemonbar`
- Compositor: `compton`
- Music Player: `spotify` / `mopidy` + `ncmpcpp`
- Notifications: `dunst`
- Shell: `bash`
- Terminal Emulator: `urxvt`
- Text Editor: `neovim`
- Video Player: `mpv`
- Web Browser: `Firefox (Nightly)`
- Window Manager: `i3-gaps`


## Scripts

You can find my scripts in this repo:

https://github.com/dylanaraps/bin


## Installation

1. Inspect dotfiles.
2. Find cool thing.
3. Add cool thing to your dotfiles.
