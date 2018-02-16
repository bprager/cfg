# .bashrc

# User specific aliases and functions
alias vi=nvim
alias date=gdate
alias ls="ls -Fa"
# alias socks="ssh -D 8080 -f -C -q -N -o ServerAliveInterval=10 pragerws@box307.bluehost.com"
alias socks="ssh -D 8080 -f -C -q -N -o ServerAliveInterval=10 bernd@shell.xshellz.com"
alias folders="ls -R | grep : | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"
alias alert_helper='history|tail -n1|sed -e "s/^\s*[0-9]\+\s*//" -e "s/;\s*alert$//"'
alias alert='notify-send -i /usr/share/icons/gnome/32x32/apps/gnome-terminal.png "[$?] $(alert_helper)"'
alias prettyjson='python -m json.tool'
alias crontab="VIM_CRONTAB=true crontab"
alias sqlplus='rlwrap sqlplus'
alias sftp='rlwrap sftp'
alias mvn='rlwrap mvn'
alias mail='rlwrap mail'

function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

daysLeftThisMonth() {
  bc -l <<< "$(gdate -d "$(gdate +%Y-%m-01) +1 month -1 day" +%d) - $(gdate +%d)"
}
export -f daysLeftThisMonth

now() {
  date +"%M%H%d%m%y"
}
export -f now

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PATH=$PATH:$HOME/bin

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/Contents/Home/"
export MW_HOME="/usr/share/wls12130"
export USER_MEM_ARGS="-Xmx1024m -XX:PermSize=1024m"

export CFLAGS="-march=native"
export LDFLAGS="$LDFLAGS -L/usr/local/lib"

export PS1="$NM-=[$HI\t$NM][$HI\u$NI@$HI\h $SI\w$NM]=-\n $IN"
# export CVSROOT=":pserver:bernd@prager.homeip.net:/home/cvs"

export EDITOR=nvim
export CVSEDITOR=nvim

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000
HISTFILESIZE=2000
export HISTCONTROL=ignoredups

export LIBRARY_PATH=/lib/:/usr/lib/:/usr/local/lib/
export LIBDIR=$LIBRARY_PATH
export LD_LIBRARY_PATH=$LIBRARY_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/

#some colors
NM="\[\e[0;1;37m\]"   #means no background and white lines
HI="\[\e[0;$((31 + $(hostname | cksum | cut -c1-3) % 6))m\]" #change this for letter colors
SI="\[\e[0;32m\]"     #this is for the current directory
# NI="\[\e[0;0;37m\]"   #for @ symbol
NI="\[\e[0m\]"   #for @ symbol
IN="\[\e[0m\]"

#ec2
export EC2_HOME=$HOME/ec2-api-tools-1.4.4.1/
export EC2_KEYPAIR=ec2key # name only, not the file name
export EC2_URL=https://ec2.us-east-1.amazonaws.com
export EC2_PRIVATE_KEY=$HOME/.ec/pk-YWZ6XR64RXEXNMDJKYZ7VZRPZTQCGT4G.pem
export EC2_CERT=$HOME/.ec/cert-YWZ6XR64RXEXNMDJKYZ7VZRPZTQCGT4G.pem
export M2_HOME=/opt/local/share/java/maven3
export M2=$M2_HOME/bin
export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH

export PS1="$NM-=[$HI\t$NM][$HI\u$NI@$HI\h $SI\w$NM]=-\n$IN "
export CLICOLOR=1
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    PS1="$HI${debian_chroot:+($debian_chroot)}\u@\h$ \w\a\]$NM"
    ;;
xterm-256color)
    export TERM="xterm-color"
    ;;
esac


if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto'
    set_term_title(){
           echo -en "\033]0;$1\a"
       }
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -aF $LS_OPTIONS'
    eval `dircolors ~/.dir_colors`
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias stopWebLogic='/usr/share/wls12130/user_projects/domains/mydomain/bin/stopWebLogic.sh'
alias startWebLogic='/usr/share/wls12130/user_projects/domains/mydomain/startWebLogic.sh'

stty -ixon -ixoff

function cfiles {
    find -regextype posix-egrep -regex '.*\.h$|.*\.hpp$|.*\.c$|.*\.cpp|.*\.cc$'
}

function cgrep {
   2>/dev/null grep -n "$@" $(cfiles) | nl | grep "$@"
}

function hfiles {
    find -regextype posix-egrep -regex '.*\.h|.*\.hpp'
}

function hgrep {
    2>/dev/null grep -n "$@" $(hfiles) | nl | grep "$@"
}

function pyfiles {
    find -regextype posix-egrep -regex '.*\.py$' | grep -v '#'
}

function pygrep {
   2>/dev/null grep -n "$@" $(pyfiles) | nl | grep "$@"
}

function yank {
    grep "^\s*$@\s" | awk '{print $2}' | sed 's/-\([0-9]*\)-/:\1:/g' | awk -F: '{print $1 " +" $2}' | awk '{print $2 " " $1}' | xargs ${EDITOR:?EDITOR must be set.}
}

# keep X working with sudo
[ -n "$DISPLAY" -a -e "$HOME/.Xauthority" ] && export XAUTHORITY="$HOME/.Xauthority"


#docker aliases
alias setdockerhost='export DOCKER_HOST=tcp://$(docker-machine ip dev 2>/dev/null):2375'

function natboot2docker () {
  VBoxManage controlvm boot2docker-vm natpf1 "$1,tcp,127.0.0.1,$2,,$3";
}

function removeDockerNat () {
  VBoxManage modifyvm boot2docker-vm --natpf1 delete $1;
}

export GRADLE_HOME="/opt/local/share/java/gradle"

# get docker env variables
if [ "$(docker-machine status | tr '[a-z]' '[A-Z]')" == "RUNNING" ]
then
  eval "$(docker-machine env)"
fi

#load iTerm2 shell integration
source ~/.iterm2_shell_integration.`basename $SHELL`

alias scala="export TERM=xterm-color && scala-2.12"

case "$OSTYPE" in
  solaris*) echo "SOLARIS" ;;
  darwin*)  # echo "OSX";
    export CLICOLOR=1;
    export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD;
    ;;
  linux*)   echo "LINUX" ;;
  bsd*)     echo "BSD" ;;
  msys*)    echo "WINDOWS" ;;
  *)        echo "unknown: $OSTYPE" ;;
esac

# local dotfile configuration
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no

# pipenv setup
# export PYTHONUSERBASE=`python -m site --user-base`
export PYTHONUSERBASE='/opt/local/Library/Frameworks/Python.framework/Versions/Current'
export PATH=$PYTHONUSERBASE/bin:$PATH
eval "$(pipenv --completion)"

export GOPATH="$HOME/Projects/BerndsRepo/Go"
