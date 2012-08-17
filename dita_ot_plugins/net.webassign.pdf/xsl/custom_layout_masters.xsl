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
    
    
    

    <!-- OVERRIDE DEFAULT LAYOUT MASTERS -->
    <xsl:template name="createLayoutMasters">
                <xsl:call-template name="createDefaultLayoutMasters"/>
    </xsl:template>

    <xsl:template name="createDefaultLayoutMasters">
        <fo:layout-master-set>

            <fo:simple-page-master master-name="front-matter-first"
                page-width="{$page-width}"
                page-height="{$page-height}">
                
                    <fo:region-body>
                        <!-- Test for frontmatter with outputclass specifying cover art -->
                        <xsl:if test="//*[contains(@class, ' bookmap/frontmatter ') and contains(@outputclass, 'cover=')]">
                            <xsl:variable name="CoverArtFile">
                                <xsl:value-of select="substring-after(//*[contains(@class, ' bookmap/frontmatter ')][1]/@outputclass, 'cover=')"/>
                            </xsl:variable>
                            
                            <xsl:message>===========  CoverArtFile = <xsl:value-of select="$CoverArtFile"/>  ===========</xsl:message>
                            
                            <xsl:attribute name="background-image">
                                <xsl:value-of select="concat('url(',$artworkPrefix, 'Customization/OpenTopic/common/artwork/', $CoverArtFile,')')"/>
                            </xsl:attribute>
                            <xsl:attribute name="background-repeat">no-repeat</xsl:attribute>
                            
                        </xsl:if>
                        <xsl:attribute name="margin-top">0in</xsl:attribute>
                        <xsl:attribute name="margin-bottom">0in</xsl:attribute>
                        <xsl:attribute name="margin-left">0in</xsl:attribute>
                        <xsl:attribute name="margin-right">0in</xsl:attribute>
                    </fo:region-body>
                
                
            </fo:simple-page-master>

            <fo:simple-page-master master-name="front-matter-last"
                page-width="{$page-width}"
                page-height="{$page-height}">
                <fo:region-body margin-top="{$page-margin-top}"
                    margin-bottom="{$page-margin-bottom}"
                    margin-left="{$page-margin-left}"
                    margin-right="{$page-margin-right}"/>
                <fo:region-before extent="{$page-margin-top}"
                    display-align="before"
                    region-name="last-frontmatter-header"/>
                <fo:region-after extent="{$page-margin-bottom}"
                    display-align="after"
                    region-name="last-frontmatter-footer"/>
            </fo:simple-page-master>

            <fo:simple-page-master master-name="front-matter-even"
                page-width="{$page-width}"
                page-height="{$page-height}">
                <fo:region-body margin-top="{$page-margin-top}"
                    margin-bottom="{$page-margin-bottom}"
                    margin-left="{$page-margin-left}"
                    margin-right="{$page-margin-right}"/>
                <fo:region-before extent="{$page-margin-top}"
                    display-align="before"
                    region-name="even-frontmatter-header"/>
                <fo:region-after extent="{$page-margin-bottom}"
                    display-align="after"
                    region-name="even-frontmatter-footer"/>
            </fo:simple-page-master>

            <fo:simple-page-master master-name="front-matter-odd"
                page-width="{$page-width}"
                page-height="{$page-height}">
                <fo:region-body margin-top="{$page-margin-top}"
                    margin-bottom="{$page-margin-bottom}"
                    margin-left="{$page-margin-left}"
                    margin-right="{$page-margin-right}"/>
                <fo:region-before extent="{$page-margin-top}"
                    display-align="before"
                    region-name="odd-frontmatter-header"/>
                <fo:region-after extent="{$page-margin-bottom}"
                    display-align="after"
                    region-name="odd-frontmatter-footer"/>
            </fo:simple-page-master>

            <!--TOC simple masters-->
            <fo:simple-page-master
                master-name="toc-even"
                page-width="{$page-width}"
                page-height="{$page-height}">
                <fo:region-body
                    margin-top="{$page-margin-top}"
                    margin-bottom="{$page-margin-bottom}"
                    margin-left="{$page-margin-left}"
                    margin-right="{$page-margin-right}"/>
                <fo:region-before extent="{$page-margin-top}"
                    display-align="before"
                    region-name="even-toc-header"/>
                <fo:region-after extent="{$page-margin-bottom}"
                    display-align="after"
                    region-name="even-toc-footer"/>
            </fo:simple-page-master>

            <fo:simple-page-master
                master-name="toc-odd"
                page-width="{$page-width}"
                page-height="{$page-height}">
                <fo:region-body
                    margin-top="{$page-margin-top}"
                    margin-bottom="{$page-margin-bottom}"
                    margin-left="{$page-margin-left}"
                    margin-right="{$page-margin-right}"/>
                <fo:region-before extent="{$page-margin-top}"
                    display-align="before"
                    region-name="odd-toc-header"/>
                <fo:region-after extent="{$page-margin-bottom}"
                    display-align="after"
                    region-name="odd-toc-footer"/>
            </fo:simple-page-master>

            <fo:simple-page-master
                master-name="toc-last"
                page-width="{$page-width}"
                page-height="{$page-height}">
                <fo:region-body
                    margin-top="{$page-margin-top}"
                    margin-bottom="{$page-margin-bottom}"
                    margin-left="{$page-margin-left}"
                    margin-right="{$page-margin-right}"/>
                <fo:region-before extent="{$page-margin-top}"
                    display-align="before"
                    region-name="even-toc-header"/>
                <fo:region-after extent="{$page-margin-bottom}"
                    display-align="after"
                    region-name="even-toc-footer"/>
            </fo:simple-page-master>

            <fo:simple-page-master
                master-name="toc-first"
                page-width="{$page-width}"
                page-height="{$page-height}">
                <fo:region-body
                    margin-top="{$page-margin-top}"
                    margin-bottom="{$page-margin-bottom}"
                    margin-left="{$page-margin-left}"
                    margin-right="{$page-margin-right}"/>
                <fo:region-before extent="{$page-margin-top}"
                    display-align="before"
                    region-name="odd-toc-header"/>
                <fo:region-after extent="{$page-margin-bottom}"
                    display-align="after"
                    region-name="odd-toc-footer"/>
            </fo:simple-page-master>


            <!--BODY simple masters-->
            <fo:simple-page-master
                master-name="body-first"
                page-width="{$page-width}"
                page-height="{$page-height}">
                <fo:region-body
                    margin-top="{$page-margin-top}"
                    margin-bottom="{$page-margin-bottom}"
                    margin-left="{$page-margin-left}"
                    margin-right="{$page-margin-right}"/>
                <fo:region-before extent="{$page-margin-top}"
                    display-align="before"
                    region-name="first-body-header"/>
                <fo:region-after extent="{$page-margin-bottom}"
                    display-align="after"
                    region-name="first-body-footer"/>
            </fo:simple-page-master>

            <fo:simple-page-master
                master-name="body-even"
                page-width="{$page-width}"
                page-height="{$page-height}">
                <fo:region-body
                    margin-top="{$page-margin-top}"
                    margin-bottom="{$page-margin-bottom}"
                    margin-left="{$page-margin-left}"
                    margin-right="{$page-margin-right}"/>
                <fo:region-before extent="{$page-margin-top}"
                    display-align="before"
                    region-name="even-body-header"/>
                <fo:region-after extent="{$page-margin-bottom}"
                    display-align="after"
                    region-name="even-body-footer"/>
            </fo:simple-page-master>

            <fo:simple-page-master
                master-name="body-odd"
                page-width="{$page-width}"
                page-height="{$page-height}">
                <fo:region-body
                    margin-top="{$page-margin-top}"
                    margin-bottom="{$page-margin-bottom}"
                    margin-left="{$page-margin-left}"
                    margin-right="{$page-margin-right}"/>
                <fo:region-before extent="{$page-margin-top}"
                    display-align="before"
                    region-name="odd-body-header"/>
                <fo:region-after extent="{$page-margin-bottom}"
                    display-align="after"
                    region-name="odd-body-footer"/>
            </fo:simple-page-master>

            <fo:simple-page-master
                master-name="body-last"
                page-width="{$page-width}"
                page-height="{$page-height}">
                <fo:region-body
                    margin-top="{$page-margin-top}"
                    margin-bottom="{$page-margin-bottom}"
                    margin-left="{$page-margin-left}"
                    margin-right="{$page-margin-right}"/>
                <fo:region-before extent="{$page-margin-top}"
                    display-align="before"
                    region-name="last-body-header"/>
                <fo:region-after extent="{$page-margin-bottom}"
                    display-align="after"
                    region-name="last-body-footer"/>
            </fo:simple-page-master>
            
            
            
            
            <!--NOTICES simple masters-->
            <fo:simple-page-master
                master-name="notices-first"
                page-width="{$page-width}"
                page-height="{$page-height}">
                <fo:region-body
                    margin-top="{$notices-margin-top}"
                    margin-bottom="{$notices-margin-bottom}"
                    margin-left="{$notices-margin-left}"
                    margin-right="{$notices-margin-right}"
                    column-count="2" 
                    column-gap="{$notices-column-gap}"/>
                <fo:region-before extent="{$notices-margin-top}"
                    display-align="before"
                    region-name="first-body-header"/>
                <fo:region-after extent="{$notices-margin-bottom}"
                    display-align="after"
                    region-name="first-body-footer"/>
            </fo:simple-page-master>

            <fo:simple-page-master
                master-name="notices-even"
                page-width="{$page-width}"
                page-height="{$page-height}">
                <fo:region-body
                    margin-top="{$notices-margin-top}"
                    margin-bottom="{$notices-margin-bottom}"
                    margin-left="{$notices-margin-left}"
                    margin-right="{$notices-margin-right}"
                    column-count="2" 
                    column-gap="{$notices-column-gap}"/>
                <fo:region-before extent="{$notices-margin-top}"
                    display-align="before"
                    region-name="even-body-header"/>
                <fo:region-after extent="{$notices-margin-bottom}"
                    display-align="after"
                    region-name="even-body-footer"/>
            </fo:simple-page-master>

            <fo:simple-page-master
                master-name="notices-odd"
                page-width="{$page-width}"
                page-height="{$page-height}">
                <fo:region-body
                    margin-top="{$notices-margin-top}"
                    margin-bottom="{$notices-margin-bottom}"
                    margin-left="{$notices-margin-left}"
                    margin-right="{$notices-margin-right}"
                    column-count="2" 
                    column-gap="{$notices-column-gap}"/>
                <fo:region-before extent="{$notices-margin-top}"
                    display-align="before"
                    region-name="odd-body-header"/>
                <fo:region-after extent="{$notices-margin-bottom}"
                    display-align="after"
                    region-name="odd-body-footer"/>
            </fo:simple-page-master>

            <fo:simple-page-master
                master-name="notices-last"
                page-width="{$page-width}"
                page-height="{$page-height}">
                <fo:region-body
                    margin-top="{$notices-margin-top}"
                    margin-bottom="{$notices-margin-bottom}"
                    margin-left="{$notices-margin-left}"
                    margin-right="{$notices-margin-right}"
                    column-count="2" 
                    column-gap="{$notices-column-gap}"/>
                <fo:region-before extent="{$notices-margin-top}"
                    display-align="before"
                    region-name="last-body-header"/>
                <fo:region-after extent="{$notices-margin-bottom}"
                    display-align="after"
                    region-name="last-body-footer"/>
            </fo:simple-page-master>


            <!--INDEX simple masters-->

            <fo:simple-page-master
                master-name="index-first"
                page-width="{$page-width}"
                page-height="{$page-height}">
                <fo:region-body
                    margin-top="{$page-margin-top}"
                    margin-bottom="{$page-margin-bottom}"
                    margin-left="{$page-margin-left}"
                    margin-right="{$page-margin-right}">
                      <xsl:if test="$pdfFormatter != 'xep'">
                        <xsl:attribute name="column-count">2</xsl:attribute>
                      </xsl:if>
                </fo:region-body>
                <fo:region-before extent="{$page-margin-top}"
                    display-align="before"
                    region-name="odd-index-header"/>
                <fo:region-after extent="{$page-margin-bottom}"
                    display-align="after"
                    region-name="odd-index-footer"/>
            </fo:simple-page-master>

            <fo:simple-page-master
                master-name="index-even"
                page-width="{$page-width}"
                page-height="{$page-height}">
                <fo:region-body
                    margin-top="{$page-margin-top}"
                    margin-bottom="{$page-margin-bottom}"
                    margin-left="{$page-margin-left}"
                    margin-right="{$page-margin-right}">
                      <xsl:if test="$pdfFormatter != 'xep'">
                        <xsl:attribute name="column-count">2</xsl:attribute>
                      </xsl:if>
                </fo:region-body>
                <fo:region-before extent="{$page-margin-top}"
                    display-align="before"
                    region-name="even-index-header"/>
                <fo:region-after extent="{$page-margin-bottom}"
                    display-align="after"
                    region-name="even-index-footer"/>
            </fo:simple-page-master>

            <fo:simple-page-master
                master-name="index-odd"
                page-width="{$page-width}"
                page-height="{$page-height}">
                <fo:region-body
                    margin-top="{$page-margin-top}"
                    margin-bottom="{$page-margin-bottom}"
                    margin-left="{$page-margin-left}"
                    margin-right="{$page-margin-right}">
                      <xsl:if test="$pdfFormatter != 'xep'">
                        <xsl:attribute name="column-count">2</xsl:attribute>
                      </xsl:if>
                </fo:region-body>
                <fo:region-before extent="{$page-margin-top}"
                    display-align="before"
                    region-name="odd-index-header"/>
                <fo:region-after extent="{$page-margin-bottom}"
                    display-align="after"
                    region-name="odd-index-footer"/>
            </fo:simple-page-master>


            <fo:page-sequence-master master-name="toc-sequence">
                <fo:repeatable-page-master-alternatives>
                    <fo:conditional-page-master-reference master-reference="toc-first" page-position="first" odd-or-even="odd"/>
                    <fo:conditional-page-master-reference master-reference="toc-last" page-position="last"/>
                    <fo:conditional-page-master-reference master-reference="toc-odd" odd-or-even="odd"/>
                    <fo:conditional-page-master-reference master-reference="toc-even" odd-or-even="even"/>
                </fo:repeatable-page-master-alternatives>
            </fo:page-sequence-master>

            <fo:page-sequence-master master-name="body-sequence">
                <fo:repeatable-page-master-alternatives>
                    <fo:conditional-page-master-reference page-position="first" master-reference="body-first"/>
                    <fo:conditional-page-master-reference master-reference="body-last" odd-or-even="even" page-position="last" blank-or-not-blank="blank"/>
                    <fo:conditional-page-master-reference master-reference="body-odd" odd-or-even="odd"/>
                    <fo:conditional-page-master-reference master-reference="body-even" odd-or-even="even"/>
                </fo:repeatable-page-master-alternatives>
            </fo:page-sequence-master>
            
            <fo:page-sequence-master master-name="notices-sequence">
                <fo:repeatable-page-master-alternatives>
                    <fo:conditional-page-master-reference page-position="first" master-reference="notices-first"/>
                    <fo:conditional-page-master-reference master-reference="notices-last" odd-or-even="even" page-position="last" blank-or-not-blank="blank"/>
                    <fo:conditional-page-master-reference master-reference="notices-odd" odd-or-even="odd"/>
                    <fo:conditional-page-master-reference master-reference="notices-even" odd-or-even="even"/>
                </fo:repeatable-page-master-alternatives>
            </fo:page-sequence-master>

            <fo:page-sequence-master master-name="ditamap-body-sequence">
                <fo:repeatable-page-master-alternatives>
                    <fo:conditional-page-master-reference master-reference="body-odd" odd-or-even="odd"/>
                    <fo:conditional-page-master-reference master-reference="body-even" odd-or-even="even"/>
                </fo:repeatable-page-master-alternatives>
            </fo:page-sequence-master>

            <fo:page-sequence-master master-name="index-sequence">
                <fo:repeatable-page-master-alternatives>
                    <fo:conditional-page-master-reference page-position="first" master-reference="index-first" odd-or-even="odd"/>
                    <fo:conditional-page-master-reference master-reference="index-odd" odd-or-even="odd" />
                    <fo:conditional-page-master-reference master-reference="index-even" odd-or-even="even"/>
                </fo:repeatable-page-master-alternatives>
            </fo:page-sequence-master>

            <fo:page-sequence-master master-name="front-matter">
                <fo:repeatable-page-master-alternatives>
                    <fo:conditional-page-master-reference page-position="first" master-reference="front-matter-first" odd-or-even="odd"/>
                    <fo:conditional-page-master-reference master-reference="front-matter-last" page-position="last" odd-or-even="even" blank-or-not-blank="blank"/>
                    <fo:conditional-page-master-reference master-reference="front-matter-even" odd-or-even="even"/>
                    <fo:conditional-page-master-reference master-reference="front-matter-odd" odd-or-even="odd"/>
                </fo:repeatable-page-master-alternatives>
            </fo:page-sequence-master>

        </fo:layout-master-set>
        
        <!-- ADD DOCUMENT METADATA -->
        <fo:declarations>
            <x:xmpmeta xmlns:x="adobe:ns:meta/">
                <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
                    <rdf:Description rdf:about=""
                        xmlns:dc="http://purl.org/dc/elements/1.1/">
                        <!-- Dublin Core properties go here -->
                        <dc:title><xsl:value-of select="$booktitle"/></dc:title>
                        <dc:creator><xsl:value-of select="$bookauthor"/></dc:creator>
                    </rdf:Description>
                </rdf:RDF>
            </x:xmpmeta>
        </fo:declarations>
        
        
    </xsl:template>

    
</xsl:stylesheet>