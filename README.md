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

**change dark blue color**
https://superuser.com/questions/1365258/how-to-change-the-dark-blue-in-wsl-to-something-brighter

## probably good idea to restart terminal/wsl

## For matplotlib to display in wsl2 without ubuntu gui

[install vcxsrv](https://stackoverflow.com/questions/43397162/show-matplotlib-plots-and-other-gui-in-ubuntu-wsl1-wsl2#:~:text=Ok%2C%20so%20I%20got%20it%20working%20as%20follows.%20I%20have%20Ubuntu%20on%20windows%2C%20with%20anaconda%20python%203.6%20installed.) and follow that thread

**fix error with that:**
```shell
sudo apt install python3-gi-cairo
```
