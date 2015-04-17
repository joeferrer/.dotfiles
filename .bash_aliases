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
    if [ "$#" -ne 1 ]; then
        echo 'vimsync needs complete remote';
        return -1;
    fi
    rsync ~/.vimrc $1:~/ -auvz;
    rsync ~/.vim/ $1:~/.vim/ -auvz;
}

function bashsync() {
    if [ "$#" -ne 1 ]; then
        echo 'bashsync needs complete remote';
        return -1;
    fi
    rsync ~/.bashrc $1:~/ -auvz;
    rsync ~/.bash_aliases $1:~/ -auvz;
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
