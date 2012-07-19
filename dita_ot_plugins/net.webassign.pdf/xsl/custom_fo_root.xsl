<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:exsl="http://exslt.org/common"
    xmlns:opentopic="http://www.idiominc.com/opentopic" xmlns:exslf="http://exslt.org/functions"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    extension-element-prefixes="exsl" exclude-result-prefixes="opentopic exslf opentopic-func"
    version="1.1">
    
    <xsl:attribute-set name="__fo__root__custom">
        <xsl:attribute name="font-family">Sans</xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
        <!--  <xsl:attribute name="rx:link-back">true</xsl:attribute> -->
    </xsl:attribute-set>    
    
    <xsl:template name="rootTemplate">
        <xsl:call-template name="validateTopicRefs"/>
        
        <!-- Don't use default attribute set, which adds rx:link-back attribute -->
        <fo:root xsl:use-attribute-sets="__fo__root__custom">
            
            <xsl:comment>
                <xsl:text>Layout masters = </xsl:text>
                <xsl:value-of select="$layout-masters"/>
            </xsl:comment>
            
            <xsl:call-template name="createLayoutMasters"/>
            
            <xsl:call-template name="createBookmarks"/>
            
            <xsl:call-template name="createFrontMatter"/>
            
            <xsl:call-template name="createToc"/>
            
            <!--            <xsl:call-template name="createPreface"/>-->
            
            <xsl:apply-templates/>
            
            <xsl:call-template name="createIndex"/>
            
        </fo:root>
    </xsl:template>
    

</xsl:stylesheet>
