#!/bin/bash 
#
# Author: Josh Johnson <jjohnson@webassign.net>
# Portions by Shane Taylor <shanet@webassign.net>
#
# Bootstrap script - downloads and unpacks necessary tools
#
# REQUIRES: fetch (or wget)
#           tar
#           gunzip
#           git
#           unzip
#
# Java is assumed to be installed.
#
# TODO: add dependency check 
# TOOD: complete fetchcmd() function - use `fetch` or `wget` if curl is 
#       unavailable.
# TODO: get unpack to guess the destination directory instead of having to pass
#       it.      
# TODO: move this to a specialized build tool.
# TODO: log output to a file and restrict console output to letting the user 
#       know pass/fail of each step
#
# TODO: More inline documentation
# TODO: is it possible to query the remote git repo and check for changes?
SOURCE_REPO=git:comm/dita_source_files.git
SOURCE_BRANCH='master'

DITA_DIR='deps/DITA-OT1.6.1'

ORIG_CWD=$PWD

# cleanup if the script fails
function cleanup()
{
    if [ ! "$ORIG_CWD" = "$PWD" ]; then
        cd $ORIG_CWD
    fi
}

trap cleanup SIGINT SIGTERM EXIT;

# fetches a package from a url
#
# Usage: 
#    fetchcmd [URL] [OUTFILE]
#
# Parameters:
#    URL - the url to pull from
#    OUTFILE - what to name the downloaded file
#
# TODO: support other download tools, espcially 'fetch'
function fetchcmd()
{
    URL=$1
    OUTFILE=$2
    
    if [ ! -f "downloads/$OUTFILE" ]; then
        curl -L --output downloads/$OUTFILE $URL
    else
        echo "File $OUTFILE already downloaded. Skipping"
    fi
}

# Unpacks an archive file
#
# Usage:
#    unpack FILE DEST [TYPE]
#
# Parameters:
#    FILE - the archive to unpack
#    DEST - the name of the directory it will go into
#    TYPE - optional, used to differentiate between zip and tar/gz archives.
#           The only understood value is 'ZIP' to indicate a zip archive. tar/gz
#           is assumed otherwise.
function unpack()
{
    FILE=$1
    TYPE=$3
    DEST=$2
    
    if [ -d "deps/$DEST" ]; then
        echo "Destination directory deps/$DEST already exists. Skipping"
        return 0
    fi 
    
    if [ "$TYPE" = 'ZIP' ]; then
        mkdir -p deps/$DEST
        unzip -d deps/$DEST downloads/$FILE
    else
        tar -C deps -zxvf downloads/$FILE
    fi
}

# install a DITA-OT plugin
# 
# Usage:
#     install_plugin LOCATION NAME
# 
# Parameters:
#     LOCATION - the directory where the plugin is stored.
#     NAME - user-friendly name for the plugin, use to notify the user
function install_plugin()
{
    LOCATION=$1
    NAME=$2
    
    echo "Installing $NAME plugin..."
    # NEED TO ADD: Remove existing plugin first, to get rid of cruft
    cp -Rf $LOCATION $DITA_DIR/plugins
    $DITA_DIR/tools/ant/bin/ant -f $DITA_DIR/integrator.xml 
}

echo -e "\nCreating requisite directories"
mkdir -p downloads
mkdir -p deps

echo -e "\nDownloading DITA-OT 1.6.1"
fetchcmd 'http://sourceforge.net/projects/dita-ot/files/DITA-OT%20Stable%20Release/DITA%20Open%20Toolkit%201.6/DITA-OT1.6.1_full_easy_install_bin.tar.gz' DITA-OT1.6.1_full_easy_install_bin.tar.gz

echo -e "\nUnpacking DITA-OT"
unpack DITA-OT1.6.1_full_easy_install_bin.tar.gz DITA-OT1.6.1

if [ -f "$DITA_DIR"/tools/ant/bin/ant ] && [ ! -x "$DITA_DIR"/tools/ant/bin/ant ]; then
  echo -e "\nEnable execution for DITA-OT Ant"
  chmod +x "$DITA_DIR"/tools/ant/bin/ant
fi

echo -e "\nDownloading Ant-Contrib Tasks 1.0b3"
fetchcmd http://downloads.sourceforge.net/sourceforge/ant-contrib/ant-contrib/1.0b3/ant-contrib-1.0b3-bin.zip ant-contrib-1.0b3-bin.zip

echo -e "\nUnpacking ANT-Contrib"
unpack ant-contrib-1.0b3-bin.zip ant-contrib 'ZIP'

echo -e "\nInstalling DITA-OT plugins"

install_plugin dita_ot_plugins/webhelp "Oxygen webhelp"
install_plugin dita_ot_plugins/net.webassign.pdf "WebAssign PDF"
install_plugin dita_ot_plugins/net.webassign.webhelp "WebAssign webhelp"


# Update the checked-out source if it exists, otherwise clone 
# 
# this will get the code without checking it out:
#     git archive --prefix=dita_source_files/ --format=tar --remote=$SOURCE_REPO $SOURCE_BRANCH | tar -xf -
if [ -d ./dita_source_files ]; then
    echo -e "\nUpdating DITA source files" 
    cd dita_source_files
    git pull
    cd $ORIG_CWD
else
    echo -e "\nChecking out DITA source files" 
    git clone $SOURCE_REPO -b $SOURCE_BRANCH
fi

