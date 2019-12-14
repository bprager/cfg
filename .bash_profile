if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
	. /opt/local/etc/profile.d/bash_completion.sh
fi
source ~/.bashrc

##
# Your previous /Users/bernd/.bash_profile file was backed up as /Users/bernd/.bash_profile.macports-saved_2019-12-13_at_21:18:55
##

# MacPorts Installer addition on 2019-12-13_at_21:18:55: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

