<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:exsl="http://exslt.org/common"
    xmlns:opentopic="http://www.idiominc.com/opentopic" xmlns:exslf="http://exslt.org/functions"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    extension-element-prefixes="exsl" exclude-result-prefixes="opentopic exslf opentopic-func"
    version="1.1">



    <xsl:attribute-set name="copyright_notice_title" use-attribute-sets="topic.title">
        <xsl:attribute name="font-size">14pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="copyright_notice_body">
        <xsl:attribute name="margin-left">0pt</xsl:attribute>
        <xsl:attribute name="font-size">7pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="copyright_p">
        <xsl:attribute name="line-height">0.75pc</xsl:attribute><!-- Per John 7/12/2011 -->
        <xsl:attribute name="space-before">0.5pc</xsl:attribute><!-- adjusted since not baseline to baseline measure -->
    </xsl:attribute-set>
    <xsl:attribute-set name="copyright_p_extraspace" use-attribute-sets="copyright_p">
        <xsl:attribute name="space-before">1.5pc</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="copyright_notice_tm">
        <xsl:attribute name="baseline-shift">20%</xsl:attribute>
        <xsl:attribute name="font-size">smaller</xsl:attribute>
        <xsl:attribute name="line-height-shift-adjustment">disregard-shifts</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="copyright_notice_addressblock">
        <xsl:attribute name="line-height">1pc</xsl:attribute><!-- Per John 7/12/2011 -->
        <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
        <xsl:attribute name="space-before">0pc</xsl:attribute>
        <xsl:attribute name="white-space-collapse">true</xsl:attribute>
        <xsl:attribute name="wrap-option">wrap</xsl:attribute>
    </xsl:attribute-set>



    <xsl:template name="create_copyright_notice">
        <fo:block xsl:use-attribute-sets="topic">
            <xsl:attribute name="break-before">page</xsl:attribute>
            <!-- 
            <xsl:attribute name="id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            -->
            <!-- 
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
            -->
            <xsl:call-template name="insertChapterFirstpageStaticContent">
                <xsl:with-param name="type" select="'notices'"/>
            </xsl:call-template>

            <!-- 
            <fo:block xsl:use-attribute-sets="copyright_notice_title">Copyright</fo:block>
        -->
            <!-- 
                <xsl:call-template name="pullPrologIndexTerms"/>
                <xsl:for-each select="child::*[contains(@class,' topic/title ')]">
                <xsl:call-template name="getTitle"/>
                </xsl:for-each>
            -->
            <!-- Never create mini toc or process metadata for copyright topic -->
            <!-- 
                <xsl:choose>
                <xsl:when test="not($noticesLayout='BASIC') and .//*[(contains(@class,' topic/topic '))]">
                <xsl:call-template name="createMiniToc"/>
                </xsl:when>
                <xsl:otherwise>
                <fo:block>
                
                <xsl:apply-templates select="*[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                contains(@class, ' topic/prolog '))]">
                </xsl:apply-templates>
                <xsl:call-template name="buildRelationships"/>
                </fo:block>
                
                </xsl:otherwise>
                </xsl:choose>
            -->

            <fo:block xsl:use-attribute-sets="copyright_notice_body">
                <fo:block xsl:use-attribute-sets="copyright_p">
                    <xsl:value-of select="$booktitle"/> is published by <xsl:value-of
                        select="$copyrightholder"/>
                </fo:block>
                <fo:block xsl:use-attribute-sets="copyright_p">
                    <xsl:value-of select="$copyrightstatement"/>
                </fo:block>
                <fo:block xsl:use-attribute-sets="copyright_p">Printed in the United States of America. </fo:block>
                <fo:block xsl:use-attribute-sets="copyright_p">
                    <xsl:value-of select="$revision_m.d.yyyy"/>
                </fo:block>

                <!-- don't get topic content
                <fo:block>

                    <xsl:apply-templates
                        select="*[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                        contains(@class, ' topic/prolog '))]"> </xsl:apply-templates>
                    <xsl:call-template name="buildRelationships"/>
                </fo:block>

                <xsl:apply-templates select="*[contains(@class,' topic/topic ')]"/>
                -->
                

                <fo:block xsl:use-attribute-sets="copyright_p">
                    WebAssign<fo:inline xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline> is a 
                    registered trademark of Advanced Instructional Systems, Inc. 
                </fo:block>
                <fo:block xsl:use-attribute-sets="copyright_p">
                    pencilPad<fo:inline xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline>, 
                    chemPad<fo:inline xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline>, 
                    calcPad<fo:inline xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline>, 
                    physPad<fo:inline xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline>, 
                    and 
                    Personal Study Plan<fo:inline xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline> are registered
                    trademarks of Advanced Instructional Systems, Inc. (dba 
                    WebAssign<fo:inline xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline>). NumberLine<fo:inline
                            xsl:use-attribute-sets="copyright_notice_tm">™</fo:inline> is a service mark 
                    of Advanced Instructional Systems, Inc. </fo:block>
                <fo:block xsl:use-attribute-sets="copyright_p">Adobe<fo:inline
                    xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline>, Acrobat<fo:inline
                        xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline>, Acrobat Reader<fo:inline
                            xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline>,
                    Flash<fo:inline
                        xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline>, and
                    Shockwave<fo:inline
                        xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline> are
                    registered trademarks of Adobe Systems Incorporated in the United States, other
                    countries, or both. </fo:block>
                <fo:block xsl:use-attribute-sets="copyright_p">Apple<fo:inline
                    xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline>, Mac<fo:inline
                        xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline>, and
                    Safari<fo:inline
                        xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline> are
                    registered trademarks of Apple Inc., in the United States, other countries, or
                    both. </fo:block>
                <fo:block xsl:use-attribute-sets="copyright_p">Internet Explorer<fo:inline
                    xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline>, Microsoft<fo:inline
                        xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline>, PowerPoint<fo:inline
                            xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline>, and Windows<fo:inline
                                xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline> are
                    registered trademarks of Microsoft Corporation in the United States, other
                    countries, or both. </fo:block>
                <fo:block xsl:use-attribute-sets="copyright_p">Java<fo:inline
                        xsl:use-attribute-sets="copyright_notice_tm">™</fo:inline> is a
                    trademark of Sun Microsystems, Inc. in the United States, other countries, or
                    both. </fo:block>
                <fo:block xsl:use-attribute-sets="copyright_p">Linux<fo:inline
                    xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline> is the registered trademark of Linus
                    Torvalds in the United States, other countries, or both. </fo:block>
                <fo:block xsl:use-attribute-sets="copyright_p">Mozilla<fo:inline
                    xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline> and Firefox<fo:inline
                        xsl:use-attribute-sets="copyright_notice_tm">®</fo:inline> are
                    registered trademarks of the Mozilla Foundation in the United States, other
                    countries, or both. </fo:block>
                <fo:block xsl:use-attribute-sets="copyright_p">Other product and company names mentioned
                    herein may be the trademarks of their respective owners. </fo:block>
                <fo:block xsl:use-attribute-sets="copyright_p_extraspace">Under the copyright laws, neither this
                    documentation nor the software may be copied, in whole or in part, without the
                    written consent of Advanced Instructional Systems, except in the normal use of
                    the software. </fo:block>
                <fo:block xsl:use-attribute-sets="copyright_p_extraspace">Questions in the database that are identified
                    with a specific textbook have been used with the permission of the publisher who
                    owns the copyright. </fo:block>
                <fo:block xsl:use-attribute-sets="copyright_p_extraspace">Order the WebAssign service from: 
                    <fo:block xsl:use-attribute-sets="copyright_notice_addressblock">WebAssign
                        NC State Centennial Campus
                        1791 Varsity Drive, Suite 200
                        Raleigh, NC 27606
                        Web: <fo:basic-link
                            color="cmyk(1,1,0,0)" external-destination="url(http://webassign.net)"
                            font-style="normal">http://webassign.net</fo:basic-link>
                        Tel: (800) 955-8275 or (919) 829-8181
                        Fax: (919) 829-1516
                        Email: <fo:basic-link color="cmyk(1,1,0,0)" external-destination="url(mailto:info@webassign.net)"
                            font-style="normal">info@webassign.net</fo:basic-link>
                    </fo:block>
                </fo:block>



            </fo:block>






        </fo:block>


    </xsl:template>
</xsl:stylesheet>
