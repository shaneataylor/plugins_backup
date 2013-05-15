<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

    <xsl:template match="/">
        <html>
            <head>
                <style type="text/css"><![CDATA[
body {
    font-size: small;
    font-family: arial, helvetica, sans-serif;
}
p {margin: 0px;}
p.note {
    float: right;
    font-style: italic;
    width: 30%;
    }
p.sub {
    padding-left: 1em;
    }
h1,h2 {margin: 0px;}
pre {
    font-family: Consolas, "Courier New", Courier, monospace; 
    margin: 0px;
    white-space: pre-wrap;
    text-indent: -1in;
    padding-left: 1in;
    }
pre.alttxtwarn {color: black; }
pre.otwarn {color: black; background-color: yellow;}
pre.debug {color: #9CC}
pre.info {color: #999; display: none;}
pre.warn {color: black;}
pre.error {font-weight: bold; color: black; background-color: red;}
p.task {color: black;}
p.target {color: #369; margin-bottom: 4px; }
p.stacktrace {color: red;}
div.task {
    }
div.target {
    padding: 4px 0px 0px 8px;
    margin-top: 2px;
    border: 1px solid #eee;
    border-width: 1px 0px 1px 1px;
    background-color: white;
    }
div.errors {
    border-color: red;
    background-color: #fdd;
    }
div.warnings {
    border-color: #cc6;
    background-color: #ffd;
    }
div.summary {
    padding: 4pt;
    border: 2px solid #999;
    background-color: #CCC;
    }
pre.stacktrace {
    border: 2px solid red;
    color: black;
    }
span.errwarn {
    display: inline-block;
    float: right;
    color: #999;
    }
span.warnings {
    color: black;
    font-weight: bold;
    }
span.errors {
    color: red;
    font-weight: bold;
    }
                    ]]>
                </style>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="build">
        <h1>Build Log</h1>
        
        <div class="summary">
            <h2>Summary</h2>
            <p class="note">Error and warning counts are based on the priority attribute of the message element, which is not always useful. Some <q>warnings</q> are strictly informational, and highlighting in this log has been adjusted to reflect that.</p>
            <p><xsl:value-of select="//*[contains(node(),'* input =')]"/></p>
            <p>Time: <xsl:value-of select="@time"/></p>
            <p>Errors: <xsl:value-of select="count(//message[@priority='error'] | //stacktrace)"/></p>
            <p>Warnings: <xsl:value-of select="count(//message[@priority='warn'][contains(.,'WARN')])"/></p>
            <p class="sub">Flagging attribute: <xsl:value-of select="count(//message[contains(node(),'[DOTX042I]')])"/></p>
            <p class="sub">Missing short description: <xsl:value-of select="count(//message[contains(node(),'No short description found')])"/></p>
            <p class="sub">Missing alt text: <xsl:value-of select="count(//message[contains(node(),'Alternate text is missing on external-graphic.')] | //message[contains(node(),'Image is missing alternative text.')])"/></p>
            <p class="sub">FOP event listener: <xsl:value-of select="count(//message[contains(node(),'org.apache.fop.events.LoggingEventListener')])"/></p>
        </div>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="message">
        <xsl:variable name="msgbody"><xsl:value-of select="." disable-output-escaping="yes"/></xsl:variable>
        <xsl:variable name="msgclass">
            <xsl:choose>
                <xsl:when test="contains($msgbody,'Alternate text is missing on external-graphic')">alttxtwarn</xsl:when>
                <xsl:when test="contains($msgbody,'[WARN]') or starts-with($msgbody,'WARNING')">otwarn</xsl:when>
                <xsl:when test="contains($msgbody,'org.apache.fop.events.LoggingEventListener processEvent')">info</xsl:when>
                <xsl:when test="contains($msgbody,'org.apache.fop.apps.FopFactoryConfigurator configure')">info</xsl:when>
                <xsl:when test="starts-with($msgbody,'INFO:')">info</xsl:when>
                <xsl:otherwise><xsl:value-of select="@priority"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <pre>
            <xsl:attribute name="class"><xsl:value-of select="$msgclass"/></xsl:attribute>
            <xsl:value-of select="$msgbody" disable-output-escaping="yes"/>
        </pre>
    </xsl:template>
    
    <xsl:template match="task">
        <div class="task">
            <!-- @location, @name, @time -->
            <!--<p class="task"><b>TASK <xsl:value-of select="@location"/> :: <xsl:value-of select="@name"/></b> (<xsl:value-of select="@time"/>)</p>-->
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="target">
        <xsl:variable name="errcount"><xsl:value-of select="count(descendant::message[@priority='error'] | descendant::stacktrace)"/></xsl:variable>
        <xsl:variable name="warncount"><xsl:value-of select="count(descendant::message[@priority='warn'][contains(.,'WARN')])"/></xsl:variable>
        <xsl:variable name="errwarncountclass">
            <xsl:choose>
                <xsl:when test="$errcount > 0">errors</xsl:when>
                <xsl:when test="$warncount > 0">warnings</xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <div>
            <xsl:attribute name="class">target <xsl:value-of select="$errwarncountclass"/></xsl:attribute>
            <!-- @name, @time -->
            <p class="target">
                <b><xsl:value-of select="@name"/></b> (<xsl:value-of select="@time"/>)
                <span><xsl:attribute name="class">errwarn <xsl:value-of select="$errwarncountclass"/></xsl:attribute>Errors: <xsl:value-of select="$errcount"/> Warnings: <xsl:value-of select="$warncount"/></span>
            </p>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="stacktrace">
        <p class="stacktrace"><b>STACKTRACE</b></p>
        <pre class="stacktrace"><xsl:value-of select="."/></pre>
    </xsl:template>

</xsl:stylesheet>