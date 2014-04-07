<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://example.com/namespace"
    exclude-result-prefixes="xs fn"
    version="2.0">
    
    <xsl:import href="plugin:org.dita.base:xsl/common/output-message.xsl"></xsl:import>
    <xsl:param name="msgprefix">DOTX</xsl:param>
    
    <xsl:param name="thisindextarget" />
    <xsl:param name="outext" />
    
    <xsl:param name="classmaps">
        <classmap ditaclass=" topic/body " element="body" weight="1" />
        <classmap ditaclass=" topic/abstract " element="abstracts" weight="3"/>
        <classmap ditaclass=" topic/shortdesc " element="shortdesc" first="true" weight="5"/>
        <classmap ditaclass=" topic/keyword " element="keywords" weight="5"/>
        <classmap ditaclass=" topic/indexterm " element="indexterms" weight="5"/>
        <classmap ditaclass=" topic/title " element="titles" weight="7"/>
        <classmap ditaclass=" topic/title " element="firsttitle" first="true" weight="10" />
    </xsl:param>
    <xsl:param name="classmapcount" select="count($classmaps/classmap)"/>
    <xsl:param name="stopwords">
        <!-- other potential stopwords at http://snowball.tartarus.org/algorithms/english/stop.txt -->
        <xsl:text>i|me|my|myself|we|our|ours|ourselves|you|your|yours|yourself|yourselves|he|him|his|himself|she|her|hers|herself|it|its|itself|they|them|their|theirs|themselves|what|which|who|whom|this|that|these|those|am|is|are|was|were|be|been|being|have|has|had|having|do|does|did|doing|would|should|could|ought|i'm|you're|he's|she's|it's|we're|they're|i've|you've|we've|they've|i'd|you'd|he'd|she'd|we'd|they'd|i'll|you'll|he'll|she'll|we'll|they'll|isn't|aren't|wasn't|weren't|hasn't|haven't|hadn't|doesn't|don't|didn't|won't|wouldn't|shan't|shouldn't|can't|cannot|couldn't|mustn't|let's|that's|who's|what's|here's|there's|when's|where's|why's|how's|a|an|the|and|but|if|or|because|as|until|while|of|at|by|for|with|about|against|between|into|through|during|before|after|above|below|to|from|up|down|in|out|on|off|over|under|again|further|then|once|here|there|when|where|why|how|all|any|both|each|few|more|most|other|some|such|no|nor|not|only|own|same|so|than|too|very|webassign|'\w+</xsl:text>
    </xsl:param>
    
    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>
    
    <!-- 
        DESIRED XML STRUCTURE OF OUTPUT
        
        <topicindex>
            <stem value="assign" score="35" href="t_s_open_assignment.htm"/>
            <stem value="open" score="22" href="t_s_open_assignment.htm"/>
            ...
        </topicindex>
        
        Possibly also add @locations:
            - for each stem instance, get its position in the topic after stop words are removed
            - divide the position by a resolution (say, 10 words) and make an integer
            - combine all the positions for each stem in a topic, removing duplicates
            This attribute would help prioritize topics where multiple terms are near each other
            (within +/- 1 of another stem's @location)
    
    The repetitive hrefs will ease combining stem instances in the combined index
    
    -->
    
    <!-- === NODRAFT === -->
    
    <xsl:variable name="nodraft">
        <nodraft>
            <xsl:apply-templates select="/node()" mode="nodraft"/>
        </nodraft>
    </xsl:variable>
    
    <xsl:template match="*" mode="nodraft">
        <xsl:copy>
            <xsl:apply-templates select="node()|@class" mode="nodraft"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="text()" mode="nodraft">
        <xsl:param name="lowerwords">
            <!-- lowercase & strip out nonword characters -->
            <xsl:value-of select='concat("  ",replace(lower-case(.),"[^a-z&apos;]","  ")," ")'/>
        </xsl:param>
        <!-- strip stop words -->
        <xsl:value-of select="normalize-space(replace($lowerwords,concat('\s(',$stopwords,')\s'),' '))"/>
    </xsl:template>
    
    <xsl:template match="@class" mode="nodraft">
        <xsl:copy></xsl:copy>
    </xsl:template>
    
    <!-- remove stuff -->
    <xsl:template match="*[contains(@class,' topic/related-links ')]" mode="nodraft"></xsl:template>
    <xsl:template match="*[contains(@class,' topic/draft-comment ')]" mode="nodraft"></xsl:template>
    <xsl:template match="*[contains(@class,' topic/required-cleanup ')]" mode="nodraft"></xsl:template>
    <xsl:template match="processing-instruction()" mode="nodraft"></xsl:template>
    <xsl:template match="comment()" mode="nodraft"></xsl:template>
    
    
    
    <!-- === PARSE CLASSMAPS === -->
    
    <xsl:variable name="parseclassmaps">
        <xsl:call-template name="loop_through_classmaps"/>
    </xsl:variable>
    
    <xsl:template name="loop_through_classmaps">
        <xsl:param name="classmapcounter" select="$classmapcount"/>
        <xsl:param name="thisweight" select="$classmaps/classmap[position()=$classmapcounter]/@weight"/>
        <xsl:param name="thisclass" select="$classmaps/classmap[position()=$classmapcounter]/@ditaclass"/>
        <xsl:param name="thisfirst" select="$classmaps/classmap[position()=$classmapcounter]/@first or false()"/>
        <xsl:if test="not($classmapcounter = 0)">
            <xsl:choose>
                <xsl:when test="$thisfirst">
                    <xsl:apply-templates mode="getText" select="($nodraft//*[contains(@class,$thisclass)])[1]">
                        <xsl:with-param name="thisweight" select="$thisweight"/>
                    </xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates mode="getText" select="$nodraft//*[contains(@class,$thisclass)]">
                        <xsl:with-param name="thisweight" select="$thisweight"/>
                    </xsl:apply-templates>
                </xsl:otherwise>
            </xsl:choose>
            <!-- Oops! I did it again. -->
            <xsl:call-template name="loop_through_classmaps">
                <xsl:with-param name="classmapcounter">
                    <xsl:value-of select="$classmapcounter - 1"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <xsl:template mode="getText" match="*">
        <xsl:param name="thisweight"/>
        <xsl:apply-templates mode="getTextChildren" select="*|text()">
            <xsl:with-param name="thisweight" select="$thisweight"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template mode="getTextChildren" match="*">
        <xsl:param name="thisweight"/>
        <xsl:apply-templates mode="getTextChildren" select="*|text()">
            <xsl:with-param name="thisweight" select="$thisweight"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template mode="getTextChildren" match="text()">
        <xsl:param name="thisweight"/>
        <xsl:param name="textwordlist" select="tokenize(.,'\s+')"/>
        <xsl:for-each select="$textwordlist">
            <word>
                <xsl:attribute name="weight" select="$thisweight"/>
                <xsl:value-of select="."/>
            </word>
        </xsl:for-each>
        <!-- escape JSON characters (won't be needed after stripping out all but [az']) -->
        <!--<xsl:value-of select="replace(concat(replace(., '([&quot;\\])', '\\$1'),' '),'\s+',' ')"/>-->
    </xsl:template>
    
    
    <!-- === STEMMER === -->
    
    <xsl:variable name="stems">
        <xsl:apply-templates select="$parseclassmaps//word" mode="getStems"/>
    </xsl:variable>
    
    <xsl:function name="fn:getR1">
        <xsl:param name="thisword"/>
        <xsl:choose>
            <xsl:when test="matches($thisword,'^.*?[aeiouy][^aeiouy]')">
                <xsl:value-of  select="replace($thisword,'^.*?[aeiouy][^aeiouy]','')"/>
            </xsl:when>
            <xsl:otherwise><xsl:text></xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="fn:getShort">
        <xsl:param name="thisword"/>
        <xsl:value-of 
            select="fn:getR1($thisword)='' and (matches($thisword,'[^aeiouy][aeiouy][^aeiouywxY]$') or matches($thisword,'^[aeiouy][^aeiouy]$'))"/>
    </xsl:function>
    
    <xsl:template match="*" mode="getStems">
        <xsl:param name="word" select="replace(replace(./text(),'^y','Y'),'([aeiouy])y','$1Y')"/>
        <!--<xsl:param name="vowel"><xsl:text>[aeiouy]</xsl:text></xsl:param>
        <xsl:param name="consonant"><xsl:text>[bcdfghjklmnpqrstvwxYz']</xsl:text></xsl:param>-->
        <xsl:param name="R1" select="fn:getR1($word)">
            <!--<xsl:choose>
                <xsl:when test="matches($word,'^.*?[aeiouy][^aeiouy]')">
                    <xsl:value-of  select="replace($word,'^.*?[aeiouy][^aeiouy]','')"/>
                </xsl:when>
                <xsl:otherwise><xsl:text></xsl:text></xsl:otherwise>
            </xsl:choose>-->
        </xsl:param>
        <xsl:param name="R2" select="fn:getR1($R1)">
            <!--<xsl:choose>
                <xsl:when test="matches($R1,'^.*?[aeiouy][^aeiouy]')">
                    <xsl:value-of  select="replace($R1,'^.*?[aeiouy][^aeiouy]','')"/>
                </xsl:when>
                <xsl:otherwise><xsl:text></xsl:text></xsl:otherwise>
            </xsl:choose>-->
        </xsl:param>
        <xsl:param name="isShort" select="fn:getShort($word)"/>
        
        <xsl:param name="s0">
            <xsl:value-of select='replace($word,"&apos;s?&apos;?$","")'/>
        </xsl:param>
        <xsl:param name="s1a">
            <xsl:choose>
                <xsl:when test="matches($s0,'sses$')">
                    <xsl:value-of select="replace($s0,'sses$','')"/>
                </xsl:when>
                <xsl:when test="matches($s0,'(..)(ied|ies)$')">
                    <xsl:value-of select="replace($s0,'(..)(ied|ies)$','$1i')"/>
                </xsl:when>
                <xsl:when test="matches($s0,'(.)(ied|ies)$')">
                    <xsl:value-of select="replace($s0,'(.)(ied|ies)$','$1ie')"/>
                </xsl:when>
                <xsl:when test="matches($s0,'([aeiouy][^aeiouy].*)s$')">
                    <xsl:value-of select="replace($s0,'([aeiouy][^aeiouy].*)s$','$1')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$s0"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="s1b">
            <xsl:choose>
                <xsl:when test="matches($R1,'eed(ly)?$')">
                    <xsl:value-of select="replace($s1a,'eed(ly)?$','')"/>
                </xsl:when>
                <xsl:when test="matches($s1a,'([aeiouy].*(at|bl|iz))(ed|edly|ing|ingly)$')">
                    <xsl:value-of select="replace($s1a,'([aeiouy].*(at|bl|iz))(ed|edly|ing|ingly)$','$1e')"/>
                </xsl:when>
                <xsl:when test="matches($s1a,'([aeiouy].*(bb|dd|ff|gg|mm|nn|pp|rr|tt))(ed|edly|ing|ingly)$')">
                    <xsl:value-of select="replace($s1a,'([aeiouy].*).(ed|edly|ing|ingly)$','$1')"/>
                </xsl:when>
                <xsl:when test="matches($s1a,'([aeiouy].*)(ed|edly|ing|ingly)$')">
                    <xsl:choose>
                        <xsl:when test="fn:getShort(replace($s1a,'(ed|edly|ing|ingly)$',''))">
                            <xsl:value-of select="replace($s1a,'(ed|edly|ing|ingly)$','e')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="replace($s1a,'(ed|edly|ing|ingly)$','')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$s1a"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="s1c">
            <xsl:value-of select="replace($s1b,'(.[^aeiouy])[yY]$','$1i')"/>
        </xsl:param>
        <xsl:param name="s2" select="$word"/>
        <xsl:param name="s3" select="$word"/>
        <xsl:param name="s4" select="$word"/>
        <xsl:param name="s5" select="$word"/>
        <xsl:param name="finalstem">
            <xsl:choose>
                <xsl:when test="string-length($word)>2">
                    <xsl:value-of select="$s1c"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$word"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <stem>
            <xsl:attribute name="weight" select="./@weight"/>
            <xsl:attribute name="word" select="lower-case($word)"></xsl:attribute>
            <!--<xsl:attribute name="short" select="$isShort"></xsl:attribute>
            <xsl:attribute name="r1" select="$R1"></xsl:attribute>
            <xsl:attribute name="r2" select="$R2"></xsl:attribute>-->
            <xsl:value-of select="$finalstem"/>
        </stem>
    </xsl:template>
    
    
    
    <!-- === OUTPUT === -->
    
    <xsl:template match="/*"><!-- if nested topics, treat as one unit -->
        <!-- problems to figure out (maybe all handled with preprocessing?):
            * topics not in flat output file structure
            * copy-to 
             -->
        <!-- outer structure -->
        <topicindex>
            <xsl:copy-of select="$stems"/>
        </topicindex>
    </xsl:template>
    
    
    <!-- === UNUSED === -->
    
    
    
</xsl:stylesheet>