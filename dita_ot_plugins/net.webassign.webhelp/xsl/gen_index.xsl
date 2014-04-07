<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://example.com/namespace"
    exclude-result-prefixes="xs fn"
    version="2.0">
    
    <xsl:import href="plugin:org.dita.base:xsl/common/output-message.xsl"></xsl:import>
    <xsl:param name="msgprefix">DOTX</xsl:param>
    
    <xsl:param name="thisindextarget" />
    <xsl:param name="outext" />
    
    <xsl:param name="classmaps">
        <classmap ditaclass=" topic/body " element="body"/>
        <classmap ditaclass=" topic/abstract " element="abstracts"/>
        <!--<classmap ditaclass=" topic/related-links " element="links"/>-->
        <classmap ditaclass=" topic/shortdesc " element="shortdesc" first="true"/>
        <classmap ditaclass=" topic/keyword " element="keywords"/>
        <classmap ditaclass=" topic/indexterm " element="indexterms"/>
        <classmap ditaclass=" topic/title " element="titles"/>
        <classmap ditaclass=" topic/title " element="firsttitle" first="true" />
    </xsl:param>
    <xsl:param name="classmapcount" select="count($classmaps/classmap)"/>
    
    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes"/>
    
    <!-- 
        DESIRED XML STRUCTURE OF OUTPUT
        
        <topicindex>
            <stem value="assign" score="35" href="t_s_open_assignment.htm"/>
            <stem value="open" score="22" href="t_s_open_assignment.htm"/>
            ...
        </topicindex>
        
        Possibly also add @locations:
            - for each stem instance, get its position in the topic after stop words are removed
            - divide the position by a resolution (say, 10 words) and make an integer
            - combine all the positions for each stem in a topic, removing duplicates
            This attribute would help prioritize topics where multiple terms are near each other
            (within +/- 1 of another stem's @location)
    
    The repetitive hrefs will ease combining stem instances in the combined index
    
    -->
    
    <!-- === NODRAFT === -->
    
    <xsl:variable name="nodraft">
        <nodraft>
            <xsl:apply-templates select="/node()" mode="nodraft"/>
        </nodraft>
    </xsl:variable>
    
    <xsl:template match="*" mode="nodraft">
        <xsl:copy>
            <xsl:apply-templates select="node()|@class" mode="nodraft"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="text()" mode="nodraft">
        <!-- lowercase & strip out nonword characters -->
        <xsl:value-of select='replace(lower-case(.),"[^a-z&apos;]"," ")'/>
        <!-- will need to normalize spaces AFTER stripping out the tags we don't care about -->
    </xsl:template>
    
    <xsl:template match="@class" mode="nodraft">
        <xsl:copy></xsl:copy>
    </xsl:template>
    
    <!-- remove stuff -->
    <xsl:template match="*[contains(@class,' topic/related-links ')]" mode="nodraft"></xsl:template>
    <xsl:template match="*[contains(@class,' topic/draft-comment ')]" mode="nodraft"></xsl:template>
    <xsl:template match="*[contains(@class,' topic/required-cleanup ')]" mode="nodraft"></xsl:template>
    <xsl:template match="processing-instruction()" mode="nodraft"></xsl:template>
    <xsl:template match="comment()" mode="nodraft"></xsl:template>
    
    
    
    <!-- === PARSE CLASSMAPS === -->
    
    <xsl:variable name="parseclassmaps">
        <xsl:call-template name="loop_through_classmaps"/>
    </xsl:variable>
    
    <xsl:template name="loop_through_classmaps">
        <xsl:param name="classmapcounter" select="$classmapcount"/>
        <xsl:param name="thiselement" select="$classmaps/classmap[position()=$classmapcounter]/@element"/>
        <xsl:param name="thisclass" select="$classmaps/classmap[position()=$classmapcounter]/@ditaclass"/>
        <xsl:param name="thisfirst" select="$classmaps/classmap[position()=$classmapcounter]/@first or false()"/>
        <xsl:if test="not($classmapcounter = 0)">
            <xsl:choose>
                <xsl:when test="$thisfirst">
                    <xsl:apply-templates mode="getText" select="($nodraft//*[contains(@class,$thisclass)])[1]">
                        <xsl:with-param name="thiselement" select="$thiselement"/>
                    </xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates mode="getText" select="$nodraft//*[contains(@class,$thisclass)]">
                        <xsl:with-param name="thiselement" select="$thiselement"/>
                    </xsl:apply-templates>
                </xsl:otherwise>
            </xsl:choose>
            <!-- Oops! I did it again. -->
            <xsl:call-template name="loop_through_classmaps">
                <xsl:with-param name="classmapcounter">
                    <xsl:value-of select="$classmapcounter - 1"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <xsl:template mode="getText" match="*">
        <xsl:param name="thiselement"/>
        <xsl:element name="{$thiselement}">
            <xsl:apply-templates mode="getTextChildren" select="*|text()"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template mode="getTextChildren" match="*">
        <xsl:if test="count(ancestor-or-self::*[contains(@class,' topic/draft-comment ')]) + count(ancestor-or-self::*[contains(@class,' topic/required-cleanup ')]) = 0">
            <xsl:apply-templates mode="getTextChildren" select="*|text()"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template mode="getTextChildren" match="text()">
        <!-- escape JSON characters (won't be needed after stripping out all but [az']) -->
        <xsl:value-of select="replace(concat(replace(., '([&quot;\\])', '\\$1'),' '),'\s+',' ')"/>
    </xsl:template>
    
    
    
    
    
    
    
    
    <!-- === OUTPUT === -->
    
    <xsl:template match="/*"><!-- if nested topics, treat as one unit -->
        <!-- problems to figure out (maybe all handled with preprocessing?):
            * topics not in flat output file structure
            * copy-to 
             -->
        <!-- outer structure -->
        <topicindex>
            <xsl:copy-of select="$parseclassmaps"/>
        </topicindex>
    </xsl:template>
    
    
    <!-- === UNUSED === -->
    
    
    
</xsl:stylesheet>