#Variables

DIR=~/.dotfiles;
OLD_DIR=~/.dotfiles_bak;
FILES=".bashrc .bash_aliases .vimrc .vim";

#Create backup folder
echo "Creating $OLD_DIR for backing up dotfiles in ~";
mkdir -p $OLD_DIR;
echo "...done";

#Move old dotfiles in ~ to backup dir and create symlinks at ~ using the new dotfiles
for FILE in $FILES; do
    echo "Moving $FILE from ~ to $OLD_DIR ..."
    mv ~/$FILE $OLD_DIR/.
    echo "Symlinking $FILE from $DIR to ~ ..."
    ln -s $DIR/$FILE ~/$FILE
done

source ~/.bashrc
source ~/.bash_aliases
source ~/.vimrc

