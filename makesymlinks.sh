#!/bin/sh
############################
# This script creates symlinks from the home directory to every dot file in ~/dotfiles
# https://github.com/lerouxrgd/dotfiles/blob/master/makesymlinks.sh
############################

########## Variables

dotfiles_dir=~/dotfiles       # dotfiles directory
backup_dir=~/dotfiles_backup  # old dotfiles backup directory
excluded_files="..|.|.git"

##########

echo "Using $backup_dir for dotfiles backup"
mkdir -p $backup_dir

cd $dotfiles_dir

for file in .* ; do
    [[ $file =~ ^($excluded_files)$ ]] && continue
    if [ -h ~/$file ]; then
        echo "~/$file is already symlink to `readlink ~/$file`"
    else
        if [ -e ~/$file ]; then
            echo "Moving ~/$file to $backup_dir for backup"
            mv ~/$file $backup_dir
        fi
        echo "Creating symlink to $file in home directory."
        ln -s $dotfiles_dir/$file ~/$file
    fi
done
