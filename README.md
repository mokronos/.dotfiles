# Dotfiles Setup
## Just use Linux
Use WSL2 on Win10/11. I tried just Windows and just no.
## install some basic stuff
**install zsh manually:**
```shell
sudo apt install zsh
```

**install other stuff with script:**
```shell
chmod +x install
```
```shell
./install
```

## clone dotfiles
```shell
git clone https://github.com/Mokronos/.dotfiles.git
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

## probably good idea to restart terminal/wsl
