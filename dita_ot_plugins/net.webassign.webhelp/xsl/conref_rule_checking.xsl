<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">-->
    
    <!-- 
    NOTES
    * perform this before conref resolution (depend.preprocess.conref.pre)
    * disregard conref pushes since they are not covered by the rule
    * don't process if the h5help.conreftarget.rule is empty or not set
    * use message ID DOTX098W
    
    -->
    
    <xsl:import href="plugin:org.dita.base:xsl/common/output-message.xsl"></xsl:import>
    <xsl:param name="msgprefix">DOTX</xsl:param>
    <xsl:param name="thisconreffer" />
    <xsl:param name="h5help.conreftarget.rule"/>
    
    <xsl:template match="/">
        <xsl:if test="not(empty($h5help.conreftarget.rule))">
            <!--<xsl:message> Checking <xsl:value-of select="$thisconreffer"/> against rule <xsl:value-of select="$h5help.conreftarget.rule"/></xsl:message>-->
            <xsl:apply-templates mode="conref_rule" />
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="*[@conref][@conref!=''][not(@conaction)]" priority="10" mode="conref_rule">
        <xsl:variable name="conrefval" select="@conref"/>
        <!--<xsl:variable name="matchexpr" select="$h5help.conreftarget.rule"/>-->
        <xsl:if test="not(matches($conrefval,$h5help.conreftarget.rule))">
            <xsl:call-template name="output-message">
                <xsl:with-param name="msgnum">098</xsl:with-param>
                <xsl:with-param name="msgsev">W</xsl:with-param>
                <xsl:with-param name="msgparams">%1=<xsl:value-of select="$conrefval"/>;%2=<xsl:value-of select="$h5help.conreftarget.rule"/></xsl:with-param>
                
            </xsl:call-template>
            </xsl:if>
    </xsl:template>
    
    
</xsl:stylesheet>