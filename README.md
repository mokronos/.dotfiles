# Dotfiles Setup
## Just use Linux
Use WSL2 on Win10/11. I tried just Windows and just no.
## install some basic stuff
**install zsh manually:**  
sudo apt install zsh

**install other stuff with script:**  
chmod +x install  
./install

## clone dotfiles
git clone https://github.com/Mokronos/.dotfiles.git

## use stow to create symlinks for all the dotfiles
chmod +x install_dot

**run to link:**  
./install_dot

**run to clean/unlink:**  
./install_dot clean

## probably good idea to restart terminal/wsl
