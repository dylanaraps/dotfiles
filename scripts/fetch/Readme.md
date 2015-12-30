# fetch.sh

This is the home of my fetch script, I've spent the past few days rewriting this
<br/> and it now supports other distros as well as a ton of new features.

If you're having any issues or have any ideas, please open an issue! I can't test on many
<br/> other distros and I want this to work for as many people as possible.

![1](https://sr.ht/5aNV.png)


## Dependencies

These are the script's dependencies:

-  Displaying Images: w3m
-  Image Cropping: ImageMagick
-  Wallpaper Display: feh
-  Current Song: mpc

These are the script's optional dependencies
-  Window Manager Detection: wmctrl
    - You can manually set this at launch with:

        ```
            scrot.sh --windowmanager wmname
        ```


## TODO

Here's what's on my todo list

- Add an easy way to define info prefixes at launch.
- Find a reliable way to set the text padding dynamically. I can get this to
  <br/> work based on font width but there's no reliable way of getting
  <br/> fontwidth for every terminal afaik.
- Find a quick and reliable way to get the current window manager. I had a
  <br/> solution that used an array of processes and pgrep but it doubled the
  <br/> startup time for the script.
- Add an option to disable the color blocks at the bottom.

If you've got any ideas on how to solve these problems, let me know!


## Screenshots

#### The color script is now builtin.
![2](https://sr.ht/Z9hZ.png)

#### You can now customize the color of everything.
![3](https://sr.ht/hy7m.png)

#### You can now disable all images with a flag.
![4](https://sr.ht/zujR.png)
