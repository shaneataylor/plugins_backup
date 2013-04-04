#######################################
# build_styleguide.sh - build the styleguide
#
# TODO: add more output for the user, color code some of it to separate from
#       the stderr output from ant
#
# TODO: Usage help
#
# Get the absolute path of our current directory
WORKING_DIR=$( cd "$( dirname "$0" )" && pwd )
cd ${WORKING_DIR}
echo -e "\nCurrent path is ${WORKING_DIR}"
DITA_OT_VERSION='1.7.2'

export DITA_DIR="$WORKING_DIR/deps/DITA-OT${DITA_OT_VERSION}"
export ANT_HOME="$DITA_DIR/tools/ant"
export FOP_HOME="$DITA_DIR/plugins/org.dita.pdf2/fop"

# Ensure the ant file is executable (sometimes OT installs without this)
if [ -f "$ANT_HOME/bin/ant ] && [ ! -x "$ANT_HOME/bin/ant ]; then
    chmod +x "$ANT_HOME/bin/ant"
fi
export PATH="$PATH:$ANT_HOME/bin"



# Set the libs used by Ant
NEW_CLASSPATH="$DITA_DIR"
NEW_CLASSPATH="$NEW_CLASSPATH:$DITA_DIR/lib"
NEW_CLASSPATH="$NEW_CLASSPATH:$DITA_DIR/lib/commons-codec-1.4.jar"
NEW_CLASSPATH="$NEW_CLASSPATH:$DITA_DIR/lib/dost.jar"
NEW_CLASSPATH="$NEW_CLASSPATH:$DITA_DIR/lib/icu4j.jar"
NEW_CLASSPATH="$NEW_CLASSPATH:$DITA_DIR/lib/resolver.jar"
NEW_CLASSPATH="$NEW_CLASSPATH:$DITA_DIR/lib/saxon/saxon9-dom.jar"
NEW_CLASSPATH="$NEW_CLASSPATH:$DITA_DIR/lib/saxon/saxon9.jar"
NEW_CLASSPATH="$NEW_CLASSPATH:$DITA_DIR/lib/xercesImpl.jar"
NEW_CLASSPATH="$NEW_CLASSPATH:$DITA_DIR/lib/xml-apis.jar"

if [ -n "$CLASSPATH" ]; then
    export CLASSPATH="$NEW_CLASSPATH":"$CLASSPATH"
else
    export CLASSPATH="$NEW_CLASSPATH"
fi


# Set the common options for Ant
export ANT_OPTS="-Xmx512m"
export ANT_OPTS="$ANT_OPTS -Djavax.xml.transform.TransformerFactory=net.sf.saxon.TransformerFactoryImpl"
export ANT_OPTS="$ANT_OPTS -Dant.XmlLogger.stylesheet.uri=build_log.xsl"
export ANT_OPTS="$ANT_OPTS -Ddita.dir=$DITA_DIR"
export ANT_OPTS="$ANT_OPTS -Dfop.home=$FOP_HOME"

export ANT_ARGS="-logger org.apache.tools.ant.XmlLogger"

STEPS=(\
"gitpull" \
"styleguide")

MESSAGES=(\
"\nPulling DITA files from git." \
"\nBuilding styleguide." )

function buildstep()
{
    STEP=$1
    MESSAGE=$2
    BUILDFILE=build_styleguide.xml
    if [ "${STEP}" = "gitpull" ]; then
        BUILDFILE=git_styleguide.xml
    fi
    
    echo -e "${MESSAGE}"
    $ANT_HOME/bin/ant -logfile "$WORKING_DIR/logs/${STEP}.xml" -buildfile ${BUILDFILE} ${STEP}
}

if [ "$#" == "0" ]; then
    for (( i = 0 ; i < ${#STEPS[@]} ; i++ )) do
        buildstep ${STEPS[$i]} "${MESSAGES[$i]}" 
    done
else
    while (( "$#" )); do
        buildstep $1 $1
        shift
    done
fi


