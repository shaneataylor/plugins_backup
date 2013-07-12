<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    
    
    <!-- Add empty breadcrumbs div to top of topic if flag is set  -->
    <!-- Help system will generate breadcrumb content from currently loaded TOC. -->
    <xsl:template name="generateBreadcrumbs">
        <xsl:if test="$BREADCRUMBS='yes'">
            <div id="topic-breadcrumbs"></div>
        </xsl:if>
    </xsl:template>
    
    <!-- Generate links to CSS files -->
    <!-- REVISED to fix problem with CSS linking when using @copy-to.
         This fix might not address every situation for the OT, but fixes the problem for us. -->
    
    <xsl:template name="generateCssLinks">
        <xsl:variable name="childlang">
            <xsl:choose>
                <!-- Update with DITA 1.2: /dita can have xml:lang -->
                <xsl:when test="self::dita[not(@xml:lang)]">
                    <xsl:for-each select="*[1]"><xsl:call-template name="getLowerCaseLang"/></xsl:for-each>
                </xsl:when>
                <xsl:otherwise><xsl:call-template name="getLowerCaseLang"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="direction">
            <xsl:apply-templates select="." mode="get-render-direction">
                <xsl:with-param name="lang" select="$childlang"/>
            </xsl:apply-templates>
        </xsl:variable>
        <xsl:variable name="urltest"> <!-- test for URL -->
            <xsl:call-template name="url-string">
                <xsl:with-param name="urltext">
                    <xsl:value-of select="concat($CSSPATH, $CSS)"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="($direction = 'rtl') and ($urltest = 'url') ">
                <link rel="stylesheet" type="text/css" href="{$CSSPATH}{$bidi-dita-css}" />
            </xsl:when>
            <xsl:when test="($direction = 'rtl') and ($urltest = '')">
                <link rel="stylesheet" type="text/css" href="{$PATH2PROJ}{$CSSPATH}{$bidi-dita-css}" />
            </xsl:when>
            <xsl:when test="($urltest = 'url')">
                <link rel="stylesheet" type="text/css" href="{$CSSPATH}{$dita-css}" />
            </xsl:when>
            <xsl:otherwise>
                <link rel="stylesheet" type="text/css" href="{$CSSPATH}{$dita-css}" />
            </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="$newline"/>
        <!-- Add user's style sheet if requested to -->
        <xsl:if test="string-length($CSS) > 0">
            <xsl:choose>
                <xsl:when test="$urltest = 'url'">
                    <link rel="stylesheet" type="text/css" href="{$CSSPATH}{$CSS}" />
                </xsl:when>
                <xsl:otherwise>
                    <link rel="stylesheet" type="text/css" href="{$CSSPATH}{$CSS}" />
                </xsl:otherwise>
            </xsl:choose><xsl:value-of select="$newline"/>
        </xsl:if>
        
    </xsl:template>
    
</xsl:stylesheet>