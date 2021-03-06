<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    
    <xsl:output omit-xml-declaration="no" encoding="UTF-8" method="xml" 
        doctype-public="-//OASIS//DTD DITA Concept//EN" 
        doctype-system="concept.dtd" indent="yes"/>
    
    <xsl:template match="rss">
        <concept id="jira_issues">
            <title>
                <xsl:value-of select="concat('JIRA Issues - ',channel/title/text())"/>
            </title>
            <conbody>
                <section>
                    <simpletable relcolwidth="80* 20*">
                        <sthead>
                            <stentry>Issue Summary</stentry>
                            <stentry>Issue Numbers</stentry>
                        </sthead>
                        <xsl:apply-templates select="//item"/>
                    </simpletable>
                </section>
            </conbody>
        </concept>
    </xsl:template>
    
    <xsl:template match="item">
        <strow audience="internal"><!-- Default to internal. Change manually when editing release notes. -->
            <stentry>
                <required-cleanup><xsl:value-of select="summary"/></required-cleanup>
            </stentry>
            <stentry>
                <ph audience="lms_admin instructor student"><xsl:value-of select="key"/></ph>
                <xref format="html" scope="external" audience="internal">
                    <xsl:attribute name="href">
                        <xsl:value-of select="link"/>
                    </xsl:attribute>
                    <xsl:value-of select="key"/>
                </xref>
            </stentry>
        </strow>
    </xsl:template>
    
</xsl:stylesheet>