## JhonyRetro's Dotfiles

## What is this project?
These are my own customized configuration files for my Hyprland setup on Arch Linux. I wanted to make a portable, fast, and easy way to quickly install/restore my dotfiles in case I break my system while experimenting with stuff. I've made this repository if anyone wants to use them, since I think they are work/casual use oriented, with a reliance on minimalism and straight-forward features.

## Features
- ashell | Fast and easily customizable status bar
- Simple keybinds
- Custom wallpaper selection, with dynamic color palettes.
- Quick Spanish keyboard setup (as I've said, these are my files!!, and this was a PITA)

## Video demo
<https://github.com/JhonyRetro/retro-dotfiles/blob/3de6f37ffec452a6a7713231e79fc76acf6f0eba/assets/quick_demo.mp4>

## IMPORTANT!!
If you are using a NVIDIA GPU (as in my case), you should uncomment the two enviroment variables in the uwsm config folder, due to recommendations from the [Hyprland Wiki](https://wiki.hypr.land/Nvidia/)
## Why this approach?
I wanted to move on from the typical waybar + addons setup, and I found some interesting (and fast!) alternatives. Keep in mind again, that these are my custom configurations. I may change things to English in the future for standarization purposes, but this my first project regarding Linux ricing and customization.

## Extra information
A guide will be provided in this repository, as well as a first login message explaining the same contents. The file can also be found on the `retro-dotfiles` folder in `.local/share/`.

## Known issues and contributing
Be free to report any bug that you encounter while using my files! Regarding pull requests, as long as they are legible and coherent, I don't mind checking them out. Otherwise, they'll be ignored.

### Bugs I've encountered and things I'll probably fix
- GTK settings do not apply correctly (seen in Thunar)
- Code abstraction in some of the bash scripts (specially the welcome script...)
- Some wallpapers do not generate palettes due to pywal (might change to pywal16 in the future idk)
- Installation may throw an error during file handling commands (mv, ln, etc; although all my tests have been successful atm).
