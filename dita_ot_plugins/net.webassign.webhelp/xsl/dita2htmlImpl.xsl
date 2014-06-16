<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
    exclude-result-prefixes="xs ditamsg">
    
    
    
    <!-- Add empty breadcrumbs div to top of topic if flag is set  -->
    <!-- Help system will generate breadcrumb content from currently loaded TOC. -->
    <xsl:template name="generateBreadcrumbs">
        <xsl:if test="$BREADCRUMBS='yes'">
            <div id="topic-breadcrumbs"></div>
        </xsl:if>
    </xsl:template>
    
    <!-- Generate links to CSS files -->
    <!-- REVISED to fix problem with CSS linking when using @copy-to.
         This fix might not address every situation for the OT, but fixes the problem for us. -->
    
    <xsl:template name="generateCssLinks">
        <xsl:variable name="childlang">
            <xsl:choose>
                <!-- Update with DITA 1.2: /dita can have xml:lang -->
                <xsl:when test="self::dita[not(@xml:lang)]">
                    <xsl:for-each select="*[1]"><xsl:call-template name="getLowerCaseLang"/></xsl:for-each>
                </xsl:when>
                <xsl:otherwise><xsl:call-template name="getLowerCaseLang"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="direction">
            <xsl:apply-templates select="." mode="get-render-direction">
                <xsl:with-param name="lang" select="$childlang"/>
            </xsl:apply-templates>
        </xsl:variable>
        <xsl:variable name="urltest"> <!-- test for URL -->
            <xsl:call-template name="url-string">
                <xsl:with-param name="urltext">
                    <xsl:value-of select="concat($CSSPATH, $CSS)"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="($direction = 'rtl') and ($urltest = 'url') ">
                <link rel="stylesheet" type="text/css" href="{$CSSPATH}{$bidi-dita-css}" />
            </xsl:when>
            <xsl:when test="($direction = 'rtl') and ($urltest = '')">
                <link rel="stylesheet" type="text/css" href="{$PATH2PROJ}{$CSSPATH}{$bidi-dita-css}" />
            </xsl:when>
            <xsl:when test="($urltest = 'url')">
                <link rel="stylesheet" type="text/css" href="{$CSSPATH}{$dita-css}" />
            </xsl:when>
            <xsl:otherwise>
                <link rel="stylesheet" type="text/css" href="{$CSSPATH}{$dita-css}" />
            </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="$newline"/>
        <!-- Add user's style sheet if requested to -->
        <xsl:if test="string-length($CSS) > 0">
            <xsl:choose>
                <xsl:when test="$urltest = 'url'">
                    <link rel="stylesheet" type="text/css" href="{$CSSPATH}{$CSS}" />
                </xsl:when>
                <xsl:otherwise>
                    <link rel="stylesheet" type="text/css" href="{$CSSPATH}{$CSS}" />
                </xsl:otherwise>
            </xsl:choose><xsl:value-of select="$newline"/>
        </xsl:if>
        
    </xsl:template>
    
    <!-- Add processing for MathML included as image -->
    <xsl:template name="topic-image">
        <xsl:variable name="ends-with-svg">
            <xsl:call-template name="ends-with">
                <xsl:with-param name="text" select="@href"/>
                <xsl:with-param name="with" select="'.svg'"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="ends-with-svgz">
            <xsl:call-template name="ends-with">
                <xsl:with-param name="text" select="@href"/>
                <xsl:with-param name="with" select="'.svgz'"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="isSVG" select="$ends-with-svg = 'true' or $ends-with-svgz = 'true'"/>
        <xsl:variable name="ends-with-mml">
            <xsl:call-template name="ends-with">
                <xsl:with-param name="text" select="@href"/>
                <xsl:with-param name="with" select="'.mml'"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="isMathML" select="$ends-with-mml = 'true'"/>
        <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
        <xsl:choose>
            <xsl:when test="$isSVG">
                <!--<object data="file.svg" type="image/svg+xml" width="500" height="200">-->
                <!-- now invoke the actual content and its alt text -->
                <embed>
                    <xsl:call-template name="commonattributes">
                        <xsl:with-param name="default-output-class">
                            <xsl:if test="@placement = 'break'">
                                <!--Align only works for break-->
                                <xsl:choose>
                                    <xsl:when test="@align = 'left'">imageleft</xsl:when>
                                    <xsl:when test="@align = 'right'">imageright</xsl:when>
                                    <xsl:when test="@align = 'center'">imagecenter</xsl:when>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="setid"/>
                    <xsl:attribute name="src"><xsl:value-of select="@href"/></xsl:attribute>
                    <xsl:apply-templates select="@height|@width"/>
                </embed>
            </xsl:when>
            <xsl:when test="$isMathML">
                <xsl:message>Including MathML image <xsl:value-of select="@href"/></xsl:message>
                <!-- Minimal implementation; just embed the file as is -->
                <!--<xsl:variable name="mmlFile">
                    <xsl:choose>
                        <xsl:when test="starts-with(@href, 'file:')">
                            <xsl:value-of select="@href"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="starts-with(@href, '/')">
                                    <xsl:text>file://</xsl:text><xsl:value-of select="@href"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>file:/</xsl:text><xsl:value-of select="@href"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>-->
                <xsl:copy-of select="document(@href,/)"/>
            </xsl:when>
            <xsl:otherwise>
                <img>
                    <xsl:call-template name="commonattributes">
                        <xsl:with-param name="default-output-class">
                            <xsl:if test="@placement = 'break'"><!--Align only works for break-->
                                <xsl:choose>
                                    <xsl:when test="@align = 'left'">imageleft</xsl:when>
                                    <xsl:when test="@align = 'right'">imageright</xsl:when>
                                    <xsl:when test="@align = 'center'">imagecenter</xsl:when>
                                </xsl:choose>
                            </xsl:if>
                        </xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="setid"/>
                    <xsl:choose>
                        <xsl:when test="*[contains(@class, ' topic/longdescref ')]">
                            <xsl:apply-templates select="*[contains(@class, ' topic/longdescref ')]"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="@longdescref"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:apply-templates select="@href|@height|@width"/>
                    <xsl:apply-templates select="@scale"/>
                    <xsl:choose>
                        <xsl:when test="*[contains(@class, ' topic/alt ')]">
                            <xsl:variable name="alt-content"><xsl:apply-templates select="*[contains(@class, ' topic/alt ')]" mode="text-only"/></xsl:variable>
                            <xsl:attribute name="alt"><xsl:value-of select="normalize-space($alt-content)"/></xsl:attribute>
                        </xsl:when>
                        <xsl:when test="@alt">
                            <xsl:attribute name="alt"><xsl:value-of select="@alt"/></xsl:attribute>
                        </xsl:when>
                    </xsl:choose>
                </img>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
    </xsl:template>
    
    
    <!-- object, desc, & param -->
    <xsl:template match="*[contains(@class, ' topic/object ')]" name="topic.object">
        <xsl:choose>
            <xsl:when test="@type='iframe'">
                <iframe class="object"
                    frameborder="0" allowfullscreen="allowfullscreen" seamless="seamless">
                    <xsl:attribute name="src" select="@data"/>
                    <xsl:for-each select="*[contains(@class, ' topic/param ')]">
                        <xsl:attribute name="{@name}">
                            <xsl:value-of select="@value"/>
                        </xsl:attribute>
                    </xsl:for-each>
                    <xsl:copy-of select="@id | @height | @tabindex | @width | @name"/>
                </iframe>
            </xsl:when>
            <xsl:otherwise>
                <object>
                    <xsl:copy-of select="@id | @declare | @codebase | @type | @archive | @height | @usemap | @tabindex | @classid | @data | @codetype | @standby | @width | @name"/>
                    <xsl:if test="@longdescref or *[contains(@class, ' topic/longdescref ')]">
                        <xsl:apply-templates select="." mode="ditamsg:longdescref-on-object"/>
                    </xsl:if>
                    <xsl:apply-templates/>
                    <!-- Test for Flash movie; include EMBED statement for non-IE browsers -->
                    <xsl:if test="contains(@codebase, 'swflash.cab')">
                        <embed>
                            <xsl:if test="@id"><xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute></xsl:if>
                            <xsl:copy-of select="@height | @width"/>
                            <xsl:attribute name="type"><xsl:text>application/x-shockwave-flash</xsl:text></xsl:attribute>
                            <xsl:attribute name="pluginspage"><xsl:text>http://www.macromedia.com/go/getflashplayer</xsl:text></xsl:attribute>
                            <xsl:if test="*[contains(@class, ' topic/param ')]/@name = 'movie'">
                                <xsl:attribute name="src"><xsl:value-of select="*[contains(@class, ' topic/param ')][@name = 'movie']/@value"/></xsl:attribute>
                            </xsl:if>
                            <xsl:if test="*[contains(@class, ' topic/param ')]/@name = 'quality'">
                                <xsl:attribute name="quality"><xsl:value-of select="*[contains(@class, ' topic/param ')][@name = 'quality']/@value"/></xsl:attribute>
                            </xsl:if>
                            <xsl:if test="*[contains(@class, ' topic/param ')]/@name = 'bgcolor'">
                                <xsl:attribute name="bgcolor"><xsl:value-of select="*[contains(@class, ' topic/param ')][@name = 'bgcolor']/@value"/></xsl:attribute>
                            </xsl:if>
                        </embed>
                    </xsl:if>
                </object>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/data ')][@datatype='userdata']">
        <span>
            <xsl:attribute name="class" select="concat('data userdata ',@outputclass)"/>
            <xsl:copy-of select="@name"/>
            <xsl:choose><!-- Either use @value or the contents of the data element -->
                <xsl:when test="@value">
                    <xsl:value-of select="@value"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    
</xsl:stylesheet>