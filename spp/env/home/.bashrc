# file: .bashrc
#
# this is the standard SPP ~/.bashrc
#

# source global definitions
#
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# define the location of SPP
#
if [ -z CUSTOM_SPP ]; then
    export SPP="/spp"
else
    export SPP="$CUSTOM_SPP"
fi

# load the spp environment
#
if [ -z SPP_SET ]; then
    . $SPP/env/spp_bashrc.sh
fi

#------------------------------------------------------------------------------
# place user specific customizations here
#------------------------------------------------------------------------------

#
# end of file
