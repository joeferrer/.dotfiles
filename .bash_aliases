#custom functions
function ting() {
    if [ "$#" == 2 ]; then
        echo -ne "\033]0;png-$2\007";
        ping $1;
    else 
        echo 'ting needs a site and label!';
    fi
}

function xid() {
    if [ $1 == '1' ] || [ $1 == '0' ]; then
        xinput;
        read -p 'enter id#: ' id;
        xinput set-prop $id "Device Enabled" $1;
    else
        echo 'xid needs (1/0) arg!';
    fi
}

function vmstart() {
    if [ $1 == 'gui' ] || [ $1 == 'headless' ] || [ $1 == 'sdl' ]; then
        VBoxManage list vms;
        read -p 'enter vmname: ' vmname;
        if [ -z "$vmname" ]; then
            echo 'vmstart needs a specific vm!';
        else
            VBoxManage startvm $vmname --type $1;
        fi
    else 
        echo 'vmstart needs --type arg!';
    fi
}

function vmcontrol() {
    if [ $1 == 'poweroff' ] || [ $1 == 'reset' ] || [ $1 == 'resume' ] || [ $1 == 'pause' ] || [ $1 == 'savestate' ]; then
        VBoxManage list runningvms;
        read -p 'enter running vmname: ' vmname;
        if [ -z "$vmname" ]; then
            echo 'vmcontrol needs a specific running vm!';
        else
            VBoxManage controlvm $vmname $1;
        fi
    else
        echo 'vmcontrol needs control action!';
    fi
}

function vimsync() {
    if [ "$#" == 1 ]; then
        rsync ~/.vimrc $1:~/ -auvz;
        rsync ~/.vim/ $1:~/.vim/ -auvz;
    else 
        echo 'vimsync needs complete remote';
    fi
}

function bashsync() {
    if [ "$#" == 1 ]; then
        rsync ~/.bashrc $1:~/ -auvz;
        rsync ~/.bash_aliases $1:~/ -auvz;
    else
        echo 'bashsync needs complete remote';
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
