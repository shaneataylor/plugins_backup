#!/bin/bash 
#
# Author: Josh Johnson <jjohnson@webassign.net>
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
# TODO: add dependancy check 
# TOOD: complete fetchcmd() function - use `fetch` or `wget` if curl is 
#       unavailable.
# TODO: get unpack to guess the destination directory instead of having to pass it.      
# TODO: move this to a specialized build tool.
#
SOURCE_REPO=file:///$HOME/Documents/dita_source_files.git
SOURCE_BRANCH='master'

WEBHELP_CUSTOM='dita_source_files/customizations/webhelp_customization'
DITA_DIR='deps/DITA-OT1.5.3'

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

echo "Creating requisite directories"
mkdir -p downloads
mkdir -p deps

echo "Downloading DITA-OT 1.5.3"
fetchcmd 'http://downloads.sourceforge.net/sourceforge/dita-ot/DITA-OT%20Stable%20Release/DITA%20Open%20Toolkit%201.5.3/DITA-OT1.5.3_full_easy_install_bin.tar.gz' DITA-OT1.5.3_full_easy_install_bin.tar.gz
echo "Downloading FOP 1.0"
fetchcmd http://apache.mesi.com.ar//xmlgraphics/fop/binaries/fop-1.0-bin.tar.gz fop-1.0-bin.tar.gz
echo "Downloading ANT 1.8"
fetchcmd http://www.trieuvan.com/apache//ant/binaries/apache-ant-1.8.2-bin.tar.gz apache-ant-1.8.2-bin.tar.gz
#echo "Downloading DITA4Publishers Plugins 0.9.16"
#fetchcmd http://downloads.sourceforge.net/sourceforge/dita4publishers/2011-03-21/dita4publishers-0.9.16.zip dita4publishers-0.9.16.zip
echo "Downloading Oxygen 12.2"
fetchcmd http://archives.oxygenxml.com/Oxygen/Editor/InstData12.2/All/oxygen.tar.gz oxygen.tar.gz
echo "Downloading Ant-Contrib Tasks 1.0b3"
fetchcmd http://downloads.sourceforge.net/sourceforge/ant-contrib/ant-contrib/1.0b3/ant-contrib-1.0b3-bin.zip ant-contrib-1.0b3-bin.zip

echo "Unpacking DITA-OT"
unpack DITA-OT1.5.3_full_easy_install_bin.tar.gz DITA-OT1.5.3

# echo "Unpacking DITA4Publishers"
# mkdir dita4publishers-0.9.16
# unzip -d dita4publishers-0.9.16 dita4publishers-0.9.16.zip
# echo "Unpacking DITA4Publishers Plugins to DITA-OT1.5.3/plugins"
# unzip -d DITA-OT1.5.3/plugins dita4publishers-0.9.16/dita4publishers-toolkit-plugins-0.9.16.zip

echo "Unpacking ANT"
unpack apache-ant-1.8.2-bin.tar.gz apache-ant-1.8.2

echo "Unpacking ANT-Contrib"
unpack ant-contrib-1.0b3-bin.zip ant-contrib 'ZIP'

echo "Unpacking FOP"
unpack fop-1.0-bin.tar.gz fop-1.0

echo "Unpacking Onygen"
unpack oxygen.tar.gz oxygen

echo "Checking out DITA source files"
#git archive --prefix=dita_source_files/ --format=tar --remote=$SOURCE_REPO $SOURCE_BRANCH | tar -xf -
git clone $SOURCE_REPO -b $SOURCE_BRANCH

echo "Installing webhelp plugin and customizations into DITA-OT"

cp -Rf deps/oxygen/frameworks/dita/DITA-OT/plugins/webhelp $DITA_DIR/plugins
cp -fv $WEBHELP_CUSTOM/strings-en-us.xml $DITA_DIR/xsl/common
cp -fv $WEBHELP_CUSTOM/dita2webhelpImpl.xsl $DITA_DIR/plugins/webhelp/xsl
cp -fv $WEBHELP_CUSTOM/map2webhelptoc.xsl $DITA_DIR/plugins/webhelp/xsl
cp -fv $WEBHELP_CUSTOM/assets/* $DITA_DIR/plugins/webhelp/resources/assets
cp -fv $WEBHELP_CUSTOM/assets/images/* $DITA_DIR/plugins/webhelp/resources/assets/images


echo "Doing intial integration (installs plugins)"
./deps/apache-ant-1.8.2/bin/ant -f $DITA_DIR/integrator.xml 

OLDCWD=$PWD
cd dita_source_files
echo -n "Patching source code..."
PATCH_OK = `git apply --check ../source_changes.patch`
if [ $PATCH_OK ]; then
    git apply ../source_changes.patch
    echo " patch applied"
else
    echo " patch check FAILED. Either code is already up to date or something is wrong with the patch"
fi
