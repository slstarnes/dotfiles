#!/bin/bash

########## Variables

dir="$(pwd)"                    # dotfiles directory
backupDir="$HOME/.dotfiles_backup/$(date)"            # old dotfiles backup directory
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

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    new_file_path="$dir"
    new_file_path+="/.${file}"
    original_file_path="$HOME/.$file"
    echo "30 $new_file_path, $original_file_path"
    for file_a in $append_files; do
        echo "32 $file_a"
        if [ "$file_a" == "$file" ] 
        then
            append_match=1
            echo "36 -- match"
            echo "append_match $append_match"
            break
        fi
    done
    
    if [ -e $original_file_path ]
    then
        echo "45 $original_file_path exists"
        if [ "$append_match" == "1" ] 
        then
            # echo "48 - append_match is true, $original_file_path, $new_file_path, $tmp_fn"
            # prepend
            # echo "$original_file_path + $new_file_path > $new_file_path"
            # echo "------- $original_file_path -------"
            # echo "$(cat $original_file_path)"
            # echo
            # echo "------- $new_file_path -------"
            # echo "$(cat $new_file_path)"
            # echo
            # cat "$original_file_path" "$new_file_path" > "$tmp_fn"
            for f in "$original_file_path" "$new_file_path"; do
                # echo "62 $f" 
                (cat "${f}"; echo) >> $tmp_fn
            done
            mv "$tmp_fn" "$new_file_path"
            rm -f "$tmp_fn"
            # echo "------- $new_file_path -------"
            # echo "$(cat $new_file_path)"
            
        fi
        echo "Moving any existing dotfiles from $original_file_path to $backupDir/.$file"
        mv "$original_file_path" "$backupDir/$file"
        # echo "Removing existing dotfile"
        # rm "$HOME/.$file"
    fi
    echo "Creating symlink to $file in home directory."
    ln -s "$new_file_path" "$original_file_path"
    echo
done
echo 