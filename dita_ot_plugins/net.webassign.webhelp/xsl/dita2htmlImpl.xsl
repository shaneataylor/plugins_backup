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
    
    <!-- Override to support arbitrary colors -->
    <xsl:template match="*" mode="set-output-class">
        <xsl:param name="default"/>
        <xsl:variable name="output-class">
            <xsl:apply-templates select="." mode="get-output-class"/>
        </xsl:variable>
        <xsl:variable name="draft-revs">
            <!-- If draft is on, add revisions to default class. Simplifies processing in DITA-OT 1.6 and earlier
         that created an extra div or span around revised content, just to hold @class with revs. -->
            <xsl:if test="$DRAFT = 'yes'">
                <xsl:for-each select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]/revprop">
                    <xsl:value-of select="@val"/>
                    <xsl:text> </xsl:text>
                </xsl:for-each>
            </xsl:if>
        </xsl:variable>
        <xsl:variable name="using-output-class">
            <xsl:choose>
                <xsl:when test="string-length(normalize-space($output-class)) > 0"><xsl:value-of select="$output-class"/></xsl:when>
                <xsl:when test="string-length(normalize-space($default)) > 0"><xsl:value-of select="$default"/></xsl:when>
            </xsl:choose>
            <xsl:if test="$draft-revs != ''">
                <xsl:text> </xsl:text>
                <xsl:value-of select="normalize-space($draft-revs)"/>
            </xsl:if>
        </xsl:variable>
        <xsl:variable name="ancestry">
            <xsl:if test="$PRESERVE-DITA-CLASS = 'yes'">
                <xsl:apply-templates select="." mode="get-element-ancestry"/>
            </xsl:if>
        </xsl:variable>
        <xsl:variable name="outputclass-attribute">
            <xsl:apply-templates select="@outputclass" mode="get-value-for-class"/>
        </xsl:variable>
        <!-- Revised design with DITA-OT 1.5: include class ancestry if requested; 
       combine user output class with element default, giving priority to the user value. -->
        <xsl:if test="string-length(normalize-space(concat($outputclass-attribute, $using-output-class, $ancestry))) > 0">
            <xsl:attribute name="class">
                <xsl:value-of select="$ancestry"/>
                <xsl:if test="string-length(normalize-space($ancestry)) > 0 and 
                    string-length(normalize-space($using-output-class)) > 0"><xsl:text> </xsl:text></xsl:if>
                <xsl:value-of select="normalize-space($using-output-class)"/>
                <xsl:if test="string-length(normalize-space(concat($ancestry, $using-output-class))) > 0 and
                    string-length(normalize-space($outputclass-attribute)) > 0"><xsl:text> </xsl:text></xsl:if>
                <xsl:value-of select="$outputclass-attribute"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="contains($outputclass-attribute,'color=')">
            <xsl:attribute name="style">
                <xsl:value-of 
                    select="concat('color:',replace($outputclass-attribute,'^.*?\s*color=(#?[a-zA-Z0-9]+)($|[\s;].*?$)','$1'))"/>
            </xsl:attribute>
        </xsl:if>
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
    
    <xsl:template match="*[contains(@class, ' topic/data ')][@datatype='json']">
        <div data-only="true" data-type="text/json">
            <xsl:choose>
                <xsl:when test="not(./*) and text()">
                    <xsl:copy-of select="text()" xml:space="preserve"/>
                </xsl:when>
                <xsl:when test="./*[contains(@class, ' topic/data ')]">
                    <xsl:value-of select="concat('&#10;&quot;',@name,'&quot; : {&#10;')"/>
                    <xsl:apply-templates select="*[contains(@class, ' topic/data ')]" mode="json-data"/>
                    <xsl:text>}</xsl:text>
                </xsl:when>
            </xsl:choose>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/data ')]" mode="json-data">
        <xsl:param name="inArray" select="false()"/>
        <xsl:param name="isArray" select="@type='array'"/>
        <xsl:param name="isNameValue" select="@name and (@value or @href)"/>
        <xsl:param name="isValueOnly" select="not(@name) and (@value or @href)"/>
        <xsl:param name="hasData" select="@name and (./*[contains(@class, ' topic/data ')])"/>
        <xsl:param name="qname" select="concat('&quot;',@name,'&quot;')"/>
        <xsl:param name="qvalue">
            <xsl:choose>
                <xsl:when test="@value">
                    <xsl:value-of select="concat('&quot;',@value,'&quot;')"/>
                </xsl:when>
                <xsl:when test="@href">
                    <xsl:value-of select="concat('&quot;',@href,'&quot;')"/>
                </xsl:when>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="endline">
            <xsl:choose>
                <xsl:when test="position()=last()"><xsl:value-of select="'&#10;'"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="',&#10;'"/></xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <!-- Invalid structures will fail silently -->
        <xsl:choose>
            <xsl:when test="$isArray">
                <xsl:choose>
                    <xsl:when test="$hasData">
                        <xsl:value-of select="concat($qname,' : [&#10;')"/>
                        <xsl:apply-templates select="*[contains(@class, ' topic/data ')]" mode="json-data">
                            <xsl:with-param name="inArray" select="true()"/>
                        </xsl:apply-templates>
                        <xsl:value-of select="concat(']',$endline)"/>
                    </xsl:when>
                    <xsl:when test="$isValueOnly">
                        <xsl:value-of select="concat('[',$qvalue,']',$endline)"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$hasData"><!-- same whether in an array or not -->
                <xsl:value-of select="concat($qname,' : {&#10;')"/>
                <xsl:apply-templates select="*[contains(@class, ' topic/data ')]" mode="json-data"/>
                <xsl:value-of select="concat('}',$endline)"/>
            </xsl:when>
            <xsl:when test="$inArray">
                <xsl:choose>
                    <xsl:when test="$isNameValue">
                        <xsl:value-of select="concat('{',$qname,' : ',$qvalue,'}',$endline)"/>
                    </xsl:when>
                    <xsl:when test="$isValueOnly">
                        <xsl:value-of select="concat($qvalue,$endline)"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$isNameValue">
                <xsl:value-of select="concat($qname,' : ',$qvalue,$endline)"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>






    <xsl:template match="*[contains(@class, ' learning-d/lcSingleSelect ')]">
        <xsl:param name="qid" select="@id"/>
        <div>
            <xsl:copy-of select="@id"/>
            <xsl:attribute name="class" select="concat('fig lcInteractionBase lcSingleSelect ',@outputclass)"/>
            <xsl:apply-templates mode="lc-single-select">
                <xsl:with-param name="qid" select="$qid"/>
            </xsl:apply-templates>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/title ')]" mode="lc-single-select">
        <xsl:param name="qid" select="@id"/>
        <h2>
            <xsl:copy-of select="@id"/>
            <xsl:attribute name="class" select="concat('title lcSingleSelectTitle ',@outputclass)"/>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
    
    <!-- + topic/p learningInteractionBase-d/lcQuestionBase learning-d/lcQuestion  -->
    <xsl:template match="*[contains(@class, ' learning-d/lcQuestion ')]" mode="lc-single-select">
        <xsl:param name="qid" select="@id"/>
        <div>
            <xsl:copy-of select="@id"/>
            <xsl:attribute name="class" select="concat('p lcQuestionBase lcQuestion ',@outputclass)"/>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!--<xsl:template match="*[contains(@class, ' learning-d/lcAnswerOptionGroup ')]" mode="lc-single-select">
        <xsl:param name="qid"/>
        <xsl:apply-templates mode="lc-single-select">
            <xsl:with-param name="qid" select="$qid"/>
        </xsl:apply-templates>
    </xsl:template>-->
    
    <xsl:template match="*[contains(@class, ' topic/data ')]" mode="lc-single-select">
        <!-- use @data to specify where a back link might lead -->
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' learning-d/lcAnswerOptionGroup ')]" mode="lc-single-select">
        <xsl:param name="qid"/>
        <div>
            <xsl:copy-of select="@id"/>
            <xsl:attribute name="class" select="concat('ul lcAnswerOptionGroup ',@outputclass)"/>
            <xsl:apply-templates mode="lc-single-select">
                <xsl:with-param name="qid" select="$qid"/>
            </xsl:apply-templates>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' learning-d/lcAnswerOption ')]" mode="lc-single-select">
        <xsl:param name="qid"/>
        <xsl:param name="choiceval">
            <xsl:choose>
                <xsl:when test="@id">
                    <xsl:value-of select="@id"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="position()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="choiceid" select="concat($qid,$choiceval)"/>
        <xsl:apply-templates mode="lc-single-select"
            select="*[contains(@class, ' learning-d/lcAnswerContent ')]|*[contains(@class, ' learning-d/lcFeedback ')]">
            <!-- Don't do anything with lcCorrectResponse -->
            <xsl:with-param name="qid" select="$qid"/>
            <xsl:with-param name="choiceid" select="$choiceid"/>
            <xsl:with-param name="choiceval" select="$choiceval"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' learning-d/lcAnswerContent ')]" mode="lc-single-select">
        <xsl:param name="qid"/>
        <xsl:param name="choiceid"/>
        <xsl:param name="choiceval"/>
        <xsl:param name="data-nexthref" select="*[contains(@class, ' topic/data ')][@name='next'][@href][1]/@href"/>
        <xsl:param name="nexthref" >
            <xsl:choose>
                <xsl:when test="matches($data-nexthref,'\\#[^\\/]+\\/[^\\/]+')">
                    <xsl:value-of select="concat('#',substring-after($data-nexthref,'/'))"/>
                </xsl:when>
                <xsl:when test="matches($data-nexthref,'.+\\#[^\\/]+\\/[^\\/]+')">
                    <xsl:value-of select="replace($data-nexthref,'\\#[^\\/]+\\/','#')"/>
                </xsl:when>
                <xsl:otherwise>#</xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <div>
            <xsl:copy-of select="@id"/>
            <xsl:attribute name="class" select="concat('lcAnswerContent ',@outputclass)"/>
            <input type="radio">
                <xsl:attribute name="name" select="$qid"/>
                <xsl:attribute name="id" select="$choiceid"/>
                <xsl:attribute name="value" select="$choiceval"/>
                <xsl:attribute name="next" select="$nexthref"/>
            </input>
            <label>
                <xsl:attribute name="for" select="$choiceid"/>
                <xsl:apply-templates/>
            </label>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' learning-d/lcFeedback ')]" mode="lc-single-select">
        <xsl:param name="qid"/>
        <xsl:param name="choiceid"/>
        <xsl:param name="choiceval"/>
        <div>
            <xsl:copy-of select="@id"/>
            <xsl:attribute name="name" select="$qid"/>
            <xsl:attribute name="feedbackforvalue" select="$choiceval"/>
            <xsl:attribute name="class" select="concat('p p lcFeedback ',@outputclass)"/>
        </div>
        <xsl:apply-templates/>
    </xsl:template>
    
    
</xsl:stylesheet>