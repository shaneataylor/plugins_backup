<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://example.com/namespace"
    exclude-result-prefixes="xs fn"
    version="2.0">
    
    <xsl:import href="plugin:org.dita.base:xsl/common/output-message.xsl"></xsl:import>
    <xsl:param name="msgprefix">DOTX</xsl:param>
    
    <xsl:output method="text" encoding="UTF-8" indent="no"/>
    
    <xsl:template match="/*">
        <xsl:text>{
</xsl:text>
        <xsl:apply-templates select="topicSummary"/>
        <xsl:text>
}</xsl:text>
    </xsl:template>
    
    <xsl:template match="//topicSummary">
        <xsl:text>"</xsl:text>
        <xsl:value-of select="@href"/>
        <xsl:text>" : {"searchtitle" : "</xsl:text>
        <xsl:value-of select="@searchtitle"/>
        <xsl:text>" , "shortdesc" : "</xsl:text>
        <xsl:value-of select="@shortdesc"/>
        <xsl:text>"}</xsl:text>
        <xsl:if test="not(position() = last())">
            <xsl:text>,
</xsl:text>
        </xsl:if>
    </xsl:template>
    
    
</xsl:stylesheet>