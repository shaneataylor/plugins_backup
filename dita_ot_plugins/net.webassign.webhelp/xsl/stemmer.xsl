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
        <xsl:text>i|me|my|myself|we|our|ours|ourselves|you|your|yours|yourself|yourselves|he|him|his|himself|she|her|hers|herself|it|its|itself|they|them|their|theirs|themselves|what|which|who|whom|this|that|these|those|am|is|are|was|were|be|been|being|have|has|had|having|do|does|did|doing|would|should|could|ought|i'm|you're|he's|she's|it's|we're|they're|i've|you've|we've|they've|i'd|you'd|he'd|she'd|we'd|they'd|i'll|you'll|he'll|she'll|we'll|they'll|isn't|aren't|wasn't|weren't|hasn't|haven't|hadn't|doesn't|don't|didn't|won't|wouldn't|shan't|shouldn't|can't|cannot|couldn't|mustn't|let's|that's|who's|what's|here's|there's|when's|where's|why's|how's|a|an|the|and|but|if|or|because|as|until|while|of|at|by|for|with|about|against|between|into|through|during|before|after|above|below|to|from|up|down|in|out|on|off|over|under|again|further|then|once|here|there|when|where|why|how|all|any|both|each|few|more|most|mostly|other|some|such|no|nor|not|only|own|same|so|than|too|very|webassign</xsl:text>
    </xsl:param>
    
    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>
    
    <xsl:variable name="apos">'</xsl:variable>
    
    <!-- 
        Possibly also add @locations:
            - for each stem instance, get its position in the topic after stop words are removed
            - divide the position by a resolution (say, 10 words) and make an integer
            - combine all the positions for each stem in a topic, removing duplicates
            This attribute would help prioritize topics where multiple terms are near each other
            (within +/- 1 of another stem's @location)
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
        <stems>
            <xsl:apply-templates select="$parseclassmaps//word" mode="getStems"/>
        </stems>
    </xsl:variable>
    
    <xsl:function name="fn:R1" as="xs:string">
        <xsl:param name="thisword"/>
        <xsl:choose>
            <xsl:when test="matches($thisword,'^(gener|commun|arsen)')">
                <xsl:value-of select="replace($thisword,'^(gener|commun|arsen)','')"/>
            </xsl:when>
            <xsl:when test="matches($thisword,'^.*?[aeiouy][^aeiouy]')">
                <xsl:value-of  select="replace($thisword,'^.*?[aeiouy][^aeiouy]','')"/>
            </xsl:when>
            <xsl:otherwise><xsl:text></xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="fn:R2" as="xs:string">
        <xsl:param name="thisword"/>
        <xsl:value-of select="fn:R1(fn:R1($thisword))"/>
    </xsl:function>
    
    <xsl:function name="fn:endsWithShortSyllable" as="xs:boolean">
        <xsl:param name="thisword"/>
        <xsl:value-of select="(matches($thisword,'[^aeiouy][aeiouy][^aeiouywxY]$') or matches($thisword,'^[aeiouy][^aeiouy]$'))"/>
    </xsl:function>
    
    <xsl:function name="fn:isShort" as="xs:boolean">
        <xsl:param name="thisword"/>
        <xsl:value-of 
            select="string-length(fn:R1($thisword))=0 and fn:endsWithShortSyllable($thisword)"/>
    </xsl:function>
    
    <xsl:template match="*" mode="getStems">
        
        <!-- 
        Problems noticed in current version:
        word       should be  is          example vocabulary wrong?
        ===========================================================================
        ied        i          ie          maybe
        fluently   fluentli   fluent      maybe
        congeners  congen     congener
        
        -->
        <xsl:param name="word" select="lower-case(./text())"/>
        
        <xsl:param name="noinitpostrophes" select="replace($word,concat('^',$apos),'')"/>
        
        <xsl:param name="consonantY" select="replace($noinitpostrophes,'(^|[aeiouy])y','$1Y')"/>
        
        <xsl:param name="s0_sfxs">('|'s|'s')$</xsl:param>
        
        <xsl:param name="s0" select="replace($consonantY,$s0_sfxs,'')"/>
        
        <xsl:param name="s1a">
            <xsl:choose>
                <xsl:when test="matches($s0,'sses$')">
                    <xsl:value-of select="replace($s0,'sses$','ss')"/>
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
                <xsl:when test="matches($s0,'[aeiouy].+s$')">
                    <xsl:value-of select="replace($s0,'s$','')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$s0"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        
        <xsl:param name="s1b_sfx">
            <!-- relies on greedy matching -->
            <xsl:value-of select="concat(replace($s1a,'^.*?(eed|eedly|ed|edly|ing|ingly)$','$1'),'$')"/>
        </xsl:param>
        
        <xsl:param name="s1b_base">
            <xsl:value-of select="replace($s1a,concat('(.)',$s1b_sfx),'$1')"/>
        </xsl:param>
        
        <xsl:param name="s1b">
            <!-- "ied" as a word might be an error in the Porter2 sample -->
            <xsl:choose>
                <xsl:when test="string-length($s1b_sfx)=1">
                    <xsl:value-of select="$s1a"/>
                </xsl:when>
                <xsl:when test="($s1b_sfx='eed$' or $s1b_sfx='eedly$') and matches(fn:R1($s1a),$s1b_sfx)">
                    <xsl:value-of select="concat($s1b_base,'ee')"/>
                </xsl:when>
                <xsl:when test="not($s1b_sfx='eed$' or $s1b_sfx='eedly$') and matches($s1a,concat('[aeiouy].*',$s1b_sfx))">
                    <xsl:choose>
                        <xsl:when test="matches($s1b_base,'(at|bl|iz)$')">
                            <xsl:value-of select="concat($s1b_base,'e')"/>
                        </xsl:when>
                        <xsl:when test="matches($s1b_base,'(bb|dd|ff|gg|mm|nn|pp|rr|tt)$')">
                            <xsl:value-of select="replace($s1b_base,'.$','')"/>
                        </xsl:when>
                        <xsl:when test="fn:isShort($s1b_base)">
                            <xsl:value-of select="concat($s1b_base,'e')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$s1b_base"/>
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
                <xsl:when test="string-length($s2match)!=0 and contains(fn:R1($s1c),$s2match)">
                    <xsl:value-of select="replace($s1c,concat($s2match,'$'),$s2replace)"/>
                </xsl:when>
                <xsl:when test="ends-with($s1c,'logi') and contains(fn:R1($s1c),'ogi')">
                    <xsl:value-of select="replace($s1c,'ogi$','og')"/>
                </xsl:when>
                <xsl:when test="ends-with(fn:R1($s1c),'li') and matches($s1c,'[cdeghkmnrt]li$')">
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
                <xsl:when test="string-length($s3match)!=0 and contains(fn:R1($s2),$s3match)">
                    <xsl:value-of select="replace($s2,concat($s3match,'$'),$s3replace)"/>
                </xsl:when>
                <xsl:when test="ends-with($s2,'ative') and contains(fn:R1($s2),'ative') and contains(fn:R2($s2),'ative')">
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
                <xsl:when test="string-length($s4match)!=0 and contains(fn:R2($s3),$s4match)">
                    <xsl:value-of select="replace($s3,concat($s4match,'$'),$s4replace)"/>
                </xsl:when>
                <xsl:when test="matches($s3,'[st]ion$') and contains(fn:R2($s3),'ion')">
                    <xsl:value-of select="replace($s3,'ion$','')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$s3"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        
        <xsl:param name="s4DropE" select="replace($s4,'e$','')"/>
        
        <xsl:param name="s5">
            <xsl:choose>
                <xsl:when test="ends-with($s4,'e')">
                    <xsl:choose>
                        <xsl:when test="string-length(fn:R2($s4))!=0">
                            <xsl:value-of select="$s4DropE"/>
                        </xsl:when>
                        <xsl:when 
                            test="ends-with(fn:R1($s4),'e') and not(fn:endsWithShortSyllable($s4DropE))">
                            <xsl:value-of select="$s4DropE"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$s4"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="ends-with($s4,'ll')">
                    <xsl:choose>
                        <xsl:when test="ends-with(fn:R2($s4),'l')">
                            <xsl:value-of select="replace($s4,'ll$','l')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$s4"/>
                        </xsl:otherwise>
                    </xsl:choose>
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
                    <xsl:value-of select="$word"/>
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
            <xsl:attribute name="word" select="$word"/>
            <xsl:attribute name="tbs" select="."/>
            <xsl:message>
                <xsl:value-of select="concat(substring(concat(./text(),'                                                  '),1,50),$finalstem)"/>
            </xsl:message>
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
                <xsl:attribute name="words" select="string-join(current-group()/@word,',')"/>
                <xsl:attribute name="tbs" select="string-join(current-group()/@tbs,',')"/>
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
        
        <xsl:copy-of select="$allstems"/>
        <!--<xsl:copy-of select="$stems"/>-->
    </xsl:template>
    
    
    <!-- === UNUSED === -->
    
    
    
</xsl:stylesheet>