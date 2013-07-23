<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template name="generate-toc">
        <html><xsl:value-of select="$newline"/>
            <head><xsl:value-of select="$newline"/>
                <xsl:if test="string-length($contenttarget)>0 and
                    $contenttarget!='NONE'">
                    <base target="{$contenttarget}"/>
                    <xsl:value-of select="$newline"/>
                </xsl:if>
                <!-- initial meta information -->
                <xsl:call-template name="generateCharset"/>   <!-- Set the character set to UTF-8 -->
                <xsl:call-template name="generateDefaultCopyright"/> <!-- Generate a default copyright, if needed -->
                <xsl:call-template name="generateDefaultMeta"/> <!-- Standard meta for security, robots, etc -->
                <xsl:call-template name="copyright"/>         <!-- Generate copyright, if specified manually -->
                <xsl:call-template name="generateCssLinks"/>  <!-- Generate links to CSS files -->
                <xsl:call-template name="generateMapTitle"/> <!-- Generate the <title> element -->
                <xsl:call-template name="gen-user-head" />    <!-- include user's XSL HEAD processing here -->
                <xsl:call-template name="gen-user-scripts" /> <!-- include user's XSL javascripts here -->
                <xsl:call-template name="gen-user-styles" />  <!-- include user's XSL style element and content here -->
            </head><xsl:value-of select="$newline"/>
            
            <body>
                <xsl:comment>googleoff: all</xsl:comment>
                <xsl:if test="string-length($OUTPUTCLASS) &gt; 0">
                    <xsl:attribute name="class">
                        <xsl:value-of select="$OUTPUTCLASS"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="$newline"/>
                <xsl:apply-templates/>
                <xsl:comment>googleon: all</xsl:comment>
            </body><xsl:value-of select="$newline"/>
        </html>
    </xsl:template>
    
    
</xsl:stylesheet>