<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:exsl="http://exslt.org/common"
    xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
    xmlns:opentopic="http://www.idiominc.com/opentopic" xmlns:exslf="http://exslt.org/functions"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    extension-element-prefixes="exsl" exclude-result-prefixes="opentopic exslf opentopic-func"
    version="1.1">
<!--
    <xsl:include href="custom_variables.xsl"/>
    <xsl:include href="custom_headers_footers.xsl"/>
    <xsl:include href="custom_layout_masters.xsl"/>
    <xsl:include href="custom_frontmatter.xsl"/>
    <xsl:include href="custom_toc.xsl"/>
    <xsl:include href="custom_copyright_notice.xsl"/>
    <xsl:include href="custom_tables.xsl"/>
-->
    <!-- HIDE AUTHOR ON COVER PAGE -->
    <xsl:template match="*[contains(@class, ' bookmap/bookowner ')]"> </xsl:template>


    <!--  Bookmap Chapter processing  -->
    <xsl:template name="processTopicChapter">
        <fo:page-sequence master-reference="body-sequence"
            xsl:use-attribute-sets="__force__page__count">
            <xsl:call-template name="startPageNumbering"/>
            <xsl:call-template name="insertBodyStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
                <fo:block xsl:use-attribute-sets="topic">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                    <xsl:if test="not(ancestor::*[contains(@class, ' topic/topic ')])">
                        <fo:marker marker-class-name="current-topic-number">
                            <xsl:number format="1"/>
                        </fo:marker>
                        <fo:marker marker-class-name="current-header">
                            <xsl:for-each select="child::*[contains(@class,' topic/title ')]">
                                <xsl:call-template name="getTitle"/>
                            </xsl:for-each>
                        </fo:marker>
                    </xsl:if>

                    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]"/>

                    <xsl:call-template name="insertChapterFirstpageStaticContent">
                        <xsl:with-param name="type" select="'chapter'"/>
                    </xsl:call-template>

                    <fo:block xsl:use-attribute-sets="topic.title">
                        <!-- added by William on 2009-07-02 for indexterm bug:2815485 start-->
                        <xsl:call-template name="pullPrologIndexTerms"/>
                        <!-- added by William on 2009-07-02 for indexterm bug:2815485 end-->

                        <xsl:for-each select="child::*[contains(@class,' topic/title ')]">
                            <xsl:call-template name="getTitle"/>
                        </xsl:for-each>
                    </fo:block>

                    <xsl:choose>
                        <!-- ADD TESTING FOR CHILDREN -->
                        <xsl:when
                            test="not($chapterLayout='BASIC') and .//*[(contains(@class,' topic/topic '))]">
							<!-- Commenting out deprecated named template createMiniToc here and elsewhere. 
							     By itself, this change does not fix build error. -->
                            <!--<xsl:call-template name="createMiniToc"/>-->
                            <xsl:apply-templates select="." mode="createMiniToc"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <fo:block>
                                <xsl:apply-templates
                                    select="*[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                                    contains(@class, ' topic/prolog '))]"/>
                                <xsl:call-template name="buildRelationships"/>
                            </fo:block>

                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:apply-templates select="*[contains(@class,' topic/topic ')]"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>

    <!--  Bookmap Appendix processing  -->
    <xsl:template name="processTopicAppendix">
        <fo:page-sequence master-reference="body-sequence"
            xsl:use-attribute-sets="__force__page__count">
            <xsl:call-template name="insertBodyStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
                <fo:block xsl:use-attribute-sets="topic">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                    <xsl:if test="not(ancestor::*[contains(@class, ' topic/topic ')])">
                        <fo:marker marker-class-name="current-topic-number">
                            <xsl:number format="1"/>
                        </fo:marker>
                        <fo:marker marker-class-name="current-header">
                            <xsl:for-each select="child::*[contains(@class,' topic/title ')]">
                                <xsl:call-template name="getTitle"/>
                            </xsl:for-each>
                        </fo:marker>
                    </xsl:if>

                    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]"/>

                    <xsl:call-template name="insertChapterFirstpageStaticContent">
                        <xsl:with-param name="type" select="'appendix'"/>
                    </xsl:call-template>

                    <fo:block xsl:use-attribute-sets="topic.title">
                        <!-- added by William on 2009-07-02 for indexterm bug:2815485 start-->
                        <xsl:call-template name="pullPrologIndexTerms"/>
                        <!-- added by William on 2009-07-02 for indexterm bug:2815485 end-->
                        <xsl:for-each select="child::*[contains(@class,' topic/title ')]">
                            <xsl:call-template name="getTitle"/>
                        </xsl:for-each>
                    </fo:block>
                    <xsl:choose>
                        <!-- ADD TESTING FOR CHILDREN -->
                        <xsl:when
                            test="not($appendixLayout='BASIC') and .//*[(contains(@class,' topic/topic '))]">
                            <!--<xsl:call-template name="createMiniToc"/>-->
                            <xsl:apply-templates select="." mode="createMiniToc"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <fo:block>
                                <xsl:apply-templates
                                    select="*[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                                    contains(@class, ' topic/prolog '))]"/>
                                <xsl:call-template name="buildRelationships"/>
                            </fo:block>

                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:apply-templates select="*[contains(@class,' topic/topic ')]"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>

    <!--  Bookmap Part processing  -->
    <xsl:template name="processTopicPart">
        <fo:page-sequence master-reference="body-sequence"
            xsl:use-attribute-sets="__force__page__count">
            <xsl:call-template name="startPageNumbering"/>
            <xsl:call-template name="insertBodyStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
                <fo:block xsl:use-attribute-sets="topic">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                    <xsl:if test="not(ancestor::*[contains(@class, ' topic/topic ')])">
                        <fo:marker marker-class-name="current-topic-number">
                            <xsl:number format="I"/>
                        </fo:marker>
                        <fo:marker marker-class-name="current-header">
                            <xsl:for-each select="child::*[contains(@class,' topic/title ')]">
                                <xsl:call-template name="getTitle"/>
                            </xsl:for-each>
                        </fo:marker>
                    </xsl:if>

                    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]"/>

                    <xsl:call-template name="insertChapterFirstpageStaticContent">
                        <xsl:with-param name="type" select="'part'"/>
                    </xsl:call-template>

                    <fo:block xsl:use-attribute-sets="topic.title">
                        <!-- added by William on 2009-07-02 for indexterm bug:2815485 start-->
                        <xsl:call-template name="pullPrologIndexTerms"/>
                        <!-- added by William on 2009-07-02 for indexterm bug:2815485 end-->
                        <xsl:for-each select="child::*[contains(@class,' topic/title ')]">
                            <xsl:call-template name="getTitle"/>
                        </xsl:for-each>
                    </fo:block>
                    <xsl:choose>
                        <!-- ADD TESTING FOR CHILDREN -->
                        <xsl:when
                            test="not($partLayout='BASIC') and .//*[(contains(@class,' topic/topic '))]">
                            <!--<xsl:call-template name="createMiniToc"/>-->
                            <xsl:apply-templates select="." mode="createMiniToc"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <fo:block>
                                <xsl:apply-templates
                                    select="*[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                                    contains(@class, ' topic/prolog '))]"/>
                                <xsl:call-template name="buildRelationships"/>
                            </fo:block>

                        </xsl:otherwise>
                    </xsl:choose>


                    <xsl:for-each select="*[contains(@class,' topic/topic ')]">
                        <xsl:variable name="topicType">
                            <xsl:call-template name="determineTopicType"/>
                        </xsl:variable>
                        <xsl:if test="$topicType = 'topicSimple'">
                            <xsl:apply-templates select="."/>
                        </xsl:if>
                    </xsl:for-each>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
        <xsl:for-each select="*[contains(@class,' topic/topic ')]">
            <xsl:variable name="topicType">
                <xsl:call-template name="determineTopicType"/>
            </xsl:variable>
            <xsl:if test="not($topicType = 'topicSimple')">
                <xsl:apply-templates select="."/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>


    <!-- Notices -->
    <xsl:template name="processTopicNotices">
        <fo:page-sequence master-reference="notices-sequence"
            xsl:use-attribute-sets="__force__page__count">
            <xsl:attribute name="format"> </xsl:attribute>
            <xsl:attribute name="break-before">odd-page</xsl:attribute>
            <fo:flow flow-name="xsl-region-body">
                <fo:block span="all">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                    
                    <fo:block xsl:use-attribute-sets="__notices.title">
                        
                        <xsl:call-template name="pullPrologIndexTerms"/>
                        <xsl:for-each select="child::*[contains(@class,' topic/title ')]">
                            <xsl:call-template name="getTitle"/>
                        </xsl:for-each>
                    </fo:block>

                    <xsl:apply-templates select="*[contains(@class,' topic/titlealts ')]"/>
                    
                </fo:block>
                <fo:block xsl:use-attribute-sets="__notices.body">
                    <xsl:if
                        test="*[contains(@class,' topic/shortdesc ')
                                or contains(@class, ' topic/abstract ')]/node()">
                        <fo:block xsl:use-attribute-sets="p">
                            <xsl:apply-templates
                                select="*[contains(@class,' topic/shortdesc ')
                                        or contains(@class, ' topic/abstract ')]/node()"
                            />
                        </fo:block>
                    </xsl:if>
                    <xsl:apply-templates select="*[contains(@class,' topic/body ')]/*">
                    </xsl:apply-templates>

                    <xsl:if
                        test="*[contains(@class,' topic/related-links ')]//
                                *[contains(@class,' topic/link ')][not(@role) or @role!='child']">
                        <xsl:apply-templates select="*[contains(@class,' topic/related-links ')]">
                            <xsl:with-param name="in_minitoc" select="true()"/>
                        </xsl:apply-templates>
                    </xsl:if>

                </fo:block>
                <fo:block span="all"></fo:block>
            </fo:flow>
        </fo:page-sequence>
        </xsl:template>
    
    
    <xsl:template match="*[contains(@class,' topic/section ')]">
        <fo:block xsl:use-attribute-sets="section">
            <xsl:if test="ancestor-or-self::*[contains(@outputclass, 'fineprint')]">
                <xsl:attribute name="font-size">6pt</xsl:attribute>
                <xsl:attribute name="line-height">99.9%</xsl:attribute>
            </xsl:if>
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates select="." mode="dita2xslfo:section-heading"/>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    
    
    
    <xsl:template match="*[contains(@class,' topic/section ')]/*[contains(@class,' topic/title ')]">
        <fo:block xsl:use-attribute-sets="section.title" id="{@id}">
            <xsl:if test="ancestor-or-self::*[contains(@class, ' bookmap/notices ')]">
                <xsl:attribute name="start-indent">0em</xsl:attribute>
            </xsl:if>
            <xsl:if test="ancestor-or-self::*[contains(@outputclass, 'fineprint')]">
                <xsl:attribute name="font-size">6pt</xsl:attribute>
                <xsl:attribute name="margin-top">0em</xsl:attribute>
                <xsl:attribute name="margin-bottom">0em</xsl:attribute>
                
                <xsl:attribute name="padding-top">0em</xsl:attribute>
            </xsl:if>
            <xsl:call-template name="getTitle"/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' topic/example ')]/*[contains(@class,' topic/title ')]">
        <fo:block xsl:use-attribute-sets="example.title" id="{@id}">
            <xsl:if test="ancestor-or-self::*[contains(@class, ' bookmap/notices ')]">
                <xsl:attribute name="start-indent">0em</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    



    <!-- Changed so topicrefs in frontmatter use lowercase roman numbering -->
    <xsl:template match="*[contains(@class, ' topic/topic ')]">
        <xsl:variable name="topicType">
            <xsl:call-template name="determineTopicType"/>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$topicType = 'topicChapter'">
                <xsl:call-template name="processTopicChapter"/>
            </xsl:when>
            <xsl:when test="$topicType = 'topicAppendix'">
                <xsl:call-template name="processTopicAppendix"/>
            </xsl:when>
            <xsl:when test="$topicType = 'topicPart'">
                <xsl:call-template name="processTopicPart"/>
            </xsl:when>
            <xsl:when test="$topicType = 'topicPreface'">
                <xsl:call-template name="processTopicPreface"/>
            </xsl:when>
            <xsl:when test="$topicType = 'topicNotices'">
                <!-- By default, OT suppresses this here and puts it at the beginning of the book.
                     Un-commenting adds notice where it belongs but does not suppress it at beginning of book. -->
                <xsl:call-template name="processTopicNotices"/>
            </xsl:when>
            <xsl:when test="$topicType = 'topicSimple'">
                <xsl:variable name="page-sequence-reference">
                    <xsl:choose>
                        <xsl:when test="$mapType = 'bookmap'">
                            <xsl:value-of select="'body-sequence'"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'ditamap-body-sequence'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="not(ancestor::*[contains(@class,' topic/topic ')])">
                        <fo:page-sequence master-reference="{$page-sequence-reference}"
                            xsl:use-attribute-sets="__force__page__count">

                            <!-- Since topic is not part of a chapter, part, or appendix, use lowercase Roman -->
                            <xsl:attribute name="format">i</xsl:attribute>

                            <xsl:call-template name="insertBodyStaticContents"/>
                            <fo:flow flow-name="xsl-region-body">

                                <!-- Add red block -->
                                <fo:block-container
                                    xsl:use-attribute-sets="__chapter__frontmatter__number__container">
                                    <fo:block> </fo:block>
                                </fo:block-container>

                                <xsl:choose>
                                    <xsl:when test="contains(@class,' concept/concept ')">
                                        <xsl:call-template name="processConcept"/>
                                    </xsl:when>
                                    <xsl:when test="contains(@class,' task/task ')">
                                        <xsl:call-template name="processTask"/>
                                    </xsl:when>
                                    <xsl:when test="contains(@class,' reference/reference ')">
                                        <xsl:call-template name="processReference"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="processTopic"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </fo:flow>
                        </fo:page-sequence>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="contains(@class,' concept/concept ')">
                                <xsl:call-template name="processConcept"/>
                            </xsl:when>
                            <xsl:when test="contains(@class,' task/task ')">
                                <xsl:call-template name="processTask"/>
                            </xsl:when>
                            <xsl:when test="contains(@class,' reference/reference ')">
                                <xsl:call-template name="processReference"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:call-template name="processTopic"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <!--BS: skipp abstract (copyright) from usual content. It will be processed from the front-matter-->
            <xsl:when test="$topicType = 'topicAbstract'"/>
            <xsl:otherwise>
                <xsl:call-template name="processUnknowTopic">
                    <xsl:with-param name="topicType" select="$topicType"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Create chapter-level TOC. Modified because related links incorrectly indented -->
    <!--<xsl:template name="createMiniToc">
        <xsl:apply-templates select="." mode="createMiniToc"/>
    </xsl:template>-->
    <xsl:template match="*" mode="createMiniToc">
        <fo:table xsl:use-attribute-sets="__toc__mini__table">
            <fo:table-column xsl:use-attribute-sets="__toc__mini__table__column_1"/>
            <fo:table-column xsl:use-attribute-sets="__toc__mini__table__column_2"/>
            <fo:table-body xsl:use-attribute-sets="__toc__mini__table__body">
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block xsl:use-attribute-sets="__toc__mini">
                            <xsl:if test="*[contains(@class, ' topic/topic ')]">
                                <fo:block xsl:use-attribute-sets="__toc__mini__header">
                                    <xsl:call-template name="insertVariable">
                                        <xsl:with-param name="theVariableID" select="'Mini Toc'"/>
                                    </xsl:call-template>
                                </fo:block>
                                <fo:list-block xsl:use-attribute-sets="__toc__mini__list">
                                    <xsl:apply-templates
                                        select="*[contains(@class, ' topic/topic ')]"
                                        mode="in-this-chapter-list"/>
                                </fo:list-block>
                            </xsl:if>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell xsl:use-attribute-sets="__toc__mini__summary">
                        <!--Really, it would be better to just apply-templates, but the attribute sets for shortdesc, body
                            and abstract might indent the text.  Here, the topic body is in a table cell, and should
                            not be indented, so each element is handled specially.-->
                        <fo:block>
                            <xsl:apply-templates select="*[contains(@class,' topic/titlealts ')]"/>
                            <xsl:if
                                test="*[contains(@class,' topic/shortdesc ')
                                or contains(@class, ' topic/abstract ')]/node()">
                                <fo:block xsl:use-attribute-sets="p">
                                    <xsl:apply-templates
                                        select="*[contains(@class,' topic/shortdesc ')
                                        or contains(@class, ' topic/abstract ')]/node()"
                                    />
                                </fo:block>
                            </xsl:if>
                            <xsl:apply-templates select="*[contains(@class,' topic/body ')]/*"/>

                            <!-- Added with RFE 2976463 to fix dropped links in topics with a mini-TOC. -->
                            <xsl:if
                                test="*[contains(@class,' topic/related-links ')]//
                                *[contains(@class,' topic/link ')][not(@role) or @role!='child']">
                                <xsl:apply-templates
                                    select="*[contains(@class,' topic/related-links ')]">
                                    <xsl:with-param name="in_minitoc" select="true()"/>
                                    <!-- Use this parameter to turn off indentation of related links in mini TOC -->
                                </xsl:apply-templates>
                            </xsl:if>

                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>


    <xsl:template match="*[contains(@class,' topic/related-links ')]">
        <xsl:param name="in_minitoc"/>
        <!-- parameter is true if in chapter mini TOC -->
        <xsl:if test="$disableRelatedLinks = 'no' or
            $includeRelatedLinks!='none'">
            <xsl:variable name="topicType">
                <xsl:for-each select="parent::*">
                    <xsl:call-template name="determineTopicType"/>
                </xsl:for-each>
            </xsl:variable>

            <xsl:variable name="collectedLinks">
                <xsl:apply-templates>
                    <xsl:with-param name="topicType" select="$topicType"/>
                </xsl:apply-templates>
            </xsl:variable>

            <xsl:variable name="linkTextContent">
                <xsl:value-of select="$collectedLinks"/>
            </xsl:variable>

            <xsl:if test="normalize-space($linkTextContent)!=''">
                <fo:block xsl:use-attribute-sets="related-links">

                    <xsl:choose>

                        <xsl:when test="$in_minitoc">
                            <!-- No indent if in minitoc -->
                            <xsl:comment>IN MINITOC</xsl:comment>

                            <fo:block xsl:use-attribute-sets="related-links.title">
                                <xsl:attribute name="start-indent">0in</xsl:attribute>
                                <xsl:call-template name="insertVariable">
                                    <xsl:with-param name="theVariableID" select="'Related Links'"/>
                                </xsl:call-template>
                            </fo:block>

                            <fo:block xsl:use-attribute-sets="related-links__content">
                                <xsl:attribute name="start-indent">0in</xsl:attribute>
                                <xsl:copy-of select="$collectedLinks"/>
                            </fo:block>
                        </xsl:when>

                        <xsl:otherwise>
                            <fo:block xsl:use-attribute-sets="related-links.title">
                                <xsl:call-template name="insertVariable">
                                    <xsl:with-param name="theVariableID" select="'Related Links'"/>
                                </xsl:call-template>
                            </fo:block>

                            <fo:block xsl:use-attribute-sets="related-links__content">
                                <xsl:copy-of select="$collectedLinks"/>
                            </fo:block>
                        </xsl:otherwise>

                    </xsl:choose>

                </fo:block>
            </xsl:if>

        </xsl:if>
    </xsl:template>





    <!-- Resolve error with single step -->
    <xsl:template match="*[contains(@class, ' task/steps ')]/*[contains(@class, ' task/step ')]">
        <!-- Switch to variable for the count rather than xsl:number, so that step specializations are also counted -->
        <xsl:variable name="actual-step-count"
            select="number(count(preceding-sibling::*[contains(@class, ' task/step ')])+1)"/>
        <fo:list-item xsl:use-attribute-sets="steps.step">
            <fo:list-item-label xsl:use-attribute-sets="steps.step__label">
                <xsl:choose>
                    <xsl:when
                        test="preceding-sibling::*[contains(@class, ' task/step ')] | following-sibling::*[contains(@class, ' task/step ')]">
                        <fo:block xsl:use-attribute-sets="steps.step__label__content">
                            <fo:inline id="{@id}"/>
                            <xsl:call-template name="insertVariable">
                                <xsl:with-param name="theVariableID" select="'Ordered List Number'"/>
                                <xsl:with-param name="theParameters">
                                    <number>
                                        <xsl:value-of select="$actual-step-count"/>
                                    </number>
                                </xsl:with-param>
                            </xsl:call-template>
                        </fo:block>
                    </xsl:when>
                    <xsl:otherwise>
                        <fo:block><!-- insert block to avoid warning --></fo:block>
                    </xsl:otherwise>
                </xsl:choose>
            </fo:list-item-label>

            <fo:list-item-body xsl:use-attribute-sets="steps.step__body">
                <fo:block xsl:use-attribute-sets="steps.step__content">
                    <xsl:apply-templates/>
                </fo:block>
            </fo:list-item-body>

        </fo:list-item>
    </xsl:template>


    <!-- ONLY SHOW USER-SPECIFIED SHORT DESCRIPTIONS FOR RELATED LINKS -->
    <!-- Avoid using; processing in another template causes the actual link text to pick up the specified short description. -->
    <xsl:template name="insertLinkShortDesc">
        <xsl:param name="destination"/>
        <xsl:param name="element"/>
        <xsl:param name="linkScope"/>
        <xsl:choose>
            <!-- User specified description (from map or topic): use that. -->
            <xsl:when
                test="*[contains(@class,' topic/desc ')] and
                processing-instruction()[name()='ditaot'][.='usershortdesc']">
                <xsl:comment>=== start user short description from map or topic ===</xsl:comment>
                <fo:block xsl:use-attribute-sets="link__shortdesc">
                    <xsl:apply-templates select="*[contains(@class, ' topic/desc ')]"/>
                </fo:block>
                <xsl:comment>=== end user short description from map or topic ===</xsl:comment>
            </xsl:when>
            <!-- External: do not attempt to retrieve. -->
            <xsl:when test="$linkScope='external'"> </xsl:when>
            <!-- When the target has a short description and no local override, use the target -->
            <xsl:when test="$element/*[contains(@class, ' topic/shortdesc ')]">
                <!-- 
                <fo:block xsl:use-attribute-sets="link__shortdesc">
                    <xsl:apply-templates select="$element/*[contains(@class, ' topic/shortdesc ')]"/>
                </fo:block>
                -->
            </xsl:when>
        </xsl:choose>
    </xsl:template>





<!-- remove image placement customization for now. see if it's really needed. if so, modify template from 1.5.4 -->



    <!-- SCALE IMAGES -->
    <xsl:template match="*" mode="placeImage">
        <xsl:param name="imageAlign"/>
        <xsl:param name="href"/>
        <xsl:param name="height"/>
        <xsl:param name="width"/>
        <xsl:call-template name="processAttrSetReflection">
            <xsl:with-param name="attrSet" select="concat('__align__', $imageAlign)"/>
            <xsl:with-param name="path" select="'../../cfg/fo/attrs/commons-attr.xsl'"/>
        </xsl:call-template>
        <xsl:variable name="figimage"><xsl:value-of select="parent::fig"/></xsl:variable>
        <xsl:variable name="figframe"><xsl:value-of select="parent::fig/@frame"/></xsl:variable>
        
        <xsl:choose>
            <xsl:when test="$figimage and $figframe='top'">
                <fo:external-graphic src="url({$href})" 
                    xsl:use-attribute-sets="image image__block__baseline frame.top">
                    <xsl:call-template name="imageSizeAttrs">
                        <xsl:with-param name="height" select="$height"/>
                        <xsl:with-param name="width" select="$width"/>
                    </xsl:call-template>
                </fo:external-graphic>
            </xsl:when>
            <xsl:when test="$figimage and $figframe='bottom'">
                <fo:external-graphic src="url({$href})" 
                    xsl:use-attribute-sets="image image__block__baseline frame.bottom">
                    <xsl:call-template name="imageSizeAttrs">
                        <xsl:with-param name="height" select="$height"/>
                        <xsl:with-param name="width" select="$width"/>
                    </xsl:call-template>
                </fo:external-graphic>
            </xsl:when>
            <xsl:when test="$figimage and $figframe='topbot'">
                <fo:external-graphic src="url({$href})" 
                    xsl:use-attribute-sets="image image__block__baseline frame.topbot">
                    <xsl:call-template name="imageSizeAttrs">
                        <xsl:with-param name="height" select="$height"/>
                        <xsl:with-param name="width" select="$width"/>
                    </xsl:call-template>
                </fo:external-graphic>
            </xsl:when>
            <xsl:when test="$figimage and $figframe='sides'">
                <fo:external-graphic src="url({$href})" 
                    xsl:use-attribute-sets="image image__block__baseline frame.sides">
                    <xsl:call-template name="imageSizeAttrs">
                        <xsl:with-param name="height" select="$height"/>
                        <xsl:with-param name="width" select="$width"/>
                    </xsl:call-template>
                </fo:external-graphic>
            </xsl:when>
            <xsl:when test="$figimage and $figframe='all'">
                <fo:external-graphic src="url({$href})" 
                    xsl:use-attribute-sets="image image__block__baseline frame.all">
                    <xsl:call-template name="imageSizeAttrs">
                        <xsl:with-param name="height" select="$height"/>
                        <xsl:with-param name="width" select="$width"/>
                    </xsl:call-template>
                </fo:external-graphic>
            </xsl:when>
            <xsl:when test="$figimage or not(@placement = 'inline')">
                <fo:external-graphic src="url({$href})" 
                    xsl:use-attribute-sets="image image__block__baseline">
                    <xsl:call-template name="imageSizeAttrs">
                        <xsl:with-param name="height" select="$height"/>
                        <xsl:with-param name="width" select="$width"/>
                    </xsl:call-template>
                </fo:external-graphic>
            </xsl:when>
            <xsl:otherwise>
                <fo:external-graphic src="url({$href})" 
                    xsl:use-attribute-sets="image image__inline__baseline">
                    <xsl:call-template name="imageSizeAttrs">
                        <xsl:with-param name="height" select="$height"/>
                        <xsl:with-param name="width" select="$width"/>
                    </xsl:call-template>
                </fo:external-graphic>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="imageSizeAttrs">
        <xsl:param name="height"/>
        <xsl:param name="width"/>
        <xsl:choose>
            <xsl:when test="$height and $width">
                <xsl:attribute name="content-height">
                    <xsl:value-of select="$height"/>
                </xsl:attribute>
                <xsl:attribute name="content-width">
                    <xsl:value-of select="$width"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:when test="$height">
                <xsl:attribute name="content-height">
                    <xsl:value-of select="$height"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:when test="$width">
                <xsl:attribute name="content-width">
                    <xsl:value-of select="$width"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:when test="@scale">
                <xsl:attribute name="content-width">
                    <xsl:value-of select="concat(@scale,'%')"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:when test="@scalefit='yes'">
                <xsl:attribute name="content-width">scale-down-to-fit</xsl:attribute>
                <xsl:attribute name="max-width">95%</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="content-width">100%</xsl:attribute>
                <xsl:attribute name="max-width">8.5in</xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' topic/fig ')]">
        <fo:block xsl:use-attribute-sets="fig" id="{@id}">
            <xsl:call-template name="commonattributes"/>
            <xsl:if test="not(@id)">
                <xsl:attribute name="id">
                    <xsl:call-template name="get-id"/>
                </xsl:attribute>
            </xsl:if>
            <!-- Add expanse processing -->
            <xsl:if test="@expanse='page'">
                <xsl:attribute name="margin-left">-1.28in</xsl:attribute>
                <xsl:attribute name="width">6.4in</xsl:attribute>
                <!-- Might tweak the width, but we want a limit in order to get warnings when images are still going to be too large -->
            </xsl:if>
            <xsl:apply-templates select="*[not(contains(@class,' topic/title '))]"/>
            <xsl:apply-templates select="*[contains(@class,' topic/title ')]"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="*[contains(@class,' topic/figgroup ')]">
        <fo:inline xsl:use-attribute-sets="figgroup" id="{@id}">
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>



    <!-- CONFIGURE NOTE TABLES -->
    <xsl:template match="*[contains(@class,' topic/note ')]">
        <xsl:variable name="noteType">
            <xsl:choose>
                <xsl:when test="@type">
                    <xsl:value-of select="@type"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'note'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="noteImagePath">
            <xsl:call-template name="insertVariable">
                <xsl:with-param name="theVariableID" select="concat($noteType, ' Note Image Path')"
                />
            </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="not($noteImagePath = '')">
                <fo:table xsl:use-attribute-sets="note__table">
                    <fo:table-column column-number="1" column-width="13.2pt"/>
                    <fo:table-column column-number="2" column-width="100%-13.2pt"/>
                    <fo:table-body>
                        <fo:table-row keep-together.within-column="always">
                            <!-- KEEP NOTES FROM BREAKING -->
                            <fo:table-cell xsl:use-attribute-sets="note__image__entry">
                                <fo:block>
                                    <fo:external-graphic
                                        src="url({concat($artworkPrefix, $noteImagePath)})"
                                        xsl:use-attribute-sets="image" content-width="7.68pt"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="note__text__entry">
                                <xsl:attribute name="padding-top">3pt</xsl:attribute>
                                <xsl:attribute name="padding-bottom">3pt</xsl:attribute>
                                <xsl:attribute name="padding-left">3pt</xsl:attribute>
                                <xsl:attribute name="padding-right">3pt</xsl:attribute>
                                <xsl:choose>
                                    <xsl:when test="$noteType='tip'">
                                        <xsl:attribute name="background-color"
                                            >cmyk(0.075,0.027,0,0)</xsl:attribute>
                                        <!-- RGB: #EAF7FF -->
                                        <xsl:attribute name="border">0.5pt solid
                                            cmyk(0.341,0.137,0,0)</xsl:attribute>
                                        <!-- RGB: #A5D8FF -->
                                    </xsl:when>
                                    <xsl:when test="$noteType='fastpath'">
                                        <xsl:attribute name="background-color"
                                            >cmyk(0.086,0,0.117,0.067)</xsl:attribute>
                                        <!-- RGB: #D8EED0 -->
                                        <xsl:attribute name="border">0.5pt solid
                                            cmyk(0.224,0,0.318,0.298)</xsl:attribute>
                                        <!-- RGB: #7AB362 -->
                                    </xsl:when>
                                    <xsl:when test="$noteType='important'">
                                        <xsl:attribute name="background-color"
                                            >cmyk(0,0.094,0.125,0)</xsl:attribute>
                                        <!-- RGB: #FFE8E0 -->
                                        <xsl:attribute name="border">0.5pt solid
                                            cmyk(0,0.231,0.298,0)</xsl:attribute>
                                        <!-- RGB: #FFC5B4 -->
                                    </xsl:when>
                                    <xsl:when test="$noteType='note'">
                                        <xsl:attribute name="background-color"
                                            >cmyk(0,0,0.20,0)</xsl:attribute>
                                        <!-- RGB: #FFFFCC -->
                                        <xsl:attribute name="border">0.5pt solid
                                            cmyk(0,0.153,0.318,0.027)</xsl:attribute>
                                        <!-- RGB: #F9D2A8 -->
                                    </xsl:when>
                                </xsl:choose>

                                <xsl:call-template name="placeNoteContent"/>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="placeNoteContent"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>







    <!-- START PAGE NUMBERING AT 1 WITH FIRST CHAPTER (from commons.xsl) -->
    <xsl:template name="startPageNumbering">
        <!--BS: uncomment if you need reset page numbering at first chapter-->

        <xsl:variable name="id"
            select="ancestor-or-self::*[contains(@class, ' topic/topic ')][1]/@id"/>
        <xsl:variable name="gid"
            select="generate-id(ancestor-or-self::*[contains(@class, ' topic/topic ')][1])"/>
        <xsl:variable name="topicNumber"
            select="count(exsl:node-set($topicNumbers)/topic[@id = $id][following-sibling::topic[@guid = $gid]]) + 1"/>
        <xsl:variable name="mapTopic" select="($map//*[@id = $id])[position() = $topicNumber]"/>

        <xsl:if
            test="not(($mapTopic/preceding::*[contains(@class, ' bookmap/chapter ') or contains(@class, ' bookmap/part ')])
            or ($mapTopic/ancestor::*[contains(@class, ' bookmap/chapter ') or contains(@class, ' bookmap/part ')]))">
            <xsl:attribute name="initial-page-number">1</xsl:attribute>
        </xsl:if>
    </xsl:template>



    <!--Definition list-->
    <xsl:template match="*[contains(@class, ' topic/dl ')]">
        <fo:block xsl:use-attribute-sets="dl" id="{@id}">
            <xsl:apply-templates select="*[contains(@class, ' topic/dlhead ')]"/>
            <xsl:apply-templates select="*[contains(@class, ' topic/dlentry ')]"/>
        </fo:block>
        <!-- 
        <fo:table xsl:use-attribute-sets="dl" id="{@id}">
            <xsl:apply-templates select="*[contains(@class, ' topic/dlhead ')]"/>
            <fo:table-body xsl:use-attribute-sets="dl__body">
                <xsl:choose>
                    <xsl:when test="contains(@otherprops,'sortable')">
                        <xsl:apply-templates select="*[contains(@class, ' topic/dlentry ')]">
                            <xsl:sort select="opentopic-func:getSortString(normalize-space( opentopic-func:fetchValueableText(*[contains(@class, ' topic/dt ')]) ))" lang="{$locale}"/>
                        </xsl:apply-templates>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="*[contains(@class, ' topic/dlentry ')]"/>
                    </xsl:otherwise>
                </xsl:choose>
            </fo:table-body>
        </fo:table>
        -->
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/dl ')]/*[contains(@class, ' topic/dlhead ')]">
        <fo:block xsl:use-attribute-sets="dl.dlhead" id="{@id}">
            <xsl:apply-templates/>
        </fo:block>
        <!--
        <fo:table-header xsl:use-attribute-sets="dl.dlhead" id="{@id}">
            <fo:table-row xsl:use-attribute-sets="dl.dlhead__row">
                <xsl:apply-templates/>
            </fo:table-row>
        </fo:table-header>
        -->
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/dlhead ')]/*[contains(@class, ' topic/dthd ')]">
        <fo:block xsl:use-attribute-sets="dlhead.dthd__content">
            <xsl:apply-templates/>
        </fo:block>
        <!--
        <fo:table-cell xsl:use-attribute-sets="dlhead.dthd__cell" id="{@id}">
            <fo:block xsl:use-attribute-sets="dlhead.dthd__content">
                <xsl:apply-templates/>
            </fo:block>
        </fo:table-cell>
        -->
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/dlhead ')]/*[contains(@class, ' topic/ddhd ')]">
        <fo:block xsl:use-attribute-sets="dlhead.ddhd__content">
            <xsl:apply-templates/>
        </fo:block>
        <!--
        <fo:table-cell xsl:use-attribute-sets="dlhead.ddhd__cell" id="{@id}">
            <fo:block xsl:use-attribute-sets="dlhead.ddhd__content">
                <xsl:apply-templates/>
            </fo:block>
        </fo:table-cell>
        -->
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/dlentry ')]">
        <fo:block xsl:use-attribute-sets="dlentry.dt" id="{@id}">
            <xsl:apply-templates select="*[contains(@class, ' topic/dt ')]"/>
        </fo:block>
        <fo:block xsl:use-attribute-sets="dlentry.dd" id="{@id}">
            <xsl:apply-templates select="*[contains(@class, ' topic/dd ')]"/>
        </fo:block>
        <!--
        <fo:table-row xsl:use-attribute-sets="dlentry" id="{@id}">
            <fo:table-cell xsl:use-attribute-sets="dlentry.dt" id="{@id}" width="1.5in">
                <xsl:apply-templates select="*[contains(@class, ' topic/dt ')]"/>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="dlentry.dd" id="{@id}" width="3in">
                <xsl:apply-templates select="*[contains(@class, ' topic/dd ')]"/>
            </fo:table-cell>
        </fo:table-row>
        -->
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/dt ')]">
        <fo:block xsl:use-attribute-sets="dlentry.dt__content">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/dd ')]">
        <fo:block xsl:use-attribute-sets="dlentry.dd__content">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>



    <!-- CONFIGURE CHAPTER NUMBER PLACEMENT -->
    <xsl:template name="insertChapterFirstpageStaticContent">
        <xsl:param name="type"/>
        <fo:block>
            <xsl:attribute name="id">
                <xsl:value-of select="concat('_OPENTOPIC_TOC_PROCESSING_', generate-id())"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="$type = 'chapter'">
                    <fo:block xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                        <xsl:call-template name="insertVariable">
                            <xsl:with-param name="theVariableID" select="'Chapter with number'"/>
                            <xsl:with-param name="theParameters">
                                <number>
                                    <xsl:variable name="id" select="@id"/>
                                    <xsl:variable name="topicChapters">
                                        <xsl:copy-of
                                            select="$map//*[contains(@class, ' bookmap/chapter ')]"
                                        />
                                    </xsl:variable>
                                    <xsl:variable name="chapterNumber">
                                        <xsl:number format="1"
                                            value="count($topicChapters/*[@id = $id]/preceding-sibling::*) + 1"
                                        />
                                    </xsl:variable>
                                    <fo:block-container
                                        xsl:use-attribute-sets="__chapter__frontmatter__number__container">
                                        <fo:block>
                                            <xsl:value-of select="$chapterNumber"/>
                                        </fo:block>
                                    </fo:block-container>
                                </number>
                            </xsl:with-param>
                        </xsl:call-template>
                    </fo:block>
                </xsl:when>
                <xsl:when test="$type = 'appendix'">
                    <fo:block xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                        <xsl:call-template name="insertVariable">
                            <xsl:with-param name="theVariableID" select="'Appendix with number'"/>
                            <xsl:with-param name="theParameters">
                                <number>
                                    <xsl:variable name="id" select="@id"/>
                                    <xsl:variable name="topicAppendixes">
                                        <xsl:copy-of
                                            select="$map//*[contains(@class, ' bookmap/appendix ')]"
                                        />
                                    </xsl:variable>
                                    <xsl:variable name="appendixNumber">
                                        <xsl:number format="A"
                                            value="count($topicAppendixes/*[@id = $id]/preceding-sibling::*) + 1"
                                        />
                                    </xsl:variable>
                                    <fo:block-container
                                        xsl:use-attribute-sets="__chapter__frontmatter__number__container">
                                        <fo:block>
                                            <xsl:value-of select="$appendixNumber"/>
                                        </fo:block>
                                    </fo:block-container>
                                </number>
                            </xsl:with-param>
                        </xsl:call-template>
                    </fo:block>
                </xsl:when>

                <xsl:when test="$type = 'part'">
                    <fo:block xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                        <xsl:call-template name="insertVariable">
                            <xsl:with-param name="theVariableID" select="'Part with number'"/>
                            <xsl:with-param name="theParameters">
                                <number>
                                    <xsl:variable name="id" select="@id"/>
                                    <xsl:variable name="topicParts">
                                        <xsl:copy-of
                                            select="$map//*[contains(@class, ' bookmap/part ')]"/>
                                    </xsl:variable>
                                    <xsl:variable name="partNumber">
                                        <xsl:number format="I"
                                            value="count($topicParts/*[@id = $id]/preceding-sibling::*) + 1"
                                        />
                                    </xsl:variable>
                                    <fo:block-container
                                        xsl:use-attribute-sets="__chapter__frontmatter__number__container">
                                        <fo:block>
                                            <xsl:value-of select="$partNumber"/>
                                        </fo:block>
                                    </fo:block-container>
                                </number>
                            </xsl:with-param>
                        </xsl:call-template>
                    </fo:block>
                </xsl:when>
                <xsl:when test="$type = 'preface'">
                    <fo:block xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                        <xsl:call-template name="insertVariable">
                            <xsl:with-param name="theVariableID" select="'Preface title'"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:when>
                <xsl:when test="$type = 'notices'">
                    <fo:block xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                        <xsl:call-template name="insertVariable">
                            <xsl:with-param name="theVariableID" select="'Notices title'"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:when>
            </xsl:choose>
        </fo:block>
    </xsl:template>


    <!-- not doing anything i see (match="//*[@outputclass='backmatter']") -->
    <xsl:template match="//*[@outputclass='backmatter']">
        <fo:block>
            <xsl:attribute name="border">2px solid green</xsl:attribute>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>




    <!-- Processing for ph that need to display math characters not supported in the regular fonts -->
    <xsl:template match="*[contains(@class,' topic/ph ') and contains(@outputclass,'Math')]">
        <fo:inline xsl:use-attribute-sets="ph" id="{@id}">
            <xsl:attribute name="font-family">Math</xsl:attribute>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>

    <!-- Processing for ph that need to display in red -->
    <xsl:template match="*[contains(@class,' topic/ph ') and contains(@outputclass,'ExampleRed')]">
        <fo:inline xsl:use-attribute-sets="ph" id="{@id}">
            <xsl:attribute name="color">red</xsl:attribute>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>

    <!-- Processing for ph that need to display in arbitrary colors (example: symbols) -->
    <xsl:template match="*[contains(@class,' topic/ph ') and contains(@outputclass,'color=')]">
        <xsl:param name="colorvalue" 
            select="replace(./@outputclass,'^.*?\s*color=(#?[a-zA-Z0-9]+)($|[\s;].*?$)','$1')"/>
        <fo:inline xsl:use-attribute-sets="ph" id="{@id}">
            <xsl:attribute name="color"><xsl:value-of select="$colorvalue"/></xsl:attribute>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    
    <!-- Processing for ph that need to display in small-caps (example: symbols) -->
    <xsl:template match="*[contains(@class,' topic/ph ') and contains(@outputclass,'small-caps')]">
        <fo:inline xsl:use-attribute-sets="ph" id="{@id}">
            <!-- NOTE: FOP DOESN'T ACTUALLY SUPPORT font-variant YET -->
            <xsl:attribute name="font-variant">small-caps</xsl:attribute>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    
    <!-- Processing for other items that need to display math characters not supported in the regular fonts -->
    <!-- NEEDS TESTING -->
    <xsl:template match="//*[contains(@outputclass,'Math')]">
        <fo:inline>
            <xsl:attribute name="font-family">Math</xsl:attribute>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>


    <!-- USE NON-BREAKING SPACE BEFORE ARROW IN MENUCASCADE -->
    <xsl:template match="*[contains(@class,' ui-d/uicontrol ')]">
        <!-- insert an arrow before all but the first uicontrol in a menucascade -->
        <xsl:if test="ancestor::*[contains(@class,' ui-d/menucascade ')]">
            <xsl:variable name="uicontrolcount">
                <xsl:number count="*[contains(@class,' ui-d/uicontrol ')]"/>
            </xsl:variable>
            <xsl:if test="$uicontrolcount&gt;'1'">
                <!-- <fo:character character="&#x00A0;"/><xsl:text>&gt; </xsl:text> -->
                <xsl:text>&#x00A0;&gt; </xsl:text>
            </xsl:if>
        </xsl:if>
        <fo:inline xsl:use-attribute-sets="uicontrol" id="{@id}"
            line-height-shift-adjustment="consider-shifts">
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>



</xsl:stylesheet>
