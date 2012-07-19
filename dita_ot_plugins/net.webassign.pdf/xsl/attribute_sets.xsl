<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="1.0">
    
    <!-- This is the default, but you can set the margins individually below. -->
    <xsl:variable name="page-margins">1in</xsl:variable>
    
    <!-- Change these if your page has different margins on different sides. -->
    <xsl:variable name="page-margin-left" select="$page-margins"/>
    <xsl:variable name="page-margin-right" select="$page-margins"/>
    <xsl:variable name="page-margin-top" select="$page-margins"/>
    <xsl:variable name="page-margin-bottom" select="$page-margins"/>

    <!-- Notices margins -->
    <xsl:variable name="notices-margin-left">0.75in</xsl:variable>
    <xsl:variable name="notices-margin-right">0.75in</xsl:variable>
    <xsl:variable name="notices-margin-top">0.75in</xsl:variable>
    <xsl:variable name="notices-margin-bottom">0.75in</xsl:variable>
    <xsl:variable name="notices-column-gap">0.25in</xsl:variable>

    
    <xsl:variable name="default-font-size">9pt</xsl:variable>
    <xsl:variable name="table-font-size">8pt</xsl:variable>
    <xsl:variable name="side-col-width">1.28in</xsl:variable><!-- Used to specify how far to indent body text -->
    
    <!-- Attribute sets -->
    
    <!-- Notices -->
    <xsl:attribute-set name="__notices.title" use-attribute-sets="topic.title">
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="border-bottom-style">none</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="padding-top">0em</xsl:attribute>
        <xsl:attribute name="space-before">0em</xsl:attribute>
        <xsl:attribute name="margin-bottom">0.25em</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="__notices.body">
        <xsl:attribute name="font-size">6pt</xsl:attribute>
        <xsl:attribute name="line-height">99.9%</xsl:attribute>
    </xsl:attribute-set>
    
    
    
    <xsl:attribute-set name="__frontmatter">
        <xsl:attribute name="text-align">right</xsl:attribute>
        <xsl:attribute name="margin-top">8.25in</xsl:attribute>
        <xsl:attribute name="margin-left">4.6in</xsl:attribute>
        <xsl:attribute name="margin-right">0.3in</xsl:attribute>
        <xsl:attribute name="font-family">Arial</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__frontmatter__title">
        <xsl:attribute name="margin-top">0in</xsl:attribute>
        <xsl:attribute name="font-family">inherit</xsl:attribute>
        <xsl:attribute name="font-size">21pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="letter-spacing">-0.5pt</xsl:attribute>
        <xsl:attribute name="line-height">25pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__frontmatter__subtitle">
        <xsl:attribute name="font-family">inherit</xsl:attribute>
        <xsl:attribute name="font-size">17pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="line-height">20pt</xsl:attribute>
        <xsl:attribute name="letter-spacing">-0.5pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__frontmatter__revdate">
        <xsl:attribute name="font-family">inherit</xsl:attribute>
        <xsl:attribute name="font-size">17pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="line-height">20pt</xsl:attribute>
        <xsl:attribute name="letter-spacing">-0.5pt</xsl:attribute>
        <xsl:attribute name="color">#645A58</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__frontmatter__owner">
        <xsl:attribute name="margin-top">3pc</xsl:attribute>
        <xsl:attribute name="font-family">inherit</xsl:attribute>
        <xsl:attribute name="font-size">11pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="line-height">normal</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__frontmatter__owner__container">
        <xsl:attribute name="position">absolute</xsl:attribute>
        <xsl:attribute name="top">210mm</xsl:attribute>
        <xsl:attribute name="bottom">20mm</xsl:attribute>
        <xsl:attribute name="right">20mm</xsl:attribute>
        <xsl:attribute name="left">20mm</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__frontmatter__owner__container_content">
        <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:attribute-set>
    
   
    
    <xsl:attribute-set name="__frontmatter__mainbooktitle">
        <!--<xsl:attribute name=""></xsl:attribute>-->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__frontmatter__booklibrary">
        <xsl:attribute name="font-family">inherit</xsl:attribute>
        <xsl:attribute name="font-size">inherit</xsl:attribute><!-- was: 21pt -->
        <xsl:attribute name="letter-spacing">inherit</xsl:attribute><!-- was: -0.5pt -->
        <xsl:attribute name="line-height">inherit</xsl:attribute><!-- was: 25pt -->
    </xsl:attribute-set>
    
    
    <xsl:attribute-set name="__frontmatter__titlepage">
        <xsl:attribute name="break-before">odd-page</xsl:attribute>
        <xsl:attribute name="text-align">right</xsl:attribute>
        <xsl:attribute name="margin-top">3.5in</xsl:attribute>
        <xsl:attribute name="margin-left">1in</xsl:attribute>
        <xsl:attribute name="margin-right">0in</xsl:attribute>
        <xsl:attribute name="font-family">Sans</xsl:attribute>
        <xsl:attribute name="font-size">24pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__frontmatter__titlepage__revdate">
        <xsl:attribute name="margin-top">0.75in</xsl:attribute>
        <xsl:attribute name="font-family">inherit</xsl:attribute>
        <xsl:attribute name="font-size">14pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    
    
    <xsl:attribute-set name="bookmap.summary">
        <xsl:attribute name="font-size">9pt</xsl:attribute>
    </xsl:attribute-set>
    
    
    <!-- HEADERS & FOOTERS -->
    <xsl:attribute-set name="__body__odd__footer">
        <xsl:attribute name="font-size">7pt</xsl:attribute>
        <xsl:attribute name="font-style">italic</xsl:attribute>
        <xsl:attribute name="text-align">right</xsl:attribute>
        <xsl:attribute name="margin-right"><xsl:value-of select="$page-margin-right"/></xsl:attribute>
        <xsl:attribute name="margin-left"><xsl:value-of select="$page-margin-left"/></xsl:attribute>
        <xsl:attribute name="margin-bottom">24pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__body__odd__footer__heading">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__body__odd__footer__pagenum">
        <xsl:attribute name="font-weight">normal</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__body__even__footer" use-attribute-sets="__body__odd__footer">
        <xsl:attribute name="text-align">left</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__body__even__footer__heading">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__body__even__footer__pagenum">
        <xsl:attribute name="font-weight">normal</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__body__odd__header">
        <xsl:attribute name="text-align">right</xsl:attribute>
        <xsl:attribute name="font-size">8pt</xsl:attribute>
        <xsl:attribute name="font-style">italic</xsl:attribute>
        <xsl:attribute name="padding-bottom">4pt</xsl:attribute>
        <xsl:attribute name="border-bottom">0.25pt solid black</xsl:attribute>
        <xsl:attribute name="margin-left"><xsl:value-of select="$page-margin-left"/></xsl:attribute>
        <xsl:attribute name="margin-right"><xsl:value-of select="$page-margin-right"/></xsl:attribute>
        <xsl:attribute name="margin-top">35pt</xsl:attribute>
        <xsl:attribute name="space-after">10pt</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">10pt</xsl:attribute>
        <xsl:attribute name="space-after.maximum">10pt</xsl:attribute>
        <xsl:attribute name="space-after.optimum">10pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__body__odd__header__heading">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__body__odd__header__pagenum">
        <xsl:attribute name="font-weight">normal</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__body__even__header" use-attribute-sets="__body__odd__header">
        <xsl:attribute name="text-align">left</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__body__even__header__heading">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__body__even__header__pagenum">
        <xsl:attribute name="font-weight">normal</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__body__first__header">
        <xsl:attribute name="text-align">right</xsl:attribute>
        <xsl:attribute name="margin-right">10pt</xsl:attribute>
        <xsl:attribute name="margin-top">10pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__body__first__footer" use-attribute-sets="__body__odd__footer">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__body__first__header__heading">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__body__first__header__pagenum">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__body__first__footer__heading">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__body__first__footer__pagenum">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__body__last__header">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__body__last__footer">
    </xsl:attribute-set>
    
    
    <xsl:attribute-set name="__toc__odd__footer" use-attribute-sets="__body__odd__footer">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__odd__footer__pagenum" use-attribute-sets="__body__odd__footer__pagenum">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__even__footer" use-attribute-sets="__body__even__footer">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__even__footer__pagenum" use-attribute-sets="__body__even__footer__pagenum">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__odd__header" use-attribute-sets="__body__odd__header">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__odd__header__pagenum" use-attribute-sets="__body__odd__header__pagenum">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__even__header" use-attribute-sets="__body__even__header">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__even__header__pagenum" use-attribute-sets="__body__even__header__pagenum">
    </xsl:attribute-set>
    
    
    
    
    
    <!-- TOPIC TITLES -->
    
    <xsl:attribute-set name="topic.title">
        <xsl:attribute name="font-size">24pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-family">Sans</xsl:attribute>
        <xsl:attribute name="color">Black</xsl:attribute>
        <xsl:attribute name="padding-bottom">0.75pc</xsl:attribute><!-- 
            per John 6/12/2011: 1.5pc from baseline to border. 
            This accomplishes request since padding-bottom is not measured from baseline. -->
        <xsl:attribute name="border-bottom">2pt solid Black</xsl:attribute>
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <!-- 
            Per John 6/12/2011: 6pc from bottom of red box to baseline.
            Adjusted value since not measured to baseline. -->
        <xsl:attribute name="padding-top">0pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">4pc</xsl:attribute><!-- 
            per John 6/12/2011: 5pc to baseline of first item. 
            Adjusted since cannot measure to baseline of first item. -->
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.title">
        <xsl:attribute name="font-size">14pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-family">Sans</xsl:attribute>
        <xsl:attribute name="color">cmyk(0.333,0.133,0,0.505)</xsl:attribute><!-- RGB: #2A5C7E -->
        <xsl:attribute name="border-bottom-style">none</xsl:attribute>
        <xsl:attribute name="space-before">1.8em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">1.8em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1.8em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">1.8em</xsl:attribute>
        <xsl:attribute name="padding-top">4pt</xsl:attribute>
        <xsl:attribute name="margin-left"><xsl:value-of select="$side-col-width"/>*0.5</xsl:attribute>
        <xsl:attribute name="margin-bottom">6pt</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.topic.title" use-attribute-sets="topic.topic.title">
        <xsl:attribute name="margin-left"><xsl:value-of select="$side-col-width"/></xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <!-- 
            <xsl:attribute name="margin-top">36pt</xsl:attribute>
        -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.topic.topic.title" use-attribute-sets="topic.topic.title">
        <xsl:attribute name="margin-left"><xsl:value-of select="$side-col-width"/></xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <!-- 
            <xsl:attribute name="margin-top">24pt</xsl:attribute>
        -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.topic.topic.topic.title" use-attribute-sets="topic.topic.title">
        <xsl:attribute name="margin-left"><xsl:value-of select="$side-col-width"/></xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="topic.topic.topic.topic.topic.topic.title" use-attribute-sets="topic.topic.title">
        <xsl:attribute name="margin-left"><xsl:value-of select="$side-col-width"/></xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="section.title" use-attribute-sets="topic.topic.title">
        <xsl:attribute name="font-size">11pt</xsl:attribute>
        <xsl:attribute name="color">black</xsl:attribute>
        <xsl:attribute name="margin-left">0pt</xsl:attribute>
        <xsl:attribute name="start-indent"><xsl:value-of select="$side-col-width"/></xsl:attribute>
        
    </xsl:attribute-set>
    
    <xsl:attribute-set name="example.title" use-attribute-sets="section.title">
    	<!-- 
        <xsl:attribute name="margin-left">-<xsl:value-of select="$side-col-width"/></xsl:attribute>
        <xsl:attribute name="start-indent">0pt</xsl:attribute>
        -->
    </xsl:attribute-set>
    
    
    <!-- Indent body text -->
    
    <xsl:attribute-set name="body">
        <xsl:attribute name="margin-left"><xsl:value-of select="$side-col-width"/></xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height">1pc</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="body__toplevel" use-attribute-sets="body">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="body__secondLevel" use-attribute-sets="body">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="taskbody" use-attribute-sets="body">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="refbody" use-attribute-sets="body">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="conbody" use-attribute-sets="body">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="related-links">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
        <xsl:attribute name="space-after">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
        <xsl:attribute name="space-before">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="related-links__content">
        <xsl:attribute name="start-indent"><xsl:value-of select="$side-col-width"/></xsl:attribute> 
        <!--<xsl:attribute name="start-indent">0em</xsl:attribute>-->
        
    </xsl:attribute-set>
    
    <xsl:attribute-set name="related-links.title">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="start-indent"><xsl:value-of select="$side-col-width"/></xsl:attribute>
        <xsl:attribute name="keep-with-next">always</xsl:attribute>
    </xsl:attribute-set>
    
    
    
    
    <xsl:attribute-set name="__force__page__count">
        <xsl:attribute name="force-page-count">
            <xsl:choose>
                <xsl:when test="name(/*) = 'bookmap'">
                    <xsl:value-of select="'even'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'auto'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:attribute-set>
    
    
    <!-- TOC -->
    
    
    <xsl:attribute-set name="__toc__header" use-attribute-sets="topic.title">
        <!-- REMOVING DEFAULT FORMATTING IN LIEU OF USING THE SAME AS topic.title -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__link">
        <xsl:attribute name="line-height">150%</xsl:attribute>
        <!--xsl:attribute name="font-size">
            <xsl:variable name="level" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])"/>
            <xsl:value-of select="concat(string(20 - number($level) - 4), 'pt')"/>
            </xsl:attribute-->
    </xsl:attribute-set>
    
    
    <xsl:attribute-set name="__toc__topic__content">
        <xsl:attribute name="last-line-end-indent">-22pt</xsl:attribute>
        <xsl:attribute name="end-indent">22pt</xsl:attribute>
        <xsl:attribute name="text-indent">0pt</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="text-align-last">justify</xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:variable name="level" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])"/>
            <xsl:choose>
                <xsl:when test="$level = 1">10pt</xsl:when>
                <xsl:otherwise>9pt</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="font-weight">
            <xsl:variable name="level" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])"/>
            <xsl:choose>
                <xsl:when test="$level = 1">bold</xsl:when>
                <xsl:otherwise>normal</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="padding-top">0.33em</xsl:attribute>
        
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__chapter__content" use-attribute-sets="__toc__topic__content">
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="padding-top">1.2em</xsl:attribute>
        <xsl:attribute name="padding-bottom">0.07em</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__appendix__content" use-attribute-sets="__toc__chapter__content">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__part__content" use-attribute-sets="__toc__chapter__content">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__preface__content" use-attribute-sets="__toc__topic__content">
        <xsl:attribute name="font-size">14pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="padding-top">20pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__notices__content" use-attribute-sets="__toc__topic__content">
        <xsl:attribute name="font-size">14pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="padding-top">20pt</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- Added for back compatibility since __toc__content was renamed into __toc__topic__content-->
    <xsl:attribute-set name="__toc__content" use-attribute-sets="__toc__topic__content">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__title">
        <xsl:attribute name="margin-right">0.2in</xsl:attribute>
        <xsl:attribute name="keep-together.within-line">auto</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__page-number">
        <xsl:attribute name="margin-left">-.2in</xsl:attribute>
        <xsl:attribute name="keep-together.within-line">always</xsl:attribute><!-- was always -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__leader">
        <xsl:attribute name="leader-pattern">dots</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__indent">
        <xsl:attribute name="margin-left">
            <xsl:variable name="level" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])"/>
            <xsl:value-of select="concat(string(42 + number($level) * 14), 'pt')"/>
        </xsl:attribute>
    </xsl:attribute-set>
    
    
    
    
    <!-- MINI-TOC -->
    <xsl:attribute-set name="__toc__mini">
        <xsl:attribute name="font-size">8pt</xsl:attribute>
        <xsl:attribute name="font-family">Sans</xsl:attribute>
        <xsl:attribute name="end-indent">5pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__mini__header" use-attribute-sets="__toc__mini">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-size">9pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__mini__list">
        <xsl:attribute name="provisional-distance-between-starts">0.75pc</xsl:attribute>
        <xsl:attribute name="provisional-label-separation">3pt</xsl:attribute>
        <xsl:attribute name="space-after.optimum">9pt</xsl:attribute>
        <xsl:attribute name="space-before.optimum">9pt</xsl:attribute>
        
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__mini__label">
        <xsl:attribute name="keep-together.within-line">always</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-line">always</xsl:attribute>
        <xsl:attribute name="end-indent">label-end()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__mini__body">
        <xsl:attribute name="start-indent">body-start()</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- SF Bug 1815571: page-break-after must be on fo:table rather than fo:table-body
        in order to produce valid XSL-FO 1.1 output. -->
    <xsl:attribute-set name="__toc__mini__table">
        <xsl:attribute name="table-layout">fixed</xsl:attribute>
        <xsl:attribute name="width">100%</xsl:attribute>
        <xsl:attribute name="page-break-after">always</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__mini__table__body">
        <!-- SF Bug 1815571: moved page-break-after to __toc__mini__table -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__mini__table__column_1">
        <xsl:attribute name="column-number">1</xsl:attribute>
        <xsl:attribute name="column-width">35%</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__mini__table__column_2">
        <xsl:attribute name="column-number">2</xsl:attribute>
        <xsl:attribute name="column-width">65%</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__mini__summary">
        <xsl:attribute name="padding-left">10pt</xsl:attribute>
        <xsl:attribute name="border-left">solid 1pt #666666</xsl:attribute>
    </xsl:attribute-set>
    
    
    <xsl:attribute-set name="apiname">
        <xsl:attribute name="font-family">inherit</xsl:attribute><!-- not monospaced -->
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-size">inherit</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- P -->
    <xsl:attribute-set name="p">
        <xsl:attribute name="text-indent">0em</xsl:attribute>
        <xsl:attribute name="space-before">0.5em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">0.5em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0.5em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0.5em</xsl:attribute>
        <xsl:attribute name="space-after">0.5em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">0.5em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0.5em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0.5em</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="lines">
        <xsl:attribute name="font-size">inherit</xsl:attribute>
        <xsl:attribute name="space-before">0.5em</xsl:attribute>
        <xsl:attribute name="space-after">0.5em</xsl:attribute>
        <!--        <xsl:attribute name="white-space-treatment">ignore-if-after-linefeed</xsl:attribute>-->
        <xsl:attribute name="white-space-collapse">true</xsl:attribute>
        <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
        <xsl:attribute name="wrap-option">wrap</xsl:attribute>
    </xsl:attribute-set>
    
    
    <!-- XREFS -->
    <xsl:attribute-set name="xref">
        <xsl:attribute name="color">cmyk(1,1,0,0)</xsl:attribute> <!-- Try CMYK to solve Reader colormetric problem -->
        <xsl:attribute name="font-style">normal</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- LINKS -->
    <xsl:attribute-set name="link__content">
        <xsl:attribute name="color">cmyk(1,1,0,0)</xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="lq_link">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
        <xsl:attribute name="space-after">10pt</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">10pt</xsl:attribute>
        <xsl:attribute name="space-after.maximum">10pt</xsl:attribute>
        <xsl:attribute name="space-after.optimum">10pt</xsl:attribute>
        <xsl:attribute name="end-indent">92pt</xsl:attribute>
        <xsl:attribute name="text-align">right</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="color">cmyk(1,1,0,0)</xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- ORDERED LISTS -->
    <xsl:attribute-set name="ol">
        <xsl:attribute name="provisional-distance-between-starts">2.5em</xsl:attribute><!-- was 5mm -->
        <xsl:attribute name="provisional-label-separation">1mm</xsl:attribute>
        <xsl:attribute name="space-after">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
        <xsl:attribute name="space-before">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
        <!--		<xsl:attribute name="margin-left">-8pt</xsl:attribute>-->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ol.li">
        <xsl:attribute name="space-after">0.5em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">0.5em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0.5em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0.5em</xsl:attribute> <!-- changed -->
        <xsl:attribute name="space-before">0.5em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">0.5em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0.5em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0.5em</xsl:attribute><!-- changed -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ol.li__label">
        <xsl:attribute name="keep-together.within-line">always</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-line">always</xsl:attribute>
        <xsl:attribute name="end-indent">label-end()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ol.li__label__content">
        <xsl:attribute name="text-align">right</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
    </xsl:attribute-set>
    
    <!--Unordered list-->
    <xsl:attribute-set name="ul">
        <xsl:attribute name="provisional-distance-between-starts">2.5em</xsl:attribute>
        <xsl:attribute name="provisional-label-separation">2.8pt</xsl:attribute><!-- approx 1mm, the default -->
        <xsl:attribute name="space-after">0.5em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">0.5em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0.5em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0.5em</xsl:attribute>
        <xsl:attribute name="space-before">0.5em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">0.5em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0.5em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0.5em</xsl:attribute>
        <!--        <xsl:attribute name="margin-left">-8pt</xsl:attribute>-->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ul.li" use-attribute-sets="ol.li">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ul.li__label">
        <xsl:attribute name="keep-together.within-line">always</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-line">always</xsl:attribute>
        <xsl:attribute name="end-indent">label-end()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ul.li__label__content">
        <xsl:attribute name="text-align">right</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ul.li__body">
        <xsl:attribute name="start-indent">body-start()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ul.li__content">
    </xsl:attribute-set>
    
    
    <xsl:attribute-set name="fig">
        <xsl:attribute name="space-before">0.8em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0.8em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0.8em</xsl:attribute>
        <xsl:attribute name="space-after">0.8em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">0.8em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0.8em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0.8em</xsl:attribute>
        <!-- add leeway for figure to spill into right margin -->
        <xsl:attribute name="margin-right">-0.75in</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="image__float">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="image__block">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="image__inline">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="image">
    </xsl:attribute-set>
    
    
    
    
    
    <!-- REMOVE TOP-BOTTOM BORDERS -->
    <xsl:attribute-set name="__chapter__frontmatter__name__container">

        <xsl:attribute name="font-size">20pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="border-top-style">none</xsl:attribute>
        <xsl:attribute name="border-bottom-style">none</xsl:attribute>
        <xsl:attribute name="border-top-width">0pt</xsl:attribute>
        <xsl:attribute name="border-bottom-width">0pt</xsl:attribute>
        <xsl:attribute name="padding-top">0pt</xsl:attribute>
        <xsl:attribute name="padding-bottom">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- ADD CHAPTER NUMBER ROUNDED RED SQUARE -->
    <xsl:attribute-set name="__chapter__frontmatter__number__container">
        <xsl:attribute name="background-image">url(Customization/OpenTopic/common/artwork/chapter_number_box.svg)</xsl:attribute>
        <xsl:attribute name="background-repeat">no-repeat</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="padding-top">11pt</xsl:attribute>
        <xsl:attribute name="font-family">Sans</xsl:attribute>
        <xsl:attribute name="color">White</xsl:attribute>
        <xsl:attribute name="font-size">48pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="height">1in</xsl:attribute>
        <xsl:attribute name="width">1in</xsl:attribute>
        <xsl:attribute name="margin-bottom">43pt</xsl:attribute><!-- 
            per John 6/12/11: 6pc to baseline of chapter title
            Cannot specify measurement to baseline, so adjusted here. -->
    </xsl:attribute-set>
    
    <!-- MAKE UICONTROL TEXT SANS, WITH ADDITIONAL FORMATTING FOR @outputclass="keyboard" -->
    <xsl:attribute-set name="uicontrol">
        <xsl:attribute name="font-family">Sans</xsl:attribute>
        <xsl:attribute name="line-height">100%</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-weight">
            <xsl:choose>
                <xsl:when test="@outputclass='keyboard'">normal</xsl:when>
                <xsl:otherwise>bold</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="text-transform">
            <xsl:choose>
                <xsl:when test="@outputclass='keyboard'">uppercase</xsl:when>
                <xsl:otherwise>none</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:attribute-set>
    
    <!-- MAKE TERM BOLD, NOT ITALIC -->
    <xsl:attribute-set name="term">
        <xsl:attribute name="border-left-width">0pt</xsl:attribute>
        <xsl:attribute name="border-right-width">0pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
    </xsl:attribute-set>
    
    
    <!-- DON'T BOLD WINDOW TITLES -->
    <xsl:attribute-set name="wintitle">
        <xsl:attribute name="font-weight">inherit</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- FORMAT <codeblock> -->
    <xsl:attribute-set name="codeblock">
        <!-- Fix formatting (1/19/2012): OT specified 6pt for these -->
        <xsl:attribute name="padding">0pt</xsl:attribute>
        <xsl:attribute name="start-indent">0pt + from-parent(start-indent)</xsl:attribute>
        <xsl:attribute name="end-indent">0pt + from-parent(start-indent)</xsl:attribute>
        
        <xsl:attribute name="space-before">0.4em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">0.4em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0.4em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0.4em</xsl:attribute>
        <xsl:attribute name="space-after">0.8em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">0.8em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0.8em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0.8em</xsl:attribute>
        <xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
        <xsl:attribute name="white-space-collapse">false</xsl:attribute>
        <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
        <xsl:attribute name="wrap-option">wrap</xsl:attribute>
        <xsl:attribute name="background-color">transparent</xsl:attribute>
        <xsl:attribute name="font-family">Monospaced</xsl:attribute>
        <xsl:attribute name="line-height">106%</xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
        <xsl:attribute name="keep-with-previous.within-page">auto</xsl:attribute><!-- Tried changing to fix table problem with no success -->
        <!--        &lt;xsl:attribute name=&quot;keep-together.within-page&quot;&gt;always&lt;/xsl:attribute&gt;-->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="codeblock__top">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="codeblock__bottom">
    </xsl:attribute-set>
    
    <!-- Don't make codeph smaller in titles -->
    <xsl:attribute-set name="codeph">
        <xsl:attribute name="font-family">Monospaced</xsl:attribute>
        <xsl:attribute name="font-size">inherit<!--<xsl:value-of select="$default-font-size"/>--></xsl:attribute>
    </xsl:attribute-set>
    
    
    <!-- Add bolding to userinput -->
    <xsl:attribute-set name="userinput">
        <xsl:attribute name="font-family">Monospaced</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
    </xsl:attribute-set>
    
    <!-- Remove monospace, don't make smaller in titles, shade background -->
    <xsl:attribute-set name="msgph">
        <xsl:attribute name="font-family">inherit</xsl:attribute>
        <xsl:attribute name="font-size">inherit<!--<xsl:value-of select="$default-font-size"/>--></xsl:attribute>
        <xsl:attribute name="background-color">#eee</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- Border, background for msgblock -->
    <xsl:attribute-set name="msgblock">
        <xsl:attribute name="border">0.5pt solid #c0c0c0</xsl:attribute>
        <xsl:attribute name="background-color">#eee</xsl:attribute>
        <xsl:attribute name="padding">3pt</xsl:attribute>
        <xsl:attribute name="space-before">1em</xsl:attribute>
        <xsl:attribute name="space-after">1em</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- No changes made to msgnum -->
    <xsl:attribute-set name="msgnum">
    </xsl:attribute-set>
    
    <!-- No changes made to systemoutput -->
    <xsl:attribute-set name="systemoutput">
        <xsl:attribute name="font-family">Monospaced</xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
    </xsl:attribute-set>
    
    
    <!-- STEPS -->
    
    
    <!--Unordered steps-->
    <xsl:attribute-set name="steps-unordered">
        <xsl:attribute name="provisional-distance-between-starts">5mm</xsl:attribute>
        <xsl:attribute name="provisional-label-separation">1mm</xsl:attribute>
        <xsl:attribute name="space-after">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
        <xsl:attribute name="space-before">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="steps-unordered.step" use-attribute-sets="ol.li">
        <xsl:attribute name="space-after">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
        <xsl:attribute name="space-before">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="steps-unordered.step__label">
        <xsl:attribute name="keep-together.within-line">always</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-line">always</xsl:attribute>
        <xsl:attribute name="end-indent">label-end()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="steps-unordered.step__label__content">
        <xsl:attribute name="text-align">right</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="steps-unordered.step__body">
        <xsl:attribute name="start-indent">body-start()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="steps-unordered.step__content">
    </xsl:attribute-set>
    
    <!--Ordered steps-->
    
    <xsl:attribute-set name="steps">
        <xsl:attribute name="provisional-distance-between-starts">2em</xsl:attribute>
        <xsl:attribute name="provisional-label-separation">1mm</xsl:attribute>
        <xsl:attribute name="space-after">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
        <xsl:attribute name="space-before">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="steps.step" use-attribute-sets="ol.li">
    <xsl:attribute name="space-after">1em</xsl:attribute>
<!-- explicit specification -->
    <xsl:attribute name="space-after.minimum">1em</xsl:attribute>
    <xsl:attribute name="space-after.maximum">1em</xsl:attribute>
    <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
    <xsl:attribute name="space-before">1em</xsl:attribute>
<!-- explicit specification -->
    <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1em</xsl:attribute>
    <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
    </xsl:attribute-set>
    
    
    <xsl:attribute-set name="steps.step__label">
        <xsl:attribute name="keep-together.within-line">always</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-line">always</xsl:attribute>
        <xsl:attribute name="end-indent">label-end()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="steps.step__label__content">
        <xsl:attribute name="text-align">right</xsl:attribute> <!-- changed -->
        <xsl:attribute name="font-weight">normal</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="steps.step__body">
        <xsl:attribute name="start-indent">body-start()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="steps.step__content">
    </xsl:attribute-set>
    
    
    <!-- Stepsection (new in DITA 1.2) -->
    
    <xsl:attribute-set name="stepsection">
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="start-indent"><xsl:value-of select="$side-col-width"/></xsl:attribute>
        <xsl:attribute name="space-after">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
        <xsl:attribute name="space-before">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="stepsection__label">
        <xsl:attribute name="keep-together.within-line">always</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-line">always</xsl:attribute>
        <xsl:attribute name="end-indent">label-end()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="stepsection__label__content">
        <xsl:attribute name="text-align">left</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="stepsection__body">
        <xsl:attribute name="start-indent">body-start()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="stepsection__content">
    </xsl:attribute-set>
    
    <!--Substeps-->
    <xsl:attribute-set name="substeps">
        <xsl:attribute name="provisional-distance-between-starts">5mm</xsl:attribute>
        <xsl:attribute name="provisional-label-separation">1mm</xsl:attribute>
        <xsl:attribute name="space-after">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
        <xsl:attribute name="space-before">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="substeps.substep" use-attribute-sets="ol.li">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="substeps.substep__label">
        <xsl:attribute name="keep-together.within-line">always</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-line">always</xsl:attribute>
        <xsl:attribute name="end-indent">label-end()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="substeps.substep__label__content">
        <xsl:attribute name="text-align">right</xsl:attribute> <!-- changed -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="substeps.substep__body">
        <xsl:attribute name="start-indent">body-start()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="substeps.substep__content">
    </xsl:attribute-set>
    
    <!--Choices-->
    <xsl:attribute-set name="choices">
        <xsl:attribute name="provisional-distance-between-starts">5mm</xsl:attribute>
        <xsl:attribute name="provisional-label-separation">1mm</xsl:attribute>
        <xsl:attribute name="space-after">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
        <xsl:attribute name="space-before">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
        <!--        <xsl:attribute name="margin-left">-8pt</xsl:attribute>-->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="choices.choice" use-attribute-sets="ol.li">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="choices.choice__label">
        <xsl:attribute name="keep-together.within-line">always</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-line">always</xsl:attribute>
        <xsl:attribute name="end-indent">label-end()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="choices.choice__label__content">
        <xsl:attribute name="text-align">right</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="choices.choice__body">
        <xsl:attribute name="start-indent">body-start()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="choices.choice__content">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="cmd">
        <xsl:attribute name="keep-together.within-page">20</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="info">
        <xsl:attribute name="space-before">0.5em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">0.5em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0.5em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0.5em</xsl:attribute>
        <xsl:attribute name="space-after">0.5em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">0.5em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0.5em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0.5em</xsl:attribute>
    </xsl:attribute-set>
    
    
    
    
    
    
    
    <!-- DEFINITION LISTS -->
    <xsl:attribute-set name="dl">
        <xsl:attribute name="width">100%</xsl:attribute>
        <xsl:attribute name="space-before">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
        <xsl:attribute name="space-after">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
        <xsl:attribute name="margin-left"><xsl:value-of select="$side-col-width"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="dl__body">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="dl.dlhead">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="dlentry">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="dlentry.dt">
        <xsl:attribute name="relative-align">baseline</xsl:attribute>
        <xsl:attribute name="keep-with-next">always</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="dlentry.dt__content">
        <xsl:attribute name="margin">3pt 12pt</xsl:attribute>
        <xsl:attribute name="start-indent"><xsl:value-of select="$side-col-width"/></xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="dlentry.dd">
        
    </xsl:attribute-set>
    
    <xsl:attribute-set name="dlentry.dd__content">
        <xsl:attribute name="margin">3pt 12pt</xsl:attribute>
        <xsl:attribute name="start-indent"><xsl:value-of select="$side-col-width"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="dl.dlhead__row">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="dlhead.dthd__cell">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="dlhead.dthd__content">
        <xsl:attribute name="margin">3pt 0pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="dlhead.ddhd__cell">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="dlhead.ddhd__content">
        <xsl:attribute name="margin">3pt 12pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    
    <!-- TABLE -->
    <xsl:attribute-set name="__tableframe__top">
        <xsl:attribute name="border-top-style">solid</xsl:attribute>
        <xsl:attribute name="border-top-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-top-color">cmyk(0.341,0.137,0,0)</xsl:attribute><!-- RGB: #A5D8FF -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__tableframe__bottom">
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-bottom-color">cmyk(0.341,0.137,0,0)</xsl:attribute><!-- RGB: #A5D8FF -->
        <xsl:attribute name="border-after-width.conditionality">retain</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="thead__tableframe__bottom">
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">2pt</xsl:attribute>
        <xsl:attribute name="border-bottom-color">cmyk(0.341,0.137,0,0)</xsl:attribute><!-- RGB: #A5D8FF -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__tableframe__left">
        <xsl:attribute name="border-left-style">solid</xsl:attribute>
        <xsl:attribute name="border-left-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-left-color">cmyk(0.341,0.137,0,0)</xsl:attribute><!-- RGB: #A5D8FF -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__tableframe__right">
        <xsl:attribute name="border-right-style">solid</xsl:attribute>
        <xsl:attribute name="border-right-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-right-color">cmyk(0.341,0.137,0,0)</xsl:attribute><!-- RGB: #A5D8FF -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="table">
        <!--It is a table container -->
        <xsl:attribute name="font-size"><xsl:value-of select="$table-font-size"/></xsl:attribute>
        <xsl:attribute name="space-after">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
        <xsl:attribute name="space-before">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="table.tgroup">
        <!--It is a table-->
        <xsl:attribute name="table-layout">fixed</xsl:attribute>
        <xsl:attribute name="width">100%</xsl:attribute>
        <!--xsl:attribute name=&quot;inline-progression-dimension&quot;&gt;auto&lt;/xsl:attribute-->
        <!--        &lt;xsl:attribute name=&quot;background-color&quot;&gt;white&lt;/xsl:attribute&gt;-->
        <xsl:attribute name="space-before.optimum">5pt</xsl:attribute>
        <xsl:attribute name="space-after.optimum">5pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="table__tableframe__all">
        <xsl:attribute name="border-top-style">solid</xsl:attribute>
        <xsl:attribute name="border-top-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-top-color">cmyk(0.341,0.137,0,0)</xsl:attribute><!-- RGB: #A5D8FF -->
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-bottom-color">cmyk(0.341,0.137,0,0)</xsl:attribute><!-- RGB: #A5D8FF -->
        <xsl:attribute name="border-left-style">solid</xsl:attribute>
        <xsl:attribute name="border-left-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-left-color">cmyk(0.341,0.137,0,0)</xsl:attribute><!-- RGB: #A5D8FF -->
        <xsl:attribute name="border-right-style">solid</xsl:attribute>
        <xsl:attribute name="border-right-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-right-color">cmyk(0.341,0.137,0,0)</xsl:attribute><!-- RGB: #A5D8FF -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="table__tableframe__topbot">
        <xsl:attribute name="border-top-style">solid</xsl:attribute>
        <xsl:attribute name="border-top-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-top-color">cmyk(0.341,0.137,0,0)</xsl:attribute><!-- RGB: #A5D8FF -->
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-bottom-color">cmyk(0.341,0.137,0,0)</xsl:attribute><!-- RGB: #A5D8FF -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="table__tableframe__top">
        <xsl:attribute name="border-top-style">solid</xsl:attribute>
        <xsl:attribute name="border-top-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-top-color">cmyk(0.341,0.137,0,0)</xsl:attribute><!-- RGB: #A5D8FF -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="table__tableframe__bottom">
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-bottom-color">cmyk(0.341,0.137,0,0)</xsl:attribute><!-- RGB: #A5D8FF -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="table__tableframe__sides">
        <xsl:attribute name="border-left-style">solid</xsl:attribute>
        <xsl:attribute name="border-left-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-left-color">cmyk(0.341,0.137,0,0)</xsl:attribute><!-- RGB: #A5D8FF -->
        <xsl:attribute name="border-right-style">solid</xsl:attribute>
        <xsl:attribute name="border-right-width">0.5pt</xsl:attribute>
        <xsl:attribute name="border-right-color">cmyk(0.341,0.137,0,0)</xsl:attribute><!-- RGB: #A5D8FF -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="thead.row.entry">
        <!--head cell-->
        <xsl:attribute name="background-color">cmyk(0.075,0.027,0,0)</xsl:attribute><!-- RGB: #EAF7FF -->
        <xsl:attribute name="margin-left">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="thead.row.entry__content">
        <!--head cell contents-->
        <xsl:attribute name="margin">3pt 3pt 3pt 3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="tbody.row.entry">
        <!--body cell-->
        <xsl:attribute name="margin-left">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="tbody.row.entry__content">
        <!--body cell contents-->
        <xsl:attribute name="margin">3pt 3pt 3pt 3pt</xsl:attribute>
    </xsl:attribute-set>
    
    
    <!-- KEYCOL FORMATTING -->
    <xsl:attribute-set name="keycol">
        <xsl:attribute name="background-color">cmyk(0.075,0.027,0,0)</xsl:attribute><!-- RGB: #EAF7FF -->
    </xsl:attribute-set>
    
    
    <!-- SIMPLETABLE -->
    <xsl:attribute-set name="simpletable">
        <xsl:attribute name="width">100%</xsl:attribute>
        <xsl:attribute name="table-layout">fixed</xsl:attribute><!-- since auto not supported by FOP -->
        <xsl:attribute name="font-size"><xsl:value-of select="$table-font-size"/></xsl:attribute>
        <xsl:attribute name="space-before">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
        <xsl:attribute name="space-after">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="simpletable__body">
        
    </xsl:attribute-set>
    
    <xsl:attribute-set name="sthead">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="sthead__row">
        <xsl:attribute name="background-color">cmyk(0.075,0.027,0,0)</xsl:attribute><!-- RGB: #EAF7FF -->
        <xsl:attribute name="keep-together.within-column">always</xsl:attribute><!-- KEEP ROW FROM BREAKING -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="strow">
        <xsl:attribute name="keep-together.within-column">always</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="sthead.stentry">
        <xsl:attribute name="margin-left">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="sthead.stentry__content">
        <xsl:attribute name="margin">3pt 3pt 3pt 3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="sthead.stentry__keycol-content">
        <xsl:attribute name="margin">3pt 3pt 3pt 3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="background-color">cmyk(0.075,0.027,0,0)</xsl:attribute><!-- RGB: #EAF7FF -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="strow.stentry__content">
        <xsl:attribute name="margin">3pt 3pt 3pt 3pt</xsl:attribute>
        <!-- <xsl:attribute name="space-before">0pt</xsl:attribute> -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="strow.stentry__keycol-content">
        <xsl:attribute name="margin">3pt 3pt 3pt 3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="background-color">transparent</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="strow.stentry">
        <xsl:attribute name="margin-left">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    
    <!-- PROPERTIES -->
    <xsl:attribute-set name="properties">
        <!--It is a table container -->
        <xsl:attribute name="font-size"><xsl:value-of select="$table-font-size"/></xsl:attribute>
        <xsl:attribute name="width">100%</xsl:attribute>
        <xsl:attribute name="table-layout">fixed</xsl:attribute><!-- since auto not supported by FOP -->
        <xsl:attribute name="space-before">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
        <xsl:attribute name="space-after">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="properties__body">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="property">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="property.entry">
        <xsl:attribute name="margin-left">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="property.entry__keycol-content">
        <xsl:attribute name="margin">3pt 3pt 3pt 3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="background-color">cmyk(0.075,0.027,0,0)</xsl:attribute><!-- RGB: #EAF7FF -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="property.entry__content">
        <xsl:attribute name="margin">3pt 3pt 3pt 3pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="prophead">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="prophead__row">
        <xsl:attribute name="background-color">cmyk(0.075,0.027,0,0)</xsl:attribute><!-- RGB: #EAF7FF -->
        <xsl:attribute name="keep-together.within-column">always</xsl:attribute><!-- KEEP ROW FROM BREAKING -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="prophead.entry">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="prophead.entry__keycol-content">
        <xsl:attribute name="margin">3pt 3pt 3pt 3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="background-color">cmyk(0.075,0.027,0,0)</xsl:attribute><!-- RGB: #EAF7FF -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="prophead.entry__content">
        <xsl:attribute name="margin">3pt 3pt 3pt 3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- CHOICETABLE -->
    <xsl:attribute-set name="choicetable" use-attribute-sets="table__tableframe__all">
        <!--It is a table container -->
        <xsl:attribute name="table-layout">fixed</xsl:attribute><!-- since auto not supported by FOP -->
        <xsl:attribute name="width">100%</xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$table-font-size"/></xsl:attribute>
        <xsl:attribute name="space-after">1em<!-- was 0.6em --></xsl:attribute>
        <xsl:attribute name="space-before">1em<!-- was 0.6em --></xsl:attribute>
        
    </xsl:attribute-set>
    
    <xsl:attribute-set name="choicetable__body">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chhead">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chhead__row">
        <xsl:attribute name="background-color">cmyk(0.075,0.027,0,0)</xsl:attribute><!-- RGB: #EAF7FF -->
        <xsl:attribute name="keep-together.within-column">always</xsl:attribute><!-- KEEP ROW FROM BREAKING -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chrow">
        <xsl:attribute name="keep-together.within-column">always</xsl:attribute><!-- KEEP ROW FROM BREAKING -->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chhead.choptionhd" use-attribute-sets="table__tableframe__all">
        <xsl:attribute name="margin-left">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chhead.choptionhd__content">
        <xsl:attribute name="margin">3pt 3pt 3pt 3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chhead.chdeschd" use-attribute-sets="table__tableframe__all">
        <xsl:attribute name="margin-left">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chhead.chdeschd__content">
        <xsl:attribute name="margin">3pt 3pt 3pt 3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chrow.choption" use-attribute-sets="table__tableframe__all">
        <xsl:attribute name="margin-left">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chrow.choption__keycol-content">
        <xsl:attribute name="margin">3pt 3pt 3pt 3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chrow.choption__content">
        <xsl:attribute name="margin">3pt 3pt 3pt 3pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chrow.chdesc" use-attribute-sets="table__tableframe__all">
        <xsl:attribute name="margin-left">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chrow.chdesc__keycol-content">
        <xsl:attribute name="margin">3pt 3pt 3pt 3pt</xsl:attribute>
        <xsl:attribute name="font-weight"></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chrow.chdesc__content">
        <xsl:attribute name="margin">3pt 3pt 3pt 3pt</xsl:attribute>
    </xsl:attribute-set>
    
    
    
    <!-- NOTE TABLES -->
    <xsl:attribute-set name="note__table">
        <xsl:attribute name="space-before">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
        <xsl:attribute name="space-after">1em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-after.minimum">1em</xsl:attribute>
        <xsl:attribute name="space-after.maximum">1em</xsl:attribute>
        <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
        <xsl:attribute name="table-layout">fixed</xsl:attribute><!-- since auto not supported by FOP -->
        <xsl:attribute name="width">100%-12pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__image__entry">
        <xsl:attribute name="padding-right">2pt</xsl:attribute>
        <xsl:attribute name="start-indent">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    
    
    
    <!-- REMOVE BORDER FROM EXAMPLE SECTIONS -->
    <xsl:attribute-set name="example">
        <xsl:attribute name="line-height">12pt</xsl:attribute>
        <xsl:attribute name="space-before">1.2em</xsl:attribute>
<!-- explicit specification -->
        <xsl:attribute name="space-before.minimum">1.2em</xsl:attribute>
        <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
        <xsl:attribute name="space-before.optimum">1.2em</xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
        <xsl:attribute name="margin-left">0pt</xsl:attribute>
        <xsl:attribute name="margin-right">0in</xsl:attribute>
        <xsl:attribute name="border-top-style">none</xsl:attribute>
        <xsl:attribute name="border-bottom-style">none</xsl:attribute>
        <xsl:attribute name="border-left-style">none</xsl:attribute>
        <xsl:attribute name="border-right-style">none</xsl:attribute>
        <xsl:attribute name="padding">0pt</xsl:attribute>
    </xsl:attribute-set>


    <xsl:attribute-set name="draft-comment">
        <xsl:attribute name="background-color">Orange</xsl:attribute>
        <xsl:attribute name="color">Black</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-color">OrangeRed</xsl:attribute>
        <xsl:attribute name="border-width">3pt</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- 
    <xsl:attribute-set name="ph">
        <xsl:attribute name="border-left-width">0pt</xsl:attribute>
        <xsl:attribute name="border-right-width">0pt</xsl:attribute>
        <xsl:attribute name="font-family">
            <xsl:choose>
                <xsl:when test="@outputclass">
                    <xsl:value-of select="@outputclass"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="auto"/>
                </xsl:otherwise>
        </xsl:choose>
            
            <xsl:value-of select="@outputclass"/>
        </xsl:attribute>        
    </xsl:attribute-set>
     -->
    
</xsl:stylesheet>