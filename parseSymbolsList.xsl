<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http:webassign.com"
    exclude-result-prefixes="xs fn"
    version="2.0">
    
    <!-- 
    
    1. Download http://phantom.office.webassign.net/webtool/symbols.html
    2. "Clean up" the file (e.g., change <br> to <br/>)
    3. Parse the file with this XSL
    
    -->
    
    
    
    <xsl:output 
        doctype-public="-//OASIS//DTD DITA 1.1 Reference//EN"
        doctype-system="http://docs.oasis-open.org/dita/v1.1/OS/dtd/reference.dtd" 
        xml:space="preserve"/>
    
    <xsl:template match="/*" xml:space="preserve">
<reference id="symbols_symbollist" xml:lang="en-us">
    <title>Question Coding Symbols</title>
    <shortdesc>You can use these symbols in your questions or assignments. </shortdesc>
    <refbody>
        <simpletable>
            <xsl:apply-templates select="//tr[./td]"/>
        </simpletable>
    </refbody>
</reference>
    </xsl:template>
    
    <xsl:template match="tr[./td]" xml:space="preserve">
        <xsl:param name="symbolid" select="replace( td[1]/text(), '\s*&lt;s:(.*?)&gt;\s*', '$1')"/>
        <strow id="{$symbolid}">
            <xsl:apply-templates select="td[2]"/>
            <stentry>
                <codeph>&lt;s:<xsl:value-of select="$symbolid"/>&gt;</codeph>
            </stentry>
        </strow>
    </xsl:template>
    
    <xsl:template match="td[2]">
        <stentry>
            <xsl:apply-templates mode="symboldef"/>
        </stentry>
    </xsl:template>
    
    <xsl:template match="span" mode="symboldef">
        <ph>
            <xsl:apply-templates mode="symboldef"/>
        </ph>
    </xsl:template>
    
    <xsl:template match="strong" mode="symboldef">
        <b>
            <xsl:apply-templates mode="symboldef"/>
        </b>
    </xsl:template>
    
    <xsl:template match="text()" mode="symboldef">
        <xsl:choose>
            <xsl:when test="../@style and normalize-space(.) != ''">
                <xsl:call-template name="styledText">
                    <xsl:with-param name="text" select="normalize-space(.)"/>
                    <xsl:with-param name="style" select="../@style"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="img" mode="symboldef">
        <xsl:param name="src" select="@src"/>
        <xsl:param name="alt" select="@alt"/>
        <image href="{$src}"><alt><xsl:value-of select="$alt"></xsl:value-of></alt></image>
    </xsl:template>
    
    <xsl:template match="*" mode="symboldef">
        <xsl:param name="element" select="local-name(.)"/>
        <ph outputclass="{$element}">
            <xsl:apply-templates mode="symboldef"/>
        </ph>
    </xsl:template>
    
    <xsl:function name="fn:parsestyle">
        <xsl:param name="stylestring"/>
        <xsl:variable name="name" select="normalize-space(replace($stylestring,':[^:]+$',''))"/>
        <xsl:variable name="value" select="normalize-space(replace($stylestring,'^[^:]+:',''))"/>
        <xsl:choose>
            <xsl:when test="$name='font-family' and matches($value,'(Cambria|Georgia|[,\s]serif)')">
                <outputclass><xsl:text> Math </xsl:text></outputclass>
            </xsl:when>
            <xsl:when test="$name='font-style' and $value='italic'">
                <element>i</element>
            </xsl:when>
            <xsl:when test="$name='font-weight' and matches($value,'bold')">
                <element>b</element>
            </xsl:when>
            <xsl:when test="$name='text-decoration' and $value='overline'">
                <outputclass><xsl:text> overline </xsl:text></outputclass>
            </xsl:when>
            <xsl:when test="$name='font-variant' and $value='small-caps'">
                <outputclass><xsl:text> small-caps </xsl:text></outputclass>
            </xsl:when>
            <xsl:when test="$name='color'">
                <outputclass><xsl:value-of select="concat('color=',$value)"/></outputclass>
            </xsl:when>
            <xsl:when test="$name='font'">
                <xsl:if test="matches($value,'italic')">
                    <element>i</element>
                </xsl:if>
                <xsl:if test="matches($value,'bold')">
                    <element>b</element>
                </xsl:if>
                <xsl:if test="matches($value,'(Cambria|Georgia|[,\s]serif)')">
                    <outputclass><xsl:text> Math </xsl:text></outputclass>
                </xsl:if>
            </xsl:when>
            <!-- Ignore cases -->
            <xsl:when test="$name='font-style' and $value='normal'"/>
            <xsl:when test="$name='font-family' and matches($value,'(Trebuchet|Lucida|[,\s]sans-serif)')"/>
            <xsl:when test="$name='font-size'"/>
            <xsl:when test="$name='text-align'"/>
            <xsl:when test="$name='padding'"/>
            <xsl:when test="$name='cursor'"/>
            <xsl:when test="$name='position'"/>
            <xsl:when test="$name='left'"/>
            <xsl:when test="$name='right'"/>
            <xsl:when test="$name='width'"/>
            <xsl:when test="$name='display'"/>
            <xsl:when test="$name='white-space'"/>
            <xsl:when test="$name=''"/>
            <xsl:otherwise>
                <data>
                    <xsl:attribute name="name" select="$name"/>
                    <xsl:attribute name="value" select="$value"/>
                </data>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:template name="styledText">
        <xsl:param name="style"/>
        <xsl:param name="text"/>
        <xsl:param name="styles" select="distinct-values(tokenize($style,'[;]'))"/>
        <xsl:param name="parsedstyles">
            <xsl:for-each select="$styles">
                <xsl:copy-of select="fn:parsestyle(.)"/>
            </xsl:for-each>
        </xsl:param>
        <xsl:param name="outputclass">
            <xsl:value-of select="$parsedstyles/outputclass/text()"/>
        </xsl:param>
        <xsl:param name="elements">
            <xsl:copy-of select="$parsedstyles/element"/>
        </xsl:param>
        <xsl:param name="styledata" select="$parsedstyles/data"/>
        <xsl:if test="string-length(normalize-space($outputclass))>0">
            <xsl:attribute name="outputclass" select="normalize-space($outputclass)"/>
        </xsl:if>
        <xsl:copy-of select="$styledata"/>
        <xsl:choose>
            <xsl:when test="count($elements/element)=1">
                <xsl:element name="{$elements[1]/element/text()}">
                    <xsl:value-of select="$text"/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="count($elements/element)=2">
                <xsl:element name="{$elements/element[1]/text()}">
                    <xsl:element name="{$elements/element[2]/text()}">
                        <xsl:value-of select="$text"/>
                    </xsl:element>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$text"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
</xsl:stylesheet>