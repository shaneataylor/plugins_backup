<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://example.com/namespace"
    exclude-result-prefixes="xs fn"
    version="2.0">
    
    <xsl:import href="plugin:org.dita.base:xsl/common/output-message.xsl"></xsl:import>
    <xsl:param name="msgprefix">DOTX</xsl:param>
    
    <xsl:param name="thisindextarget" />
    <xsl:param name="outext" />
    
    <xsl:param name="classmaps">
        <classmap ditaclass=" topic/body " jsonkey="body"/>
        <classmap ditaclass=" topic/abstract " jsonkey="abstracts"/>
        <!--<classmap ditaclass=" topic/related-links " jsonkey="links"/>-->
        <classmap ditaclass=" topic/shortdesc " jsonkey="shortdesc" first="true"/>
        <classmap ditaclass=" topic/keyword " jsonkey="keywords"/>
        <classmap ditaclass=" topic/indexterm " jsonkey="indexterms"/>
        <classmap ditaclass=" topic/title " jsonkey="titles"/>
        <classmap ditaclass=" topic/title " jsonkey="firsttitle" first="true" />
    </xsl:param>
    <xsl:param name="classmapcount" select="count($classmaps/classmap)"/>
    
    <xsl:output method="text" encoding="UTF-8" indent="no"/>
    
    <xsl:template match="/*"><!-- if nested topics, treat as one unit -->
        <!-- problems to figure out (maybe all handled with preprocessing?):
            * topics not in flat output file structure
            * copy-to 
             -->
        <!-- outer structure -->
        <xsl:text>{
"id": "</xsl:text>
        <xsl:value-of select="replace($thisindextarget,'\.xml',$outext)"/>
        <xsl:text>",</xsl:text>
        <xsl:call-template name="loop_through_classmaps"/>
        <xsl:text>
}</xsl:text>
        <!-- add comma and linebreak after all but the last -->
    </xsl:template>
    
    <xsl:template name="loop_through_classmaps">
        <xsl:param name="classmapcounter" select="$classmapcount"/>
        <xsl:param name="thiskey" select="$classmaps/classmap[position()=$classmapcounter]/@jsonkey"/>
        <xsl:param name="thisclass" select="$classmaps/classmap[position()=$classmapcounter]/@ditaclass"/>
        <xsl:param name="thisfirst" select="$classmaps/classmap[position()=$classmapcounter]/@first or false()"/>
        <xsl:if test="not($classmapcounter = 0)">
            <xsl:text>"</xsl:text><xsl:value-of select="$thiskey"/><xsl:text>" : "</xsl:text>
            <xsl:choose>
                <xsl:when test="$thisfirst">
                    <xsl:apply-templates mode="getText" select="(//*[contains(@class,$thisclass)])[1]"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates mode="getText" select="//*[contains(@class,$thisclass)]"/>
                </xsl:otherwise>
            </xsl:choose>
            
            <xsl:choose>
                <!-- add comma and indent after all but the last -->
                <xsl:when test="$classmapcounter = 1">
                    <xsl:text>"</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>",</xsl:text>
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
    
    <xsl:template mode="getText" match="*">
        <xsl:apply-templates mode="getTextChildren" select="*|text()"/>
    </xsl:template>
    
    <xsl:template mode="getTextChildren" match="*">
        <xsl:if test="count(ancestor-or-self::*[contains(@class,' topic/draft-comment ')]) + count(ancestor-or-self::*[contains(@class,' topic/required-cleanup ')]) = 0">
            <xsl:apply-templates mode="getTextChildren" select="*|text()"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template mode="getTextChildren" match="text()">
        <xsl:value-of select="replace(concat(replace(., '([&quot;\\])', '\\$1'),' '),'\s+',' ')"/>
    </xsl:template>
    
</xsl:stylesheet>