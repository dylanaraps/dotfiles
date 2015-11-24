#!/bin/sh
cd ~/projects || exit

echo "What would you like to name your project?"
read -r dirname

mkdir "$dirname"
cd "$dirname" || exit

mkdir src

mkdir src/scss
touch src/scss/main.scss

mkdir src/coffeescript
touch src/coffeescript/main.coffee

touch src/index.html

git init
git add .
git commit -m "Initial Files"

cp ~/dotfiles/scripts/webdev/files/gulpfile.coffee ~/projects/"$dirname"

