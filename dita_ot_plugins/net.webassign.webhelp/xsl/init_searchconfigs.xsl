<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://example.com/namespace"
    xmlns:porter2="http://example.com/namespace"
    exclude-result-prefixes="xs fn porter2"
    version="2.0">
    
    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>
    
    <xsl:param name="configfile" />
    <xsl:param name="configfilefound" />
    
    <xsl:variable name="userconfigs">
        <xsl:choose>
            <xsl:when test="$configfilefound = 'true'">
                <xsl:copy-of select="document($configfile)"/>
            </xsl:when>
            <xsl:otherwise><searchconfig nodata="true"/></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="$userconfigs/searchconfig/@useDefaultConfigs='addToDefault'">
                <xsl:message select="concat('Combining user search config file (',$configfile,') with default search configuration.')"/>
                <searchconfig>
                    <stopwords>
                        <xsl:apply-templates mode="getstopwords" 
                            select="$userconfigs/searchconfig/stopwords/stopword | /searchconfig/stopwords/stopword"/>
                    </stopwords>
                    <exceptionalforms>
                        <xsl:copy-of select="$userconfigs/searchconfig/exceptionalforms/exception"/>
                        <xsl:copy-of select="/searchconfig/exceptionalforms/exception"/>
                    </exceptionalforms>
                    <synonyms>
                        <xsl:copy-of select="$userconfigs/searchconfig/synonyms/synonym"/>
                        <xsl:copy-of select="/searchconfig/synonyms/synonym"/>
                    </synonyms>
                </searchconfig>
            </xsl:when>
            <xsl:when test="$userconfigs/searchconfig/@useDefaultConfigs='replaceDefault'">
                <xsl:message select="concat('Using only user search config file (',$configfile,').')"/>
                <searchconfig>
                    <stopwords>
                        <xsl:apply-templates mode="getstopwords" 
                            select="$userconfigs/searchconfig/stopwords/stopword"/>
                    </stopwords>
                    <xsl:copy-of select="$userconfigs/searchconfig/exceptionalforms"/>
                    <xsl:copy-of select="$userconfigs/searchconfig/synonyms"/>
                </searchconfig>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message>Using only default search configuration file.</xsl:message>
                <searchconfig>
                    <stopwords>
                        <xsl:apply-templates mode="getstopwords" 
                            select="/searchconfig/stopwords/stopword"/>
                    </stopwords>
                    <xsl:copy-of select="/searchconfig/exceptionalforms"/>
                    <xsl:copy-of select="/searchconfig/synonyms"/>
                </searchconfig>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- === PARSE STOPWORDS === -->
    <xsl:template mode="getstopwords" match="stopword">
        <xsl:value-of select="."/>
        <xsl:if test="not(position()=last())">
            <xsl:text>|</xsl:text>
        </xsl:if>
    </xsl:template>
    
    
</xsl:stylesheet>