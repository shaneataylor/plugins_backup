<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xhtml xsl xs">
    
    <xsl:import href="plugin:org.dita.base:xsl/common/output-message.xsl"></xsl:import>
    <xsl:param name="msgprefix">DOTX</xsl:param>
    
    <xsl:output method="xhtml" encoding="UTF-8" indent="no" omit-xml-declaration="yes"/>

    <xsl:attribute-set name="htmlattrs">
        <xsl:attribute name="lang">en-us</xsl:attribute>
        <xsl:attribute name="xml:lang">en-us</xsl:attribute>
        <xsl:attribute name="class">no-js</xsl:attribute>
    </xsl:attribute-set>

    <xsl:template match="xhtml:html">
        <xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> ]]></xsl:text><xsl:element name="html" use-attribute-sets="htmlattrs">
            <xsl:text disable-output-escaping="yes"><![CDATA[<!--<![endif]-->]]></xsl:text>
            <xsl:apply-templates/>
        </xsl:element>
        
    </xsl:template>

    <!-- identity template to copy existing nodes/attributes/etc -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    
    
    <xsl:template match="xhtml:head" xml:space="preserve">
        <head>
            <meta charset="utf-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no"/>
            <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
            <xsl:apply-templates/>
            <link rel="stylesheet" href="h5help/css/help_app.css"/>
        </head>
    </xsl:template>
    
    <xsl:template match="xhtml:body" xml:space="preserve">
        <xsl:variable name="bodyid"><xsl:value-of select="@id"></xsl:value-of></xsl:variable>
        <body>
        <xsl:text disable-output-escaping="yes"><![CDATA[
            <!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
            <![endif]-->
            ]]></xsl:text>
        <xsl:comment>googleoff: all</xsl:comment><!-- don't index until we get to the topic itself -->
        <div id="toolbar">
            <!-- Skipahead link. See http://webaim.org/presentations/2012/ariahtml5/hiddenlinks2 -->
             <a href="#topic" class="hidden508nav">Skip to start of help topic</a>
            <div id="brand-logo"></div>
            <div id="searchbox" role="search" aria-label="search"><xsl:comment></xsl:comment></div>
        </div>
        <div>
            <!-- menu stuff needs to be outside of toolbar div so clicks on toolbar close the menu -->
            <img src="h5help/img/utility_icon.png" alt="Menu" title="Menu" id="menu_button" tabindex="1"/>
            <ul class="menu hidden" role="menu" id="menu">
                <li role="menuitem" id="view_contents" class="hidden"><a>View Contents</a></li>
                <li role="menuitem" id="view_topic" class="hidden"><a>View Topic</a></li>
                <li role="menuitem" id="view_min" class="hidden"><a>Minimal View</a></li>
                <li role="menuitem" id="view_max" class="hidden"><a>Expanded View</a></li>
                <li role="menuitem" id="print_topic"><a alt="Print help topic" title="Print help topic">Print</a></li>
                <li role="menuitem" id="customer_support"><a target="_blank" href="http://webassign.force.com/wakb2/?cu=1&amp;fs=ContactUs&amp;l=en_US" alt="Contact WebAssign Customer Support" title="Contact WebAssign Customer Support">Customer Support</a></li>
                <li role="menuitem" id="topic_feedback"><a>Topic Feedback</a></li>
                <li role="menuitem" id="about_help" class="hidden"><a>About Help</a></li>
            </ul>        
        </div>
        <div id="modal_back" class="hidden"><xsl:comment></xsl:comment></div>
        <div id="modal" class="modal hidden" role="alert"><xsl:comment></xsl:comment></div>
        <div id="toc" title="Table of contents" role="navigation"><xsl:comment></xsl:comment></div>
        <div id="sizer" class="slideright" alt="Show or hide the contents" title="Show or hide the contents"><xsl:comment></xsl:comment></div>
            <xsl:comment>googleon: all</xsl:comment>
            <xsl:call-template name="bodydiv">
                <xsl:with-param name="topicid"><xsl:value-of select="$bodyid"></xsl:value-of></xsl:with-param>
            </xsl:call-template>
            <xsl:comment>googleoff: all</xsl:comment>
        <div id="searchresults" title="Search results" role="search"><xsl:comment></xsl:comment></div>
        <script data-main="h5help/js/main" type="text/javascript" src="h5help/js/vendor/require.js"><xsl:comment></xsl:comment></script>
        <xsl:comment>googleon: all</xsl:comment>
        </body>
    </xsl:template>
    
    <xsl:template name="bodydiv">
        <xsl:param name="topicid"/>
        <!-- doesn't change context -->
        <div id="topic" role="main">
            <div>
                <xsl:attribute name="id" select="$topicid"></xsl:attribute>
                <xsl:apply-templates/>
            </div>
            <xsl:call-template name="copyright_footer"/>
        </div>
    </xsl:template>
    
    
    
    <xsl:template match="*/@clear|*/@xmlns">
        <!-- don't copy these -->
    </xsl:template>
    
    <xsl:template name="copyright_footer">
        <xsl:variable name="moddate"><xsl:value-of select="//xhtml:meta[@name='DC.Date.Modified']/@content"/></xsl:variable>
        <xsl:variable name="ownermeta"><xsl:value-of select="//xhtml:meta[@name='DC.Creator']/@content"/>
            <!-- if needed, also select value of meta[@name='DC.Rights.Owner'] --></xsl:variable>
        <xsl:choose>
            <xsl:when test="matches($moddate,'\d\d\d\d-\d\d-\d\d') and $ownermeta != ''">
                <xsl:variable name="cyear"><xsl:value-of select="format-date($moddate,'© [Y] ')"></xsl:value-of></xsl:variable>
                <xsl:variable name="revdate"><xsl:value-of select="format-date($moddate,' (revised [MNn] [Y])')"></xsl:value-of></xsl:variable>
                <div class="copyright" role="contentinfo">
                    <xsl:value-of select="$cyear"/><xsl:value-of select="$ownermeta"/><xsl:value-of select="$revdate"/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="output-message">
                    <xsl:with-param name="msgnum">097</xsl:with-param>
                    <xsl:with-param name="msgsev">W</xsl:with-param>
                    <xsl:with-param name="msgparams">%1=<xsl:value-of select="base-uri()"/>;%2=<xsl:value-of select="$ownermeta"/>;%3=<xsl:value-of select="$moddate"/></xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    
    
</xsl:stylesheet>
