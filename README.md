# Dotfiles Setup
## Just use Linux
Use WSL2 on Win10/11. I tried just Windows and just no.
## install some basic stuff
**install zsh manually:**
```shell
sudo apt install zsh
```

## clone dotfiles
```shell
git clone https://github.com/Mokronos/.dotfiles.git
```

**install other stuff with script:**
```shell
chmod +x install
```
```shell
./install
```

**install some stuff after**
```shell
nvm install node
```

## use stow to create symlinks for all the dotfiles
```shell
chmod +x install_dot
```

**run to link:**
```shell
./install_dot
```

**run to clean/unlink:**
```shell
./install_dot clean
```

**make zsh default**
```shell
chsh -s $(which zsh)
```

**install powerline fonts**
https://stackoverflow.com/questions/63148517/how-to-install-powerline-fonts-on-wsl

set to deja vu sans mono

**change dark blue color**
https://superuser.com/questions/1365258/how-to-change-the-dark-blue-in-wsl-to-something-brighter

## sharpkeys to swap capslock and esc
https://github.com/randyrants/sharpkeys/releases

## probably good idea to restart terminal/wsl

## For matplotlib to display in wsl2 without ubuntu gui

[install vcxsrv](https://gist.github.com/KulryCzech/6f11e145d59048637a9d419a66d55896) and follow that thread

and run XLaunch from start menu (and disable access control, disable clipboard, everything else default) and save config in autostart windows folder

**TODO**

there is still a lot of weird stuff happening every time i install on new setup which needs to be manually fixed/installed
