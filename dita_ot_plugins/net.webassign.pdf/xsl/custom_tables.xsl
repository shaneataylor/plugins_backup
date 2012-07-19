<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
    xmlns:exsl="http://exslt.org/common"
    xmlns:exslf="http://exslt.org/functions"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    extension-element-prefixes="exsl"
    exclude-result-prefixes="opentopic-func exslf exsl dita2xslfo"
    version="1.1">


    <!--  Simpletable processing  -->
    <xsl:template match="*[contains(@class, ' topic/simpletable ')]">
        <xsl:variable name="number-cells">
            <!-- Contains the number of cells in the widest row -->
            <xsl:apply-templates select="*[1]" mode="count-max-simpletable-cells"/>
        </xsl:variable>
        <fo:table xsl:use-attribute-sets="simpletable" id="{@id}">
            <!-- <xsl:call-template name="univAttrs"/> -->
            <xsl:call-template name="globalAtts"/>
            <xsl:call-template name="displayAtts">
                <xsl:with-param name="element" select="."/>
            </xsl:call-template>
            
            <xsl:if test="@relcolwidth">
                <xsl:variable name="fix-relcolwidth">
                    <xsl:apply-templates select="." mode="fix-relcolwidth">
                        <xsl:with-param name="number-cells" select="$number-cells"/>
                    </xsl:apply-templates>
                </xsl:variable>
                <!-- If @keycol=1 AND no sthead, prefix theColumnWidthes with 'keycol ' -->
                <xsl:variable name="keycol1">
                    <xsl:choose>
                        <xsl:when test="self::node()/*[1][contains(@class, ' topic/sthead ')]"></xsl:when>
                        <xsl:when test="@keycol='1'"><xsl:text>keycol </xsl:text></xsl:when>
                        <xsl:otherwise></xsl:otherwise>
                    </xsl:choose>
                    
                </xsl:variable>
                <xsl:call-template name="createSimpleTableColumns">
                    <xsl:with-param name="theColumnWidthes" select="concat($keycol1, $fix-relcolwidth)"/>
                </xsl:call-template>
            </xsl:if>
            
            <!-- Toss processing to another template to process the simpletable
                heading, and/or create a default table heading row. -->
            <xsl:apply-templates select="." mode="dita2xslfo:simpletable-heading">
                <xsl:with-param name="number-cells" select="$number-cells"/>
            </xsl:apply-templates>
            
            <fo:table-body xsl:use-attribute-sets="simpletable__body">
                <xsl:apply-templates select="*[contains(@class, ' topic/strow ')]">
                    <xsl:with-param name="number-cells" select="$number-cells"/>
                </xsl:apply-templates>
            </fo:table-body>
            
        </fo:table>
    </xsl:template>
    


<xsl:template name="createSimpleTableColumns">
        <xsl:param name="theColumnWidthes" select="'1*'"/>
        <!-- Apply keycol column attributes only when @keycol=1 (and only if no column headers?) -->
        <!-- Referring template must pass "keycol" as the first parameter -->
        <xsl:choose>
            <xsl:when test="contains($theColumnWidthes, 'keycol ')">
                <fo:table-column xsl:use-attribute-sets="keycol">
                    <xsl:attribute name="column-width">
                        <xsl:call-template name="xcalcColumnWidth">
                            <xsl:with-param name="theColwidth" 
                                select="substring-before(substring-after($theColumnWidthes,'keycol '), ' ')"/>
                        </xsl:call-template>
                    </xsl:attribute>
                </fo:table-column>

                <xsl:call-template name="createSimpleTableColumns">
                    <xsl:with-param name="theColumnWidthes" 
                        select="substring-after(substring-after($theColumnWidthes,'keycol '), ' ')"/>
                </xsl:call-template>

            </xsl:when>
            <xsl:when test="contains($theColumnWidthes, ' ')">
                <fo:table-column>
                    <xsl:attribute name="column-width">
                        <xsl:call-template name="xcalcColumnWidth">
                            <xsl:with-param name="theColwidth" select="substring-before($theColumnWidthes, ' ')"/>
                        </xsl:call-template>
                    </xsl:attribute>
                    
                </fo:table-column>

                <xsl:call-template name="createSimpleTableColumns">
                    <xsl:with-param name="theColumnWidthes" select="substring-after($theColumnWidthes, ' ')"/>
                </xsl:call-template>

            </xsl:when>
            <xsl:otherwise>
                <fo:table-column>
                    <xsl:attribute name="column-width">
                        <xsl:call-template name="xcalcColumnWidth">
                            <xsl:with-param name="theColwidth" select="$theColumnWidthes"/>
                        </xsl:call-template>
                    </xsl:attribute>
                </fo:table-column>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>




    <!-- ADDED PROCESSING TO WARN AND FIX IF @relcolwidth STARTS OR ENDS WITH ONE OR MORE SPACES -->
    <xsl:template match="*" mode="fix-relcolwidth">
        <xsl:param name="update-relcolwidth" select="@relcolwidth"/>
        <xsl:param name="number-cells">
            <xsl:apply-templates select="*[1]" mode="count-max-simpletable-cells"/>
        </xsl:param>
        <xsl:param name="number-relwidths">
            <xsl:apply-templates select="." mode="count-colwidths"/>
        </xsl:param>
        <xsl:if test="$update-relcolwidth != normalize-space($update-relcolwidth)">
            <xsl:message> [WARN] @relcolwidth attribute includes extra spaces. Normalized to
                    <xsl:value-of select="$update-relcolwidth"/>
            </xsl:message>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="$number-relwidths &lt; $number-cells">
                <xsl:apply-templates select="." mode="fix-relcolwidth">
                    <xsl:with-param name="update-relcolwidth"
                        select="concat($update-relcolwidth,' *1')"/>
                    <xsl:with-param name="number-cells" select="$number-cells"/>
                    <xsl:with-param name="number-relwidths" select="$number-relwidths+1"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$update-relcolwidth"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>



    <xsl:template name="displayAtts">
        <xsl:param name="element"/>

        <!-- Add basic @expanse processing for tables -->
        <xsl:if test="$element/@expanse='page'">
            <xsl:attribute name="margin-left">-1.25in</xsl:attribute>
            <xsl:attribute name="width">6.4in</xsl:attribute>
            <!-- value of 6.5 led to overconstrained geometry messages -->
        </xsl:if>

        <xsl:choose>
            <xsl:when test="$element/@frame='all' or not($element/@frame)">
                <xsl:call-template name="processAttrSetReflection">
                    <xsl:with-param name="attrSet" select="'table__tableframe__all'"/>
                    <xsl:with-param name="path" select="$tableAttrs"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$element/@frame='topbot'">
                <xsl:call-template name="processAttrSetReflection">
                    <xsl:with-param name="attrSet" select="'table__tableframe__topbot'"/>
                    <xsl:with-param name="path" select="$tableAttrs"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$element/@frame='top'">
                <xsl:call-template name="processAttrSetReflection">
                    <xsl:with-param name="attrSet" select="'table__tableframe__top'"/>
                    <xsl:with-param name="path" select="$tableAttrs"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$element/@frame='bottom'">
                <xsl:call-template name="processAttrSetReflection">
                    <xsl:with-param name="attrSet" select="'table__tableframe__bottom'"/>
                    <xsl:with-param name="path" select="$tableAttrs"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$element/@frame='sides'">
                <xsl:call-template name="processAttrSetReflection">
                    <xsl:with-param name="attrSet" select="'table__tableframe__sides'"/>
                    <xsl:with-param name="path" select="$tableAttrs"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>


    <!--  Choicetable processing (revised to specify different default heading text)  -->
    <xsl:template match="*[contains(@class, ' task/choicetable ')]">
        <fo:table xsl:use-attribute-sets="choicetable" id="{@id}">
            <!-- Add basic @expanse processing for tables -->
            <xsl:if test="@expanse='page'">
                <xsl:attribute name="margin-left">-1.25in</xsl:attribute>
                <xsl:attribute name="width">6.4in</xsl:attribute>
                <!-- value of 6.5 led to overconstrained geometry messages -->
            </xsl:if>

            <xsl:call-template name="univAttrs"/>
            <xsl:call-template name="globalAtts"/>

            <xsl:if test="@relcolwidth">
                <xsl:variable name="fix-relcolwidth">
                    <xsl:apply-templates select="." mode="fix-relcolwidth"/>
                </xsl:variable>
                <xsl:call-template name="createSimpleTableColumns">
                    <xsl:with-param name="theColumnWidthes" select="$fix-relcolwidth"/>
                </xsl:call-template>
            </xsl:if>

            <xsl:choose>
                <xsl:when test="*[contains(@class, ' task/chhead ')]">
                    <xsl:apply-templates select="*[contains(@class, ' task/chhead ')]"/>
                </xsl:when>
                <xsl:otherwise>
                    <fo:table-header xsl:use-attribute-sets="chhead">
                        <fo:table-row xsl:use-attribute-sets="chhead__row">
                            <fo:table-cell xsl:use-attribute-sets="chhead.choptionhd">
                                <fo:block xsl:use-attribute-sets="chhead.choptionhd__content">
                                    <!-- <xsl:text>Options</xsl:text> -->
                                    <xsl:call-template name="insertVariable">
                                        <xsl:with-param name="theVariableID"
                                            select="'Choicetable Options'"/>
                                    </xsl:call-template>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="chhead.chdeschd">
                                <fo:block xsl:use-attribute-sets="chhead.chdeschd__content">
                                    <!-- <xsl:text>Description</xsl:text> -->
                                    <xsl:call-template name="insertVariable">
                                        <xsl:with-param name="theVariableID"
                                            select="'Choicetable Description'"/>
                                    </xsl:call-template>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-header>
                </xsl:otherwise>
            </xsl:choose>

            <fo:table-body xsl:use-attribute-sets="choicetable__body">
                <xsl:apply-templates select="*[contains(@class, ' task/chrow ')]"/>
            </fo:table-body>

        </fo:table>
    </xsl:template>

    
    <!-- Make lists in table cells not indented -->
    <xsl:template match="*[contains(@class, ' topic/ul ')]">
        <xsl:choose>
            
            <xsl:when test="ancestor-or-self::*[contains(@class, ' topic/stentry ')] or ancestor-or-self::*[contains(@class, ' topic/entry ')]">
                <!-- topic/stentry also covers choicetable, properties table -->
                <fo:list-block xsl:use-attribute-sets="ul" id="{@id}">
                    <xsl:attribute name="start-indent">-10pt</xsl:attribute>
                    <xsl:apply-templates/>
                </fo:list-block>
            </xsl:when>
            
            <xsl:when test="ancestor-or-self::*[contains(@class, ' topic/entry ')]">
                <fo:list-block xsl:use-attribute-sets="ul" id="{@id}">
                    
                    <xsl:apply-templates/>
                </fo:list-block>
                
            </xsl:when>
            
            <xsl:otherwise>
                <fo:list-block xsl:use-attribute-sets="ul" id="{@id}">
                    <xsl:apply-templates/>
                </fo:list-block>
            </xsl:otherwise>
            
        </xsl:choose>
        
        
    </xsl:template>
    


</xsl:stylesheet>