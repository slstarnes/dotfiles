#!/bin/bash

########## Variables

dir="$(pwd)"  # dotfiles directory
backupDir="$HOME/.dotfiles_backup/$(date)"  # old dotfiles backup directory
tmp_fn='.temp'
files="bashrc"    # list of files/folders to symlink in homedir
append_files="bashrc"  # list of files that will have new content appended (not replaced)

##########

# Show working directory
echo "Using working current: $dir"
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

# if file is in append_files list then append content to end of original file (no symlink)
# unless original file does not exist in which case do create a symlink to /dotfiles version
# if not in the append_files list, move original file to dotfiles_old directory, then create symlinks 
for file in $files; do
    new_file_path="$dir/.${file}"
    original_file_path="$HOME/.$file"
    for file_a in $append_files; do
        if [ "$file_a" == "$file" ]
        then
            append_match=1
            break
        fi
    done
    
    if [ -e "$original_file_path" ]
    then
        if [ "$append_match" == "1" ] 
        then
            echo "Copying $original_file_path to $backupDir/.$file"
            cp "$original_file_path" "$backupDir/$file"
            echo "Appending $new_file_path to $original_file_path"
            python merge.py "$original_file_path" "$new_file_path"         
        else
            echo "Moving existing dotfile from $original_file_path to $backupDir/.$file"
            mv "$original_file_path" "$backupDir/.$file"
            echo "Creating symlink to $new_file_path in home directory."
            ln -s "$new_file_path" "$original_file_path"
            echo
        fi
    else
        echo "Creating symlink to $new_file_path in home directory."
        ln -s "$new_file_path" "$original_file_path"
        echo
    fi
done
echo 