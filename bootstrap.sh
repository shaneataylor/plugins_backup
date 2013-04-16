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

if [ "$1" == "-workspace" ]; then
    ORIG_CWD=$2
    shift
    shift
else
    ORIG_CWD=$PWD
fi

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

# install DITA-OT version
#
# Usage: install_dita VERSION

function install_dita()
{
    DITA_OT_VERSION=$1
    DITA_OT_VR=`expr $DITA_OT_VERSION : "\([0-9][0-9]*\.[0-9][0-9]*\)\."`
    if [ "$DITA_OT_VERSION" = "1.5.4" ]; then
        DITA_OT_URL="http://downloads.sourceforge.net/project/dita-ot/DITA-OT%20Stable%20Release/DITA%20Open%20Toolkit%201.5.4"
    else
        DITA_OT_URL="http://downloads.sourceforge.net/project/dita-ot/DITA-OT%20Stable%20Release/DITA%20Open%20Toolkit%20${DITA_OT_VR}"
    fi
    DITA_OT_FILENAME="DITA-OT${DITA_OT_VERSION}_full_easy_install_bin.tar.gz"
    DITA_DIR="deps/DITA-OT${DITA_OT_VERSION}"
    #export DITA_DIR="${ORIG_CWD}/deps/DITA-OT${DITA_OT_VERSION}"
    
    echo -e "\nDownloading DITA-OT $DITA_OT_VERSION"
    echo -e "\n  (source: ${DITA_OT_URL}/${DITA_OT_FILENAME})"
    fetchcmd "${DITA_OT_URL}/${DITA_OT_FILENAME}" $DITA_OT_FILENAME
    echo -e "\nUnpacking DITA-OT"
    unpack $DITA_OT_FILENAME DITA-OT${DITA_OT_VERSION}

    if [ -f "$DITA_DIR"/tools/ant/bin/ant ] && [ ! -x "$DITA_DIR"/tools/ant/bin/ant ]; then
      echo -e "\nEnable execution for DITA-OT Ant"
      chmod +x "$DITA_DIR"/tools/ant/bin/ant
    fi
    
    if [ -d dita_ot_patches/"${DITA_OT_VERSION}" ]; then
        echo -e "\nInstalling DITA-OT patches"
        cp -Rfpv dita_ot_patches/"${DITA_OT_VERSION}"/ ${DITA_DIR}
    fi
}

# install a DITA-OT plugin
# 
# Usage:
#     install_plugin PLUGIN NAME OT-VERSION
# 
# Parameters:
#     PLUGIN - the folder in dita_ot_plugins where the plugin is stored.
#     NAME - user-friendly name for the plugin, use to notify the user
function install_plugin()
{
    PLUGIN=$1
    NAME=$2
    DITA_OT_VERSION=$3
    DITA_DIR="deps/DITA-OT${DITA_OT_VERSION}"
    
    # Mimimum required to ensure integrator.xml works for plugin installation 
    NEW_CLASSPATH="$DITA_DIR/lib"
    if [ -n "$CLASSPATH" ]; then
        export CLASSPATH="$NEW_CLASSPATH":"$CLASSPATH"
    else
        export CLASSPATH="$NEW_CLASSPATH"
    fi
    
    if [ -d "$DITA_DIR/plugins/$PLUGIN" ]; then
        # Remove old version of plugin & run integrator to get rid of cruft
        echo -e "\nRemoving previous version of the $NAME plugin..."
        rm -R $DITA_DIR/plugins/$PLUGIN
        $DITA_DIR/tools/ant/bin/ant -f $DITA_DIR/integrator.xml 
    fi
    echo -e "\nInstalling $NAME plugin..."
    cp -Rf dita_ot_plugins/$PLUGIN $DITA_DIR/plugins
    $DITA_DIR/tools/ant/bin/ant -f $DITA_DIR/integrator.xml 
}


echo -e "\nCreating requisite directories"
mkdir -p downloads
mkdir -p deps

echo -e "\nDownloading Ant-Contrib Tasks 1.0b3"
fetchcmd http://downloads.sourceforge.net/sourceforge/ant-contrib/ant-contrib/1.0b3/ant-contrib-1.0b3-bin.zip ant-contrib-1.0b3-bin.zip

echo -e "\nUnpacking ANT-Contrib"
unpack ant-contrib-1.0b3-bin.zip ant-contrib 'ZIP'

install_dita 1.5.4
install_dita 1.7.2

echo -e "\nInstalling DITA-OT plugins"

install_plugin net.webassign.pdf "WebAssign PDF" 1.5.4
install_plugin net.webassign.webhelp "WebAssign webhelp" 1.7.2

# Moved extraction of DITA source files to build process