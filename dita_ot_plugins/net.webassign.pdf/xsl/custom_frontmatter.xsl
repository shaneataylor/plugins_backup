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
    
    
    
    <!-- FRONTMATTER -->
    <xsl:template name="createFrontMatter_1.0">
        <fo:page-sequence master-reference="front-matter" xsl:use-attribute-sets="__force__page__count">
            <!--<xsl:call-template name="insertFrontMatterStaticContents"/>-->
            <fo:flow flow-name="xsl-region-body">
                <fo:block xsl:use-attribute-sets="__frontmatter">
                    <!-- set the title -->
                    <fo:block xsl:use-attribute-sets="__frontmatter__title">
                        <xsl:choose>
                            <xsl:when test="$map/*[contains(@class,' topic/title ')][1]">
                                <xsl:apply-templates select="$map/*[contains(@class,' topic/title ')][1]"/>
                            </xsl:when>
                            <xsl:when test="$map//*[contains(@class,' bookmap/mainbooktitle ')][1]">
                                <xsl:apply-templates select="$map//*[contains(@class,' bookmap/mainbooktitle ')][1]"/>
                            </xsl:when>
                            <xsl:when test="//*[contains(@class, ' map/map ')]/@title">
                                <xsl:value-of select="//*[contains(@class, ' map/map ')]/@title"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="/descendant::*[contains(@class, ' topic/topic ')][1]/*[contains(@class, ' topic/title ')]"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </fo:block>
                    
                    <!-- set the subtitle -->
                    <xsl:apply-templates select="$map//*[contains(@class,' bookmap/booktitlealt ')]"/>
                    
                    
                    <fo:block xsl:use-attribute-sets="__frontmatter__revdate">
                        <xsl:value-of select="$revisiondate"/>
                    </fo:block>
                    
                    <!-- DO NOT SHOW OWNER ON COVER -->
                    <!-- 
                    <fo:block xsl:use-attribute-sets="__frontmatter__owner">
                        <xsl:apply-templates select="$map//*[contains(@class,' bookmap/bookmeta ')]"/>
                    </fo:block>
                    -->
                </fo:block>
                
                <xsl:if test="$map/*[contains(@class,' topic/title ')][1]">
                    <!-- Don't add if it's just a topic -->
                    
                    <!-- Create 1/2 Title Page -->
                    <fo:block xsl:use-attribute-sets="__frontmatter__titlepage">
                        <xsl:apply-templates select="$map/*[contains(@class,' topic/title ')][1]"/>
                    </fo:block>
                    <!-- Create Title Page -->
                    <fo:block xsl:use-attribute-sets="__frontmatter__titlepage">
                        <xsl:apply-templates select="$map/*[contains(@class,' topic/title ')][1]"/>
                        <fo:block xsl:use-attribute-sets="__frontmatter__titlepage__revdate">
                            <xsl:value-of select="$revisiondate"/>
                        </fo:block>
                    </fo:block>
                </xsl:if>
                
                <xsl:call-template name="create_copyright_notice"></xsl:call-template>
                <!--<xsl:call-template name="createPreface"/>-->
            </fo:flow>
        </fo:page-sequence>
        <!--<xsl:call-template name="createNotices"/>-->
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' bookmap/bookmeta ')]">
        <fo:block-container xsl:use-attribute-sets="__frontmatter__owner__container">
            <fo:block >
                <xsl:apply-templates/>
            </fo:block>
        </fo:block-container>
    </xsl:template>
    
    
    
    
    <!-- ADD REVISION DATE TO COVER -->
    <xsl:template match="//*[contains(@class,' topic/revised ')][last()]/@modified" priority="+2">
        <fo:block xsl:use-attribute-sets="__frontmatter__revdate">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    
    
    
    <xsl:template match="*[contains(@class, ' bookmap/booktitlealt ')]" priority="+2">
        <fo:block xsl:use-attribute-sets="__frontmatter__subtitle">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' bookmap/booktitle ')]" priority="+2">
        <fo:block xsl:use-attribute-sets="__frontmatter__booklibrary">
            <xsl:apply-templates select="*[contains(@class, ' bookmap/booklibrary ')]"/>
        </fo:block>
        <fo:block xsl:use-attribute-sets="__frontmatter__mainbooktitle">
            <xsl:apply-templates select="*[contains(@class,' bookmap/mainbooktitle ')]"/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' xnal-d/namedetails ')]">
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' xnal-d/addressdetails ')]">
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' xnal-d/contactnumbers ')]">
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' bookmap/bookowner ')]">
        <fo:block xsl:use-attribute-sets="author">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' bookmap/summary ')]">
        <fo:block xsl:use-attribute-sets="bookmap.summary">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="createNotices">
        <xsl:apply-templates select="/bookmap/*[contains(@class,' topic/topic ')]" mode="process-notices"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/topic ')]" mode="process-notices">
        <xsl:param name="include" select="'true'"/>
        <xsl:variable name="topicType">
            <xsl:call-template name="determineTopicType"/>
        </xsl:variable>
        
        <xsl:if test="$topicType = 'topicNotices'">
            <xsl:comment>Processed with processTopicNotices template</xsl:comment>
            <xsl:call-template name="processTopicNotices"/>
        </xsl:if>
    </xsl:template>
    
    
    
</xsl:stylesheet>