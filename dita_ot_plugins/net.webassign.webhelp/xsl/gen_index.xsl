<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://example.com/namespace"
    exclude-result-prefixes="xs fn"
    version="2.0">
    
    <xsl:import href="plugin:org.dita.base:xsl/common/output-message.xsl"></xsl:import>
    <xsl:param name="msgprefix">DOTX</xsl:param>
    <xsl:param name="classmaps">
        <classmap ditaclass=" topic/title " jsonkey="titles"/>
        <classmap ditaclass=" topic/shortdesc " jsonkey="shortdescs"/>
        <classmap ditaclass=" topic/abstract " jsonkey="abstracts"/>
        <!--<classmap ditaclass=" topic/related-links " jsonkey="links"/>-->
        <classmap ditaclass=" topic/keyword " jsonkey="keywords"/>
        <classmap ditaclass=" topic/indexterm " jsonkey="indexterms"/>
        <classmap ditaclass=" topic/body " jsonkey="body"/>
    </xsl:param>
    <xsl:param name="classmapcount" select="count($classmaps/classmap)"/>
    
    
    
    <xsl:output method="text" encoding="UTF-8" indent="yes"/>
    
    <xsl:function name="fn:jsonstring" as="xs:string">
        <xsl:param name="nodetext" as="xs:string"/>
        <xsl:value-of select="fn:striplinebreaks(fn:quotecontrolchars($nodetext))"/>
    </xsl:function>
    
    <xsl:function name="fn:quotecontrolchars">
        <xsl:param name="nodetext" as="xs:string"/>
        <xsl:value-of select="replace($nodetext, '([&quot;\\])', '\\$1')"/>
    </xsl:function>
    
    <xsl:function name="fn:striplinebreaks">
        <xsl:param name="nodetext" as="xs:string"/>
        <xsl:value-of select="normalize-space(translate($nodetext,' &#9;&#10;', ' '))"/>
    </xsl:function>
    
    
    
    <xsl:template match="*[contains(@class,' topic/topic ')]">
        <!-- problems to figure out:
            * nested topics
            * topic ID not the same as file name
            * topics not in flat output file structure
            * draft-comments, required-cleanup not excluded 
                  (filtered content is already excluded in preprocessed temp xml files)
             -->
        <!-- outer structure -->
        <xsl:text>{
    </xsl:text>
        <xsl:call-template name="loop_through_classmaps"/>
        <xsl:text>}</xsl:text>
        <!-- add comma and linebreak after all but the last -->
    </xsl:template>
    
    <xsl:template name="loop_through_classmaps">
        <xsl:param name="classmapcounter" select="$classmapcount"/>
        <xsl:param name="thiskey" select="$classmaps/classmap[position()=$classmapcounter]/@jsonkey"/>
        <xsl:param name="thisclass" select="$classmaps/classmap[position()=$classmapcounter]/@ditaclass"/>
        <xsl:if test="not($classmapcounter = 0)">
            <xsl:text>"</xsl:text><xsl:value-of select="$thiskey"/><xsl:text>" : "</xsl:text>
            <xsl:apply-templates mode="getText" select="//*[contains(@class,$thisclass)]"/>
            <!--<xsl:for-each select="//*[contains(@class,$classmaps/classmap[position()=$classmapcounter]/@ditaclass)]">
                <xsl:value-of select="fn:jsonstring(string-join(.,' '))"/>
                <xsl:text> </xsl:text>
            </xsl:for-each>-->
            <xsl:choose>
                <!-- add comma and indent after all but the last -->
                <xsl:when test="$classmapcounter = 1">
                    <xsl:text>"
</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>",
    </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            
            <!-- Oops! I did it again. -->
            <xsl:call-template name="loop_through_classmaps">
                <xsl:with-param name="classmapcounter">
                    <xsl:value-of select="$classmapcounter - 1"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <xsl:template mode="getText" match=".">
        <!-- return parsed text value using functions above -->
        <xsl:value-of select="fn:jsonstring(string-join(.,' '))"/>
        <xsl:text> </xsl:text>
    </xsl:template>
    
    <xsl:template mode="getText" match=".//*[contains(@class,' topic/draft-comment ') or contains(@class,' topic/required-cleanup ')]">
        
    </xsl:template>
    
    
</xsl:stylesheet>