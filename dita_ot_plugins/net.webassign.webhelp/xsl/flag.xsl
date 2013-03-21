<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:import href="plugin:org.dita.base:xsl/common/output-message.xsl"/>
    <xsl:output method="xml" encoding="utf-8" indent="no"/>
    
    <!-- 
    FOR NOW: Implement desired flagging behaviors manually in CSS file using the generated classes
    FUTURE: Plugin will create CSS file based on flagging behaviors specified in ditaval file
    
    -->

    <xsl:param name="TRANSTYPE"/>

    <xsl:template match="*[@audience|@otherprops|@platform|@product|@rev]">
        <xsl:choose>
            <xsl:when test="$TRANSTYPE = 'h5help'">
                <xsl:variable name="elename"><xsl:value-of select="local-name()"/></xsl:variable>
                <xsl:variable name="classvalue"><xsl:value-of select="@outputclass"/></xsl:variable>
                <xsl:variable name="audience-classval">
                    <xsl:if test="@audience">
                        <xsl:value-of select="replace(concat(' ',normalize-space(@audience)),' ',' audience-')"/>
                    </xsl:if>
                </xsl:variable>
                <xsl:variable name="otherprops-classval">
                    <xsl:if test="@otherprops">
                        <xsl:value-of select="replace(concat(' ',normalize-space(@otherprops)),' ',' otherprops-')"/>
                    </xsl:if>
                </xsl:variable>
                <xsl:variable name="platform-classval">
                    <xsl:if test="@platform">
                        <xsl:value-of select="replace(concat(' ',normalize-space(@platform)),' ',' platform-')"/>
                    </xsl:if>
                </xsl:variable>
                <xsl:variable name="product-classval">
                    <xsl:if test="@product">
                        <xsl:value-of select="replace(concat(' ',normalize-space(@product)),' ',' product-')"/>
                    </xsl:if>
                </xsl:variable>
                <xsl:variable name="rev-classval">
                    <xsl:if test="@rev">
                        <xsl:value-of select="replace(concat(' ',normalize-space(@rev)),' ',' rev-')"/>
                    </xsl:if>
                </xsl:variable>
                <xsl:element name="{$elename}">
                    <xsl:attribute name="outputclass">
                        <xsl:value-of select="concat($classvalue,$audience-classval,$otherprops-classval,$platform-classval,$product-classval,$rev-classval)"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="@*[name()!='outputclass']|node()" mode="copykids"/>
                </xsl:element>
                
            </xsl:when>
            <xsl:otherwise><!-- all other transformations -->
                <xsl:apply-templates/> <!-- apply default templates (untested; not needed initially) -->
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="node()|@*[name()!='outputclass']" mode="copykids">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    

</xsl:stylesheet>
