export PS1='-> '
export KISS_PATH=$HOME/repo/pkg
export CFLAGS="-O3 -march=native -pipe"
export CXXFLAGS="$CFLAGS"
export MAKEFLAGS=-j6
export CMAKE_GENERATOR=Ninja
export PATH=/usr/lib/ccache/bin:$PATH
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export PATH=$PATH:$HOME/bin
export WLR_DRM_NO_MODIFIERS=1
export YACC=byacc
export ENV=$HOME/.rc

printf 'start wayland?'
! read -r || exec sway

