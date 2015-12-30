# fetch.sh

This is the home of my fetch script, I've spent the past few days rewriting this and it now supports other distros as well as a ton of new features.

![1](https://sr.ht/5aNV.png)


## Dependencies

These are the script's dependencies:

-  Displaying Images: w3m
-  Image Cropping: ImageMagick
-  Wallpaper Display: feh
-  Current Song: mpc

These are the script's optional dependencies
-  Window Manager Detection: wmctrl
    - You can manually set this at launch with

        --windowmanager wmname


## TODO

Here's what's on my todo list

- Add an easy way to define info prefixes at launch.
- Find a reliable way to set the text padding dynamically. I can get this to work based on font width but there's no reliable way of getting fontwidth for every terminal afaik.
- Add an option to disable the color blocks at the bottom.

If you've got any ideas on how to solve these problems, let me know!


## Screenshots

### The color script is now builtin!
![2](https://sr.ht/Z9hZ.png)

### You can now customize the color of everything
![3](https://sr.ht/hy7m.png)

### If images aren't your thing you can now disable them with a flag!
![4](https://sr.ht/zujR.png)
