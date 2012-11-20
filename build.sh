#######################################
# build.sh - build the documentation
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
DITA_OT_VERSION='1.5.4'

export DITA_DIR="$WORKING_DIR/deps/DITA-OT${DITA_OT_VERSION}"
export ANT_HOME="$DITA_DIR/tools/ant"
export FOP_HOME="$DITA_DIR/demo/fo/fop"

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

echo -e "\nPulling DITA files from git."
$ANT_HOME/bin/ant -logfile "$WORKING_DIR/logs/gitpull.xml" -buildfile git.xml gitpull

echo -e "\nBuilding student help."
$ANT_HOME/bin/ant -logfile "$WORKING_DIR/logs/student_webhelp.xml" student_webhelp

echo -e "\nBuilding admin help."
$ANT_HOME/bin/ant -logfile "$WORKING_DIR/logs/admin_webhelp.xml" admin_webhelp

echo -e "\nBuilding instructor help."
$ANT_HOME/bin/ant -logfile "$WORKING_DIR/logs/instructor_webhelp.xml" instructor_webhelp

echo -e "\nBuilding Student Guide PDF."
$ANT_HOME/bin/ant -logfile "$WORKING_DIR/logs/student_guide.xml" student_guide

echo -e "\nBuilding Instructor Guide PDF."
$ANT_HOME/bin/ant -logfile "$WORKING_DIR/logs/instructor_guide.xml" instructor_guide

echo -e "\nBuilding Creating Questions Guide PDF."
$ANT_HOME/bin/ant -logfile "$WORKING_DIR/logs/creating_questions.xml" creating_questions


