# Dotfiles Setup
## Just use Linux
Use WSL2 on Win10/11. I tried just Windows and just no.

## clone dotfiles
```shell
git clone https://github.com/Mokronos/.dotfiles.git
```
## install some basic stuff

**install other stuff with script:**
```shell
chmod +x install
```
```shell
./install
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

## VPN and WSL2
Internet doesn't work in WSL2 when connected to a VPN.  
**Solution**:  
Use Cisco Anyconnect from Windows Store (dont download online and install manually).

## Git config
[follow](https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-git)

## Neovim Release Build
clone nvim git [repo](https://github.com/neovim/neovim) (or specific version) [follow](https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-source).

Check [this](https://github.com/neovim/neovim/wiki/Building-Neovim#building) for making sure we are using the RELEASE version of neovim.

## TODO

there is still a lot of weird stuff happening every time i install on new setup which needs to be manually fixed/installed
