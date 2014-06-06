<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://example.com/namespace"
    xmlns:porter2="http://example.com/namespace"
    exclude-result-prefixes="xs fn porter2"
    version="2.0">
    
    <xsl:import href="porter2.xsl"/>
    <xsl:import href="plugin:org.dita.base:xsl/common/output-message.xsl"></xsl:import>
    <xsl:param name="msgprefix">DOTX</xsl:param>
    
    <xsl:param name="toc_file" />
    <xsl:param name="help_name" />
    <xsl:param name="search" />
    <xsl:param name="google_cse_id" />
    <xsl:param name="google_cse_refinement" />
    <xsl:param name="disqus_shortname" />
    <xsl:param name="feedback" />
    <xsl:param name="prettify_code" />
    
    <xsl:variable name="exceptionlist">
        <xsl:copy-of select="/searchconfig/exceptionalforms/exception"/>
    </xsl:variable>
    
    <xsl:output method="text" encoding="UTF-8" indent="no"/>
    
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="/" xml:space="preserve"><xsl:text>{</xsl:text>
<xsl:text>"toc_file":"</xsl:text><xsl:value-of select="$toc_file"/><xsl:text>",</xsl:text>
<xsl:text>"help_name":"</xsl:text><xsl:value-of select="$help_name"/><xsl:text>",</xsl:text>
<xsl:text>"search":"</xsl:text><xsl:value-of select="$search"/><xsl:text>",</xsl:text>
<xsl:text>"google_cse_id":"</xsl:text><xsl:value-of select="$google_cse_id"/><xsl:text>",</xsl:text>
<xsl:text>"google_cse_refinement":"</xsl:text><xsl:value-of select="$google_cse_refinement"/><xsl:text>",</xsl:text>
<xsl:text>"disqus_shortname":"</xsl:text><xsl:value-of select="$disqus_shortname"/><xsl:text>",</xsl:text>
<xsl:text>"feedback":"</xsl:text><xsl:value-of select="$feedback"/><xsl:text>",</xsl:text>
<xsl:text>"prettify_code":"</xsl:text><xsl:value-of select="$prettify_code"/><xsl:text>",</xsl:text>
<xsl:apply-templates select="searchconfig"/>
<xsl:text>}</xsl:text>
    </xsl:template>
    
    <xsl:template match="searchconfig">
        <xsl:text>&#10;"searchconfig":{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>
    
    <xsl:template match="stopwords">
        <xsl:text>&#10;"stopwords":"stopwords are not indexed"</xsl:text>
        <xsl:if test="count(following-sibling::*)>0"><xsl:text>,</xsl:text></xsl:if>
    </xsl:template>
    
    <xsl:template match="exceptionalforms">
        <xsl:text>&#10;"exceptionalforms":[</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>]</xsl:text>
        <xsl:if test="count(following-sibling::*)>0"><xsl:text>,</xsl:text></xsl:if>
    </xsl:template>
    
    <xsl:template match="exception">
        <xsl:text>&#10;{"</xsl:text>
        <xsl:value-of select="./@word"/>
        <xsl:text>":"</xsl:text>
        <xsl:value-of select="./@stem"/>
        <xsl:text>"}</xsl:text>
        <xsl:if test="count(following-sibling::*)>0"><xsl:text>,</xsl:text></xsl:if>
    </xsl:template>
    
    <xsl:template match="synonyms">
        <xsl:variable name="stemmedSyns">
            <xsl:apply-templates select="synonym" mode="stemIt"/>
        </xsl:variable>
        <xsl:variable name="mergedSyns">
            <xsl:for-each-group select="$stemmedSyns/synonym" group-by="@term">
                <synonym>
                    <xsl:attribute name="term" select="current-grouping-key()"/>
                    <xsl:for-each-group select="current-group()/variant" group-by="text()">
                        <variant><xsl:value-of select="current-grouping-key()"/></variant>
                    </xsl:for-each-group>
                </synonym>
            </xsl:for-each-group>
        </xsl:variable>
        
        <xsl:text>&#10;"synonyms":{</xsl:text>
        <!-- 
        "anim":["beast","brute","creatur","fauna"],
        -->
        <xsl:apply-templates select="$mergedSyns/synonym" mode="toJSON"/>
        <xsl:text>}</xsl:text>
        <xsl:if test="count(following-sibling::*)>0"><xsl:text>,</xsl:text></xsl:if>
    </xsl:template>
    
    <xsl:template match="synonym" mode="stemIt">
        <xsl:variable name="stemmedTerm">
            <xsl:call-template name="stemTerm">
                <xsl:with-param name="words" select="@term"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="stemmedVariants">
            <xsl:call-template name="stemVariants">
                <xsl:with-param name="words" select="variant"/>
            </xsl:call-template>
        </xsl:variable>
        <synonym>
            <xsl:attribute name="term" select="$stemmedTerm"/>
            <xsl:for-each select="distinct-values($stemmedVariants/variant)">
                <variant><xsl:value-of select="." /></variant>
            </xsl:for-each>
        </synonym>
    </xsl:template>
    
    <xsl:template match="synonym" mode="toJSON">
        <xsl:value-of select="concat('&#10;&quot;',./@term,'&quot;:[')"/>
        <xsl:apply-templates select="variant" mode="toJSON"/>
        <xsl:text>]</xsl:text>
        <xsl:if test="count(following-sibling::*)>0"><xsl:text>,</xsl:text></xsl:if>
    </xsl:template>
    
    <xsl:template match="variant" mode="toJSON">
        <xsl:value-of select="concat('&quot;',.,'&quot;')"/>
        <xsl:if test="count(following-sibling::*)>0"><xsl:text>,</xsl:text></xsl:if>
    </xsl:template>
    
    <xsl:template name="stemTerm">
        <xsl:param name="words"/>
        <xsl:param name="wordlist">
            <xsl:for-each select="tokenize(normalize-space($words),'\s+')">
                <word><xsl:value-of select="porter2:stem(.,$exceptionlist)"/></word>
            </xsl:for-each>
        </xsl:param>
        <xsl:for-each select="distinct-values($wordlist/word/text())">
            <xsl:value-of select="." />
            <xsl:if test="last()>position()"><xsl:text>_</xsl:text></xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="stemVariants">
        <xsl:param name="words"/>
        <xsl:for-each select="$words">
            <variant><xsl:value-of select="porter2:stem(.,$exceptionlist)"/></variant>
        </xsl:for-each>
    </xsl:template>
    
    
</xsl:stylesheet>