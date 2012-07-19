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
    
    
    
    <xsl:template name="insertBodyOddHeader">
        
        <fo:static-content flow-name="odd-body-header">
            <fo:block xsl:use-attribute-sets="__body__odd__header">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Body odd header'"/>
                    <xsl:with-param name="theParameters">
                        <prodname>
                            <xsl:value-of select="$productName"/>
                        </prodname>
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__odd__header__heading">
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
                        </heading>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__odd__header__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>
        
    </xsl:template>
    
    <xsl:template name="insertBodyEvenHeader">
        
        <fo:static-content flow-name="even-body-header">
            <fo:block xsl:use-attribute-sets="__body__even__header">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Body even header'"/>
                    <xsl:with-param name="theParameters">
                        <prodname>
                            <xsl:value-of select="$productName"/>
                        </prodname>
                        <!-- ADD PARAMETER FOR BOOK TITLE. CALL THIS IN common/vars/en_US.xml -->
                        <booktitle>
                            <xsl:value-of select="$booktitle"/>
                        </booktitle>
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__even__header__heading">
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
                        </heading>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__even__header__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>
        
    </xsl:template>
    
    
    

    

    <xsl:template name="insertBodyFirstHeader">

        <fo:static-content flow-name="first-body-header">
            <fo:block xsl:use-attribute-sets="__body__first__header">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Body first header'"/>
                    <xsl:with-param name="theParameters">
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__first__header__heading">
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
                        </heading>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__first__header__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>

    </xsl:template>

    <xsl:template name="insertBodyFirstFooter">

        <fo:static-content flow-name="first-body-footer">
            <fo:block xsl:use-attribute-sets="__body__first__footer">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Body first footer'"/>
                    <xsl:with-param name="theParameters">
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__first__footer__heading">
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
                        </heading>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__first__footer__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                        <!-- NEW PARAMETERS. CALL IN common/vars/en_US.xml -->
                        <copyrightdate><xsl:value-of select="$copyrightdate"/></copyrightdate>
                        <copyrightstatement><xsl:value-of select="$copyrightstatement"/></copyrightstatement>
                        <revisiondate><xsl:value-of select="$revisiondate"/></revisiondate>
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>

    </xsl:template>

    <xsl:template name="insertBodyLastHeader">
        <fo:static-content flow-name="last-body-header">
            <fo:block xsl:use-attribute-sets="__body__last__header">
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertBodyLastFooter">
        <fo:static-content flow-name="last-body-footer">
            <fo:block xsl:use-attribute-sets="__body__last__footer">
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertBodyFootnoteSeparator">
        <fo:static-content flow-name="xsl-footnote-separator">
            <fo:block>
                <fo:leader xsl:use-attribute-sets="__body__footnote__separator"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertBodyOddFooter">

        <fo:static-content flow-name="odd-body-footer">
            <fo:block xsl:use-attribute-sets="__body__odd__footer">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Body odd footer'"/>
                    <xsl:with-param name="theParameters">
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__odd__footer__heading">
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
                        </heading>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__odd__footer__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                        <!-- NEW PARAMETERS. CALL IN common/vars/en_US.xml -->
                        <copyrightdate><xsl:value-of select="$copyrightdate"/></copyrightdate>
                        <copyrightstatement><xsl:value-of select="$copyrightstatement"/></copyrightstatement>
                        <revisiondate><xsl:value-of select="$revisiondate"/></revisiondate>
                        
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>

    </xsl:template>

    <xsl:template name="insertBodyEvenFooter">

        <fo:static-content flow-name="even-body-footer">
            <fo:block xsl:use-attribute-sets="__body__even__footer">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Body even footer'"/>
                    <xsl:with-param name="theParameters">
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__even__footer__heading">
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
                        </heading>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__even__footer__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                        <!-- NEW PARAMETERS. CALL IN common/vars/en_US.xml -->
                        <copyrightdate><xsl:value-of select="$copyrightdate"/></copyrightdate>
                        <copyrightstatement><xsl:value-of select="$copyrightstatement"/></copyrightstatement>
                        <revisiondate><xsl:value-of select="$revisiondate"/></revisiondate>
                        
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>

    </xsl:template>

    <xsl:template name="insertTocOddHeader">
        <fo:static-content flow-name="odd-toc-header">
            <fo:block xsl:use-attribute-sets="__toc__odd__header">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Toc odd header'"/>
                    <xsl:with-param name="theParameters">
                        <prodname>
                            <xsl:value-of select="$productName"/>
                        </prodname>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__toc__odd__header__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                        <!-- ADD PARAMETER FOR BOOK TITLE. CALL THIS IN common/vars/en_US.xml -->
                        <booktitle>
                            <xsl:value-of select="$booktitle"/>
                        </booktitle>
                        
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>

    </xsl:template>

    <xsl:template name="insertTocEvenHeader">
        <fo:static-content flow-name="even-toc-header">
            <fo:block xsl:use-attribute-sets="__toc__even__header">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Toc even header'"/>
                    <xsl:with-param name="theParameters">
                        <prodname>
                            <xsl:value-of select="$productName"/>
                        </prodname>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__toc__even__header__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                        <!-- ADD PARAMETER FOR BOOK TITLE. CALL THIS IN common/vars/en_US.xml -->
                        <booktitle>
                            <xsl:value-of select="$booktitle"/>
                        </booktitle>
                        
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>

    </xsl:template>

    <xsl:template name="insertTocOddFooter">
        <fo:static-content flow-name="odd-toc-footer">
            <fo:block xsl:use-attribute-sets="__toc__odd__footer">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Toc odd footer'"/>
                    <xsl:with-param name="theParameters">
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__toc__odd__footer__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                        <!-- NEW PARAMETERS. CALL IN common/vars/en_US.xml -->
                        <copyrightdate><xsl:value-of select="$copyrightdate"/></copyrightdate>
                        <copyrightstatement><xsl:value-of select="$copyrightstatement"/></copyrightstatement>
                        <revisiondate><xsl:value-of select="$revisiondate"/></revisiondate>
                        
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>

    </xsl:template>

    <xsl:template name="insertTocEvenFooter">
        <fo:static-content flow-name="even-toc-footer">
            <fo:block xsl:use-attribute-sets="__toc__even__footer">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Toc even footer'"/>
                    <xsl:with-param name="theParameters">
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__toc__even__footer__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                        <!-- NEW PARAMETERS. CALL IN common/vars/en_US.xml -->
                        <copyrightdate><xsl:value-of select="$copyrightdate"/></copyrightdate>
                        <copyrightstatement><xsl:value-of select="$copyrightstatement"/></copyrightstatement>
                        <revisiondate><xsl:value-of select="$revisiondate"/></revisiondate>
                        
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>

    </xsl:template>


    <xsl:template name="insertPrefaceOddHeader">

        <fo:static-content flow-name="odd-body-header">
            <fo:block xsl:use-attribute-sets="__body__odd__header">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Preface odd header'"/>
                    <xsl:with-param name="theParameters">
                        <prodname>
                            <xsl:value-of select="$productName"/>
                        </prodname>
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__odd__header__heading">
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
                        </heading>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__odd__header__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                        
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>

    </xsl:template>

    <xsl:template name="insertPrefaceEvenHeader">

        <fo:static-content flow-name="even-body-header">
            <fo:block xsl:use-attribute-sets="__body__even__header">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Preface even header'"/>
                    <xsl:with-param name="theParameters">
                        <prodname>
                            <xsl:value-of select="$productName"/>
                        </prodname>
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__even__header__heading">
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
                        </heading>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__even__header__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>

    </xsl:template>

    <xsl:template name="insertPrefaceFirstHeader">

        <fo:static-content flow-name="first-body-header">
            <fo:block xsl:use-attribute-sets="__body__first__header">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Preface first header'"/>
                    <xsl:with-param name="theParameters">
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__first__header__heading">
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
                        </heading>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__first__header__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>

    </xsl:template>

    <xsl:template name="insertPrefaceFirstFooter">

        <fo:static-content flow-name="first-body-footer">
            <fo:block xsl:use-attribute-sets="__body__first__footer">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Preface first footer'"/>
                    <xsl:with-param name="theParameters">
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__first__footer__heading">
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
                        </heading>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__first__footer__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                        <!-- NEW PARAMETERS. CALL IN common/vars/en_US.xml -->
                        <copyrightdate><xsl:value-of select="$copyrightdate"/></copyrightdate>
                        <copyrightstatement><xsl:value-of select="$copyrightstatement"/></copyrightstatement>
                        <revisiondate><xsl:value-of select="$revisiondate"/></revisiondate>
                        
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>

    </xsl:template>

    <xsl:template name="insertPrefaceLastHeader">
        <fo:static-content flow-name="last-body-header">
            <fo:block xsl:use-attribute-sets="__body__last__header">
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertPrefaceLastFooter">
        <fo:static-content flow-name="last-body-footer">
            <fo:block xsl:use-attribute-sets="__body__last__footer">
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertPrefaceFootnoteSeparator">
        <fo:static-content flow-name="xsl-footnote-separator">
            <fo:block>
                <fo:leader xsl:use-attribute-sets="__body__footnote__separator"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertPrefaceOddFooter">

        <fo:static-content flow-name="odd-body-footer">
            <fo:block xsl:use-attribute-sets="__body__odd__footer">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Preface odd footer'"/>
                    <xsl:with-param name="theParameters">
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__odd__footer__heading">
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
                        </heading>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__odd__footer__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                        <!-- NEW PARAMETERS. CALL IN common/vars/en_US.xml -->
                        <copyrightdate><xsl:value-of select="$copyrightdate"/></copyrightdate>
                        <copyrightstatement><xsl:value-of select="$copyrightstatement"/></copyrightstatement>
                        <revisiondate><xsl:value-of select="$revisiondate"/></revisiondate>
                        
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>

    </xsl:template>

    <xsl:template name="insertPrefaceEvenFooter">

        <fo:static-content flow-name="even-body-footer">
            <fo:block xsl:use-attribute-sets="__body__even__footer">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Preface even footer'"/>
                    <xsl:with-param name="theParameters">
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__even__footer__heading">
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
                        </heading>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__even__footer__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                        <!-- NEW PARAMETERS. CALL IN common/vars/en_US.xml -->
                        <copyrightdate><xsl:value-of select="$copyrightdate"/></copyrightdate>
                        <copyrightstatement><xsl:value-of select="$copyrightstatement"/></copyrightstatement>
                        <revisiondate><xsl:value-of select="$revisiondate"/></revisiondate>
                        
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>

    </xsl:template>

    <xsl:template name="insertFrontMatterOddHeader">

        <fo:static-content flow-name="odd-frontmatter-header">
            <fo:block xsl:use-attribute-sets="__body__odd__header">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Preface odd header'"/>
                    <xsl:with-param name="theParameters">
                        <prodname>
                            <xsl:value-of select="$productName"/>
                        </prodname>
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__odd__header__heading">
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
                        </heading>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__odd__header__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>

    </xsl:template>

    <xsl:template name="insertFrontMatterEvenHeader">

        <fo:static-content flow-name="even-frontmatter-header">
            <fo:block xsl:use-attribute-sets="__body__even__header">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Preface even header'"/>
                    <xsl:with-param name="theParameters">
                        <prodname>
                            <xsl:value-of select="$productName"/>
                        </prodname>
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__even__header__heading">
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
                        </heading>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__even__header__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>

    </xsl:template>


    <xsl:template name="insertFrontMatterLastHeader">
        <fo:static-content flow-name="last-frontmatter-header">
            <fo:block xsl:use-attribute-sets="__body__even__header">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Preface even header'"/>
                    <xsl:with-param name="theParameters">
                        <prodname>
                            <xsl:value-of select="$productName"/>
                        </prodname>
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__even__header__heading">
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
                        </heading>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__even__header__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertFrontMatterLastFooter">
        <fo:static-content flow-name="last-frontmatter-footer">
            <fo:block xsl:use-attribute-sets="__body__last__footer">
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertFrontMatterFootnoteSeparator">
        <fo:static-content flow-name="xsl-footnote-separator">
            <fo:block>
                <fo:leader xsl:use-attribute-sets="__body__footnote__separator"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertFrontMatterOddFooter">

        <fo:static-content flow-name="odd-frontmatter-footer">
            <fo:block xsl:use-attribute-sets="__body__odd__footer">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Preface odd footer'"/>
                    <xsl:with-param name="theParameters">
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__odd__footer__heading">
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
                        </heading>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__odd__footer__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                        <!-- NEW PARAMETERS. CALL IN common/vars/en_US.xml -->
                        <copyrightdate><xsl:value-of select="$copyrightdate"/></copyrightdate>
                        <copyrightstatement><xsl:value-of select="$copyrightstatement"/></copyrightstatement>
                        <revisiondate><xsl:value-of select="$revisiondate"/></revisiondate>
                        
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>

    </xsl:template>

    <xsl:template name="insertFrontMatterEvenFooter">

        <fo:static-content flow-name="even-frontmatter-footer">
            <fo:block xsl:use-attribute-sets="__body__even__footer">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Preface even footer'"/>
                    <xsl:with-param name="theParameters">
                        <heading>
                            <fo:inline xsl:use-attribute-sets="__body__even__footer__heading">
                                <fo:retrieve-marker retrieve-class-name="current-header"/>
                            </fo:inline>
                        </heading>
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__even__footer__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                        <!-- NEW PARAMETERS. CALL IN common/vars/en_US.xml -->
                        <copyrightdate><xsl:value-of select="$copyrightdate"/></copyrightdate>
                        <copyrightstatement><xsl:value-of select="$copyrightstatement"/></copyrightstatement>
                        <revisiondate><xsl:value-of select="$revisiondate"/></revisiondate>
                        
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>

    </xsl:template>

    
    
    
</xsl:stylesheet>