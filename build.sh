#######################################
# build.sh - build the documentation
#
# TODO: add more output for the user, color code some of it to separate from
#       the stderr output from ant
#
# TODO: Usage help
#
# Get the absolute path of our current directory
WORKING_DIR=$PWD

export DITA_DIR="$WORKING_DIR/deps/DITA-OT1.6.1"
export ANT_HOME="$DITA_DIR/tools/ant"
export FOP_HOME="$DITA_DIR/plugins/org.dita.pdf2/fop"

if [ -f "$ANT_HOME/bin/ant ] && [ ! -x "$ANT_HOME/bin/ant ]; then
chmod +x "$ANT_HOME/bin/ant"
fi

export ANT_OPTS="-Xmx512m $ANT_OPTS"
export ANT_OPTS="$ANT_OPTS -Djavax.xml.transform.TransformerFactory=net.sf.saxon.TransformerFactoryImpl"
export PATH="$PATH:$ANT_HOME/bin"

# From DITA-OT 1.6.1:
NEW_CLASSPATH="$DITA_DIR/lib/dost.jar"
NEW_CLASSPATH="$DITA_DIR/lib:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/commons-codec-1.4.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/resolver.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/icu4j.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/xercesImpl.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/xml-apis.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/saxon/saxon9.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/saxon/saxon9-dom.jar:$NEW_CLASSPATH"

# Additional (deprecated?) classpaths from previous version of this file:
# NEW_CLASSPATH="$DITA_DIR/lib/saxon/saxon9-dom4j.jar:$NEW_CLASSPATH"
# NEW_CLASSPATH="$DITA_DIR/lib/saxon/saxon9-jdom.jar:$NEW_CLASSPATH"
# NEW_CLASSPATH="$DITA_DIR/lib/saxon/saxon9-s9api.jar:$NEW_CLASSPATH"
# NEW_CLASSPATH="$DITA_DIR/lib/saxon/saxon9-sql.jar:$NEW_CLASSPATH"
# NEW_CLASSPATH="$DITA_DIR/lib/saxon/saxon9-xom.jar:$NEW_CLASSPATH"
# NEW_CLASSPATH="$DITA_DIR/lib/saxon/saxon9-xpath.jar:$NEW_CLASSPATH"
# NEW_CLASSPATH="$DITA_DIR/lib/saxon/saxon9-xqj.jar:$NEW_CLASSPATH"

if test -n "$CLASSPATH"
then
export CLASSPATH="$NEW_CLASSPATH":"$CLASSPATH"
else
export CLASSPATH="$NEW_CLASSPATH"
fi


echo "Running ant... Check 'build_log.xml' for additional output."

$ANT_HOME/bin/ant -lib "$DITA_DIR/lib" -lib "$DITA_DIR/lib/commons-codec-1.4.jar" -lib "$DITA_DIR/lib/dost.jar" -lib "$DITA_DIR/lib/icu4j.jar" -lib "$DITA_DIR/lib/resolver.jar" -lib "$DITA_DIR/lib/saxon/saxon9-dom.jar" -lib "$DITA_DIR/lib/saxon/saxon9.jar" -logger org.apache.tools.ant.XmlLogger -Dant.XmlLogger.stylesheet.uri=$WORKING_DIR/logs/build_log.xsl -logfile "$WORKING_DIR/logs/build_log.xml" -Ddita.dir="$DITA_DIR" -Dfop.home="$FOP_HOME" $@


# Adding these did not resolve missing DetectLang class
# -lib "$DITA_DIR/plugins/webhelp/lib/lucene-analyzers-3.0.0.jar" -lib "$DITA_DIR/plugins/webhelp/lib/lucene-core-3.0.0.jar" -lib "$DITA_DIR/plugins/webhelp/lib/nw-cms.jar" -lib "$DITA_DIR/lib/jsearch.jar"  -lib "$DITA_DIR/lib/xercesImpl.jar"


# $ANT_HOME/bin/ant 
# -lib "$DITA_DIR" 
# -lib "$DITA_DIR/lib/commons-codec-1.4.jar"  
# -lib "$DITA_DIR/lib/dost.jar"  
# -lib "$DITA_DIR/lib/jsearch.jar"  
# -lib "$DITA_DIR/lib/resolver.jar" 
# -lib "$DITA_DIR/plugins/webhelp/lib/lucene-analyzers-3.0.0.jar" 
# -lib "$DITA_DIR/plugins/webhelp/lib/lucene-core-3.0.0.jar" 
# -lib "$DITA_DIR/plugins/webhelp/lib/nw-cms.jar" 
# -lib "$FOP_HOME/build/fop.jar"  
# -lib "$FOP_HOME/lib/avalon-framework-4.2.0.jar" 
# -lib "$FOP_HOME/lib/batik-all-1.7.jar"  
# -lib "$FOP_HOME/lib/commons-io-1.3.1.jar" 
# -lib "$FOP_HOME/lib/commons-logging-1.0.4.jar"  
# -lib "$FOP_HOME/lib/xercesImpl-2.7.1.jar" 
# -lib "$FOP_HOME/lib/xml-apis-1.3.04.jar"  
# -lib "$FOP_HOME/lib/xml-apis-ext-1.3.04.jar"  
# -lib "$FOP_HOME/lib/xmlgraphics-commons-1.4.jar"  
# -quiet $@




# OLD COMMENTS - REMOVE

# NEW_CLASSPATH="$DITA_DIR/demo/fo/lib/fo.jar:$NEW_CLASSPATH"
# NEW_CLASSPATH="$FOP_HOME/lib/avalon-framework-4.2.0.jar:$NEW_CLASSPATH"
# NEW_CLASSPATH="$FOP_HOME/lib/commons-io-1.3.1.jar:$NEW_CLASSPATH"
# NEW_CLASSPATH="$FOP_HOME/lib/commons-logging-1.0.4.jar:$NEW_CLASSPATH"
# NEW_CLASSPATH="$FOP_HOME/lib/serializer-2.7.0.jar:$NEW_CLASSPATH"
# NEW_CLASSPATH="$FOP_HOME/lib/xalan-2.7.0.jar:$NEW_CLASSPATH"
# NEW_CLASSPATH="$FOP_HOME/lib/xercesImpl-2.7.1.jar:$NEW_CLASSPATH"
# NEW_CLASSPATH="$FOP_HOME/lib/xml-apis-1.3.04.jar:$NEW_CLASSPATH"
# NEW_CLASSPATH="$FOP_HOME/lib/xml-apis-ext-1.3.04.jar:$NEW_CLASSPATH"
# NEW_CLASSPATH="$FOP_HOME/lib/xmlgraphics-commons-1.4.jar:$NEW_CLASSPATH"
# NEW_CLASSPATH="$FOP_HOME/lib/batik-all-1.7.jar:$NEW_CLASSPATH"

#java" -Xmx256m -classpath "/Applications/oxygen/tools/ant/lib/ant-launcher.jar" "-Dant.home=/Applications/oxygen/tools/ant" org.apache.tools.ant.launch.Launcher

#-lib "$DITA_DIR/lib/resolver.jar" -lib "$DITA_DIR" -lib "$FOP_HOME/lib/commons-io-1.3.1.jar" -lib "$FOP_HOME/lib/commons-logging-1.0.4.jar"  -lib "$DITA_DIR/lib/dost.jar"  -lib "$DITA_DIR/lib/commons-codec-1.4.jar"  -lib "$FOP_HOME/lib/xercesImpl-2.7.1.jar" -lib "$FOP_HOME/lib/xmlgraphics-commons-1.4.jar"  -lib "$FOP_HOME/build/fop.jar"  -lib "$FOP_HOME/lib/batik-all-1.7.jar"  -lib "$FOP_HOME/lib/xml-apis-1.3.04.jar"  -lib "$FOP_HOME/lib/xml-apis-ext-1.3.04.jar"  -lib "$FOP_HOME/lib/avalon-framework-4.2.0.jar" $@

