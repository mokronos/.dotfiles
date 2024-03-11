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
[follow](https://github.com/GitCredentialManager/git-credential-manager/blob/main/docs/wsl.md#:~:text=git%20config%20%2D%2Dglobal%20credential.helper%20%22/mnt/c/Program%5C%20Files/Git/mingw64/bin/git%2Dcredential%2Dmanager.exe%22)

## Neovim Release Build
clone nvim git [repo](https://github.com/neovim/neovim) (or specific version) [follow](https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-source).

Check [this](https://github.com/neovim/neovim/wiki/Building-Neovim#building) for making sure we are using the RELEASE version of neovim.

## Copilot not working because of WSL2 internet

[This](https://stackoverflow.com/questions/62314789/no-internet-connection-on-wsl-ubuntu-windows-subsystem-for-linux) fixed it.

## TODO

there is still a lot of weird stuff happening every time i install on new setup which needs to be manually fixed/installed

# Python scripts
## install python scripts
Just makes the scripts executable, path is hardcoded in zshrc.
```shell
for f in *(.); chmod +x $f; done
```
Need to have zsh with extended globbing enabled.
## Info
These are just some random python scripts I made.
This setup makes them nicely organized and they can be used from anywhere like cli programs.
Just need to be careful with names.

## weird stuff

### explorer.exe doesn't open or markdown viewer can't access chrome (over cmd.exe) from wsl

Go to /etc/ and check where the paths are set (search for "games", its in the path) and add :$PATH to the end.
It somehow sets the path there and overwrites the path set by windows when initializing wsl.
Or at least some hidden path, because i cant identify any changes to the path afterwards, like there is no /mnt/c/windows/system32 (where all the windows executables are).
