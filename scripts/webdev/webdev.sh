#!/bin/bash
cd ~/projects

echo "What would you like to name your project?"
read dirname

mkdir $dirname
cd $dirname

mkdir src
cd src

mkdir scss
cd scss
touch main.scss
cd ..

mkdir coffeescript
cd coffeescript
touch main.coffee
cd ..

touch index.html
cd ..

git init
git add .
git commit -m "Initial Files"

cp ~/.dotfiles/scripts/webdev/files/gulpfile.coffee ~/projects/$dirname

