# echo "alias h='history'" >> ~/.bash_profile
# echo "alias gh='history|grep'" >> ~/.bash_profile
# echo "alias ll='ls -lhF'" >> ~/.bash_profile
# echo "alias la='ls -lhAF'" >> ~/.bash_profile
# echo "alias lal='ls -lhAF | less'" >> ~/.bash_profile
# echo "alias cd..='cd ..'" >> ~/.bash_profile
# echo "alias cd...='cd ../..'" >> ~/.bash_profile
# echo "alias cd....='cd ../../..'" >> ~/.bash_profile
# echo "alias cd.....='cd ../../../..'" >> ~/.bash_profile
# echo "alias cd......='cd ../../../../..'" >> ~/.bash_profile
# source ~/.bash_profile

#!/bin/bash

########## Variables

dir="$(pwd)"                    # dotfiles directory
backupDir="$HOME/.dotfiles_backup/$(date)"            # old dotfiles backup directory
files="bashrc"    # list of files/folders to symlink in homedir

##########

# Show working directory
echo "Using working current: $dir"
echo

# init and update Git submodules
echo "Init and update Git Submodules"
git submodule update --init --recursive
echo

# create dotfiles_old in homedir
echo "Creating '$backupDir' for backup of any existing dotfiles in ~/"
mkdir -p "$backupDir"
echo "Done."
echo

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd "$dir"
echo "Done."
echo 

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from $HOME/.$file to $backupDir/.$file"
    mv "$HOME/.$file" "$backupDir/$file"
    if [ -e "$HOME/.$file" ]
    then
        echo "Removing existing dotfile"
        rm "$HOME/.$file"
    fi
    echo "Creating symlink to $file in home directory."
    ln -s "$dir/$file" "$HOME/.$file"
    echo
done
echo 
