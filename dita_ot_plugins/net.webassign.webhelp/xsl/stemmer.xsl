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
    <xsl:param name="thishref" select="replace($thisindextarget,'\.xml$',$outext)"/>
    
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
        <xsl:param name="noinitpostrophes">
            <!-- remove apostrophes used to quote a word or at the start of a word -->
            <xsl:value-of select='replace(replace($lowerwords," &apos;([a-z]*)&apos; "," $1 ")," &apos;"," ")'/>
        </xsl:param>
        <!-- strip stop words -->
        <xsl:value-of select="normalize-space(replace($noinitpostrophes,concat('\s(',$stopwords,')\s'),' '))"/>
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
        <stems>
            <xsl:apply-templates select="$parseclassmaps//word" mode="getStems"/>
        </stems>
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
        
        <xsl:param name="R1">
            <xsl:choose>
                <xsl:when test="matches($word,'^(gener|commun|arsen)')">
                    <xsl:value-of select="replace($word,'^(gener|commun|arsen)','')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="fn:getR1($word)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        
        <xsl:param name="R2" select="fn:getR1($R1)"/>
        
        <xsl:param name="isShort" select="fn:getShort($word)"/>
        
        <xsl:param name="s0" select='replace($word,"&apos;s?&apos;?$","")'/>
        
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
                <xsl:when test="matches($s0,'(us|ss)$')">
                    <xsl:value-of select="$s0"/>
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
        
        <xsl:param name="s2replacements">
            <replace suffix="ational" with="ate"/>
            <replace suffix="ization" with="ize" />
            <replace suffix="fulness" with="ful" />
            <replace suffix="ousness" with="ous" />
            <replace suffix="iveness" with="ive" />
            <replace suffix="tional" with="tion"/>
            <replace suffix="biliti" with="ble" />
            <replace suffix="lessli" with="less" />
            <replace suffix="entli" with="ent" />
            <replace suffix="ation" with="ate" />
            <replace suffix="alism" with="al" />
            <replace suffix="aliti" with="al" />
            <replace suffix="ousli" with="ous" />
            <replace suffix="iviti" with="ive" />
            <replace suffix="fulli" with="ful" />
            <replace suffix="enci" with="ence"/>
            <replace suffix="anci" with="ance"/>
            <replace suffix="abli" with="able"/>
            <replace suffix="izer" with="ize" />
            <replace suffix="ator" with="ate" />
            <replace suffix="alli" with="al" />
            <replace suffix="bli" with="ble" />
        </xsl:param>
        
        <xsl:param name="s2match" select="$s2replacements/replace[ends-with($s1c,@suffix)][1]/@suffix"/>
        
        <xsl:param name="s2replace" select="$s2replacements/replace[ends-with($s1c,@suffix)][1]/@with"/>
        
        <xsl:param name="s2">
            <xsl:choose>
                <xsl:when test="string-length($s2match)!=0 and contains($R1,$s2match)">
                    <xsl:value-of select="replace($s1c,concat($s2match,'$'),$s2replace)"/>
                </xsl:when>
                <xsl:when test="ends-with($s1c,'logi') and contains($R1,'ogi')">
                    <xsl:value-of select="replace($s1c,'ogi$','og')"/>
                </xsl:when>
                <xsl:when test="matches($s1c,'[cdeghkmnrt]li$') and contains($R1,'ogi')">
                    <xsl:value-of select="replace($s1c,'li$','')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$s1c"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        
        <xsl:param name="s3replacements">
            <replace suffix="ational" with="ate"/>
            <replace suffix="tional" with="tion"/>
            <replace suffix="alize" with="al"/>
            <replace suffix="icate" with="ic"/>
            <replace suffix="iciti" with="ic"/>
            <replace suffix="ical" with="ic"/>
            <replace suffix="ness" with=""/>
            <replace suffix="ful" with=""/>
        </xsl:param>
        
        <xsl:param name="s3match" select="$s3replacements/replace[ends-with($s2,@suffix)][1]/@suffix"/>
        
        <xsl:param name="s3replace" select="$s3replacements/replace[ends-with($s2,@suffix)][1]/@with"/>
        
        <xsl:param name="s3">
            <xsl:choose>
                <xsl:when test="string-length($s3match)!=0 and contains($R1,$s3match)">
                    <xsl:value-of select="replace($s2,concat($s3match,'$'),$s3replace)"/>
                </xsl:when>
                <xsl:when test="ends-with($s2,'ative') and contains($R1,'ative') and contains($R2,'ative')">
                    <xsl:value-of select="replace($s2,'ative$','')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$s2"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        
        <xsl:param name="s4replacements">
            <replace suffix="ement" with=""/>
            <replace suffix="ance" with=""/>
            <replace suffix="ence" with=""/>
            <replace suffix="able" with=""/>
            <replace suffix="ible" with=""/>
            <replace suffix="ment" with=""/>
            <replace suffix="ant" with=""/>
            <replace suffix="ent" with=""/>
            <replace suffix="ism" with=""/>
            <replace suffix="ate" with=""/>
            <replace suffix="iti" with=""/>
            <replace suffix="ous" with=""/>
            <replace suffix="ive" with=""/>
            <replace suffix="ize" with=""/>
            <replace suffix="ic" with=""/>
            <replace suffix="er" with=""/>
            <replace suffix="al" with=""/>
        </xsl:param>
        
        <xsl:param name="s4match" select="$s4replacements/replace[ends-with($s3,@suffix)][1]/@suffix"/>
        
        <xsl:param name="s4replace" select="$s4replacements/replace[ends-with($s3,@suffix)][1]/@with"/>
        
        <xsl:param name="s4">
            <xsl:choose>
                <xsl:when test="string-length($s4match)!=0 and contains($R2,$s4match)">
                    <xsl:value-of select="replace($s3,concat($s4match,'$'),$s4replace)"/>
                </xsl:when>
                <xsl:when test="matches($s3,'[st]ion$') and contains($R2,'ion')">
                    <xsl:value-of select="replace($s3,'ion$','')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$s3"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        
        <xsl:param name="beforeR1">
            <xsl:choose>
                <xsl:when test="string-length($R1)=0">
                    <xsl:value-of select="$word"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="replace($word,concat($R1,'$'),'')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        
        <xsl:param name="R1precededByShort">
            <xsl:value-of select="matches($beforeR1,'([^aeiouy][aeiouy][^aeiouywxY]|^[aeiouy][^aeiouy])')"/>
            
        </xsl:param>
        
        <xsl:param name="s5">
            <xsl:choose>
                <!-- The following two tests might select too liberally 
                     since they don't specify WHICH e or ll is found in R1 or R2  -->
                <xsl:when 
                    test="ends-with($s4,'e') and (contains($R2,'e') or (contains($R1,'e') and not($R1precededByShort)))">
                    <xsl:value-of select="replace($s4,'e$','')"/>
                </xsl:when>
                <xsl:when test="ends-with($s4,'l') and contains($R2,'ll')">
                    <xsl:value-of select="replace($s4,'l$','')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$s4"/>
                </xsl:otherwise>
            </xsl:choose>
            
        </xsl:param>
        
        <xsl:param name="exceptionlist">
            <exception word="skis" stem="ski" />
            <exception word="skies" stem="sky" />
            <exception word="dying" stem="die" />
            <exception word="lying" stem="lie" />
            <exception word="tying" stem="tie" />
            <exception word="idly" stem="idl" />
            <exception word="gently" stem="gentl" />
            <exception word="ugly" stem="ugli" />
            <exception word="early" stem="earli" />
            <exception word="only" stem="onli" />
            <exception word="singly" stem="singl" />
            <!-- don't change -->
            <exception word="sky" stem="sky" />
            <exception word="news" stem="news" />
            <exception word="howe" stem="howe" />
            <exception word="atlas" stem="atlas" />
            <exception word="cosmos" stem="cosmos" />
            <exception word="bias" stem="bias" />
            <exception word="andes" stem="andes" />
        </xsl:param>
        
        <xsl:param name="exceptionstem" select="$exceptionlist/exception[@word=$word][1]/@stem"/>
        
        <xsl:param name="finalstem">
            <xsl:choose>
                <xsl:when test="string-length($word) &lt;= 2">
                    <xsl:value-of select="lower-case($word)"/>
                </xsl:when>
                <xsl:when test="string-length($exceptionstem)!=0">
                    <xsl:value-of select="$exceptionstem"/>
                </xsl:when>
                <xsl:when test="matches($s1a,'^(inning|outing|canning|herring|earring|proceed|exceed|succeed)$')">
                    <xsl:value-of select="$s1a"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="lower-case($s5)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        
        <stem>
            <xsl:attribute name="value" select="$finalstem"/>
            <xsl:attribute name="weight" select="./@weight"/>
            <!--<xsl:attribute name="word" select="lower-case($word)"></xsl:attribute>
            <xsl:attribute name="R1precededByShort" select="$R1precededByShort"></xsl:attribute>
            <xsl:attribute name="R1" select="$R1"></xsl:attribute>
            <xsl:attribute name="R2" select="$R2"></xsl:attribute>-->
        </stem>
    </xsl:template>
    
    
    <!-- === COMBINE STEMS FOR TOPIC === -->
    
    <xsl:variable name="allstems">
        <xsl:apply-templates select="$stems" mode="combinestems"/>
    </xsl:variable>
    
    <xsl:template match="//stems" mode="combinestems">
        <xsl:for-each-group select="//stem" group-by="@value">
            <xsl:sort select="@value"/>
            <stem>
                <xsl:attribute name="value" select="current-grouping-key()"/>
                <xsl:attribute name="score" select="sum(current-group()/@weight)"/>
                <xsl:attribute name="href" select="$thishref"/>
            </stem>
        </xsl:for-each-group>
    </xsl:template>
    
    
    <!-- === OUTPUT === -->
    
    <xsl:template match="/*"><!-- if nested topics, treat as one unit -->
        <!-- problems to figure out (maybe all handled with preprocessing?):
            * topics not in flat output file structure
            * copy-to 
            * topics used as resource
             -->
        <!-- outer structure -->
        <!--<topicindex>
            <xsl:attribute name="href" select="$thishref"/>
            <xsl:copy-of select="$allstems"/>
        </topicindex>-->
        <xsl:copy-of select="$allstems"/>
    </xsl:template>
    
    
    <!-- === UNUSED === -->
    
    
    
</xsl:stylesheet>