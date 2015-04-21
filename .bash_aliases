#custom functions
function ting() {
    if [ "$#" -ne 2 ]; then
        echo 'ting needs a site and label!';
        return -1;
    fi
    echo -ne "\033]0;png-$2\007";
    ping $1;
}

function xid() {
    if [[ "$#" -ne 1 || $1 != 'on' && $1 != 'off' ]]; then
        echo 'xid needs (on/off) arg!';
        return -1;
    fi
    if [ $1 == 'on' ]; then
        mode=1;
    else
        mode=0;
    fi
    xinput;
    read -p 'enter id#: ' id;
    xinput set-prop $id "Device Enabled" $mode;
}

function vmstart() {
    if [[ "$#" -ne 1 || $1 != 'gui' && $1 != 'headless' && $1 != 'sdl' ]]; then
        echo 'vmstart needs --type arg!';
        return -1;
    fi
    VBoxManage list vms;
    read -p 'enter vmname: ' vmname;
    if [ -z "$vmname" ]; then
        echo 'vmstart needs a specific vm!';
        return -1;
    fi
    VBoxManage startvm $vmname --type $1;
}

function vmcontrol() {
    if [[ "$#" -ne 1 || $1 != 'poweroff' && $1 != 'reset' && $1 != 'resume' && $1 != 'pause' && $1 != 'savestate' ]]; then
        echo 'vmcontrol needs control action!';
        return -1;
    fi
    VBoxManage list runningvms;
    read -p 'enter running vmname: ' vmname;
    if [ -z "$vmname" ]; then
        echo 'vmcontrol needs a specific running vm!';
        return -1;
    fi
    VBoxManage controlvm $vmname $1;
}

function vimsync() {
    if [ "$#" -ne 2 ]; then
        echo 'vimsync requires domain and remote!';
        return -1;
    fi

    if [ "$1" == "fln" ]; then
        rsync ~/.dotfiles/.vimrc dev@$2.syd1.fln-dev.net:~/ -auvz;
        rsync ~/.dotfiles/.vim/ dev@$2.syd1.fln-dev.net:~/.vim/ -auvz;
    else
        rsync ~/.dotfiles/.vimrc $2:~/ -auvz;
        rsync ~/.dotfiles/.vim/ $2:~/.vim/ -auvz;
    fi
}

function bashsync() {
    if [ "$#" -ne 2 ]; then
        echo 'bashsync requires domain and remote!';
        return -1;
    fi

    if [ "$1" == "fln" ]; then
        rsync ~/.dotfiles/bashrc dev@$2.syd1.fln-dev.net:~/ -auvz;
        rsync ~/.dotfiles/.bash_aliases dev@$2.syd1.fln-dev.net:~/ -auvz;
    else
        rsync ~/.dotfiles/.bashrc $2:~/ -auvz;
        rsync ~/.dotfiles/.bash_aliases $2:~/ -auvz;
    fi
}

function flnmycnf() {
    if [ "$#" -ne 1 ]; then
        echo 'mycnfsync requires remote!';
        return -1;
    fi
    rsync ~/fln/.my.cnf dev@$1.syd1.fln-dev.net:~/ -auvz;
}

function flndev() {
    if [ "$#" -ne 1 ]; then
        echo 'flndev requires remote!';
        return -1;
    fi
    ssh -o ConnectTimeout=5 dev@$1.syd1.fln-dev.net;
}

function flndir() {
    if [ "$#" -ne 1 ]; then
        echo 'flndir requires dir';
        return -1;
    fi
    if [ $1 == 'sql' ]; then
        cd /mnt/gaf/gaf-cvs/db/changes;
    elif [ $1 == 'log' ]; then
        cd /mnt/logs/;
    elif [ $1 == 'build' ]; then
        cd /mnt/gaf/gaf-cvs/scripts/build-assets/;
    else
        cd /mnt/gaf/gaf-cvs/public/;
    fi
}
#custom  aliases
    #basic
    alias lock="gnome-screensaver-command -l"
    alias shutdown="sudo shutdown -h now"
    alias restart="sudo shutdown -r now"
    alias lhtop="(echo -ne \"\033]0;$HOSTNAME-htop\007\"; htop)"
    
    #system
    alias mirror-off="xrandr --output  VGA1 --mode 1280x1024 --right-of LVDS1 --auto"
    
    #programs
    alias explorer="(nautilus --no-desktop --browser &> /dev/null &)"
    alias chrome="(google-chrome &> /dev/null &)"
    alias ffox="(firefox &> /dev/null &)"
    alias rbox="(rhythmbox &> /dev/null &)"
    alias sshot="(gnome-screenshot --interactive &> /dev/null &)"
    alias kpx="(keepassx &> /dev/null &)"
    alias vbox="(virtualbox &> /dev/null &)"
    alias lsql="echo -ne \"\033]0;lsql\007\"; mysql -u root -p"
    alias rssrapp1="(rssowl &> /dev/null &)"
    alias rssrapp2="(liferea &> /dev/null &)"
    alias gsla="git shortlog --author"
    alias ssrec="(simplescreenrecorder &> /dev/null &)"
    alias charles="(~/Downloads/charles/bin/./charles &> /dev/null &)"
    alias lpy="echo -ne \"\033]0;lpython\007\"; python"
    alias lphp="echo -ne \"\033]0;lphp\007\"; php -a"
