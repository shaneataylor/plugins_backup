<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:exsl="http://exslt.org/common"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:exslf="http://exslt.org/functions"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    extension-element-prefixes="exsl"
    exclude-result-prefixes="opentopic exslf opentopic-func"
    version='1.1'>

    <!-- SET A VARIABLE FOR THE BOOK TITLE -->
    <xsl:variable name="booktitle">
        <xsl:value-of select="normalize-space(//*[contains(@class,' topic/title ')][1])"/>
    </xsl:variable>
    

    <!-- SET A VARIABLE FOR THE BOOK AUTHOR -->
    <xsl:variable name="bookauthor">
        <xsl:value-of select="normalize-space(//*[contains(@class,' topic/author ')][1])"/>
        <!-- 
        <xsl:value-of select="//*[contains(@class,' xnal-d/authorinformation ')]//*[contains(@class,' xnal-d/namedetails ')][1]"/>
         -->
    </xsl:variable>


    <!-- SET THE COPYRIGHT DATE -->
    <xsl:variable name="copyrightdate">
        <xsl:choose>
            <xsl:when test="//*[contains(@class,' bookmap/copyrlast ')]">
                <xsl:value-of select="//*[contains(@class,' bookmap/copyrlast ')][1]"/>
                <xsl:message>Using copyright date from bookmap.</xsl:message>
            </xsl:when>
            <xsl:when test="//*[contains(@class,' topic/copyryear ')][1]/@year">
                <xsl:value-of select="//*[contains(@class,' topic/copyryear ')][1]/@year"/>
                <xsl:message>Using copyright date from topic.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>2011</xsl:text>
                <xsl:message>No copyright date specified, defaulting to 2011.</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <!-- SET THE COPYRIGHT HOLDER -->
        <xsl:variable name="copyrightholder">
            <xsl:choose>
                <xsl:when test="//*[contains(@class,' bookmap/bookowner ')]">
                    <xsl:value-of select="//*[contains(@class,' bookmap/bookowner ')][1]"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="//*[contains(@class,' topic/copyrholder ')][1]"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
    
    <!-- SET THE BOOK RESTRICTION -->
    <xsl:variable name="bookrestriction">
        <xsl:value-of select="//*[contains(@class,' bookmap/bookrestriction ')][1]/@value"/>
    </xsl:variable>
    
    <!-- COMBINE THEM FOR COPYRIGHT STATEMENT -->
    <xsl:variable name="copyrightstatement">
        <xsl:text>&#169; </xsl:text><xsl:value-of select="$copyrightdate"/>
        <xsl:text> by </xsl:text><xsl:value-of select="$copyrightholder"/>
        <xsl:text> </xsl:text><xsl:value-of select="$bookrestriction"/>
    </xsl:variable>
    

    <!-- SET THE REV DATE -->
    <xsl:variable name="revision_raw">
        <xsl:choose>
            <xsl:when test="//*[contains(@class,' topic/revised ')][last()]/@modified">
                <!-- get last revised element, should be specified as yyyy-mm-dd -->
                <xsl:value-of select="//*[contains(@class,' topic/revised ')][last()]/@modified"/>
                <xsl:message>Revision date specified as <xsl:value-of select="//*[contains(@class,' topic/revised ')][last()]/@modified"/> (correct format is yyyy-mm-dd).</xsl:message>
            </xsl:when>
            <xsl:otherwise>
                <!-- Assume current date -->
                <xsl:value-of select="current-date()"/>
                <xsl:message>No revision date specified, defaulting to current date.</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="revision_yyyy">
        <xsl:value-of select="substring($revision_raw,1,4)"/>
    </xsl:variable>
    
    <xsl:variable name="revision_m">
        <xsl:value-of select="string(number(substring($revision_raw,6,2)))"/>
    </xsl:variable>
    
    <xsl:variable name="revision_mmm">
        <xsl:choose>
            <xsl:when test="$revision_m='1'">January</xsl:when>
            <xsl:when test="$revision_m='2'">February</xsl:when>
            <xsl:when test="$revision_m='3'">March</xsl:when>
            <xsl:when test="$revision_m='4'">April</xsl:when>
            <xsl:when test="$revision_m='5'">May</xsl:when>
            <xsl:when test="$revision_m='6'">June</xsl:when>
            <xsl:when test="$revision_m='7'">July</xsl:when>
            <xsl:when test="$revision_m='8'">August</xsl:when>
            <xsl:when test="$revision_m='9'">September</xsl:when>
            <xsl:when test="$revision_m='10'">October</xsl:when>
            <xsl:when test="$revision_m='11'">November</xsl:when>
            <xsl:when test="$revision_m='12'">December</xsl:when>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="revision_d">
        <xsl:value-of select="string(number(substring($revision_raw,9,2)))"/>
    </xsl:variable>
    
    <xsl:variable name="revision_m.d.yyyy">
        <xsl:value-of select="$revision_m"/><xsl:text>.</xsl:text>
        <xsl:value-of select="$revision_d"/><xsl:text>.</xsl:text>
        <xsl:value-of select="$revision_yyyy"/>
    </xsl:variable>

    <xsl:variable name="revisiondate">
        <xsl:value-of select="$revision_mmm"/><xsl:text> </xsl:text><xsl:value-of select="$revision_yyyy"/>
        <xsl:message>Revision date is: <xsl:value-of select="$revision_m.d.yyyy"/></xsl:message>
    </xsl:variable>
    
    
    
</xsl:stylesheet>