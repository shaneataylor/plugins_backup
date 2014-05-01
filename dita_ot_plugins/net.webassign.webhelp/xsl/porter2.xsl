<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:porter2="http://example.com/namespace"
    exclude-result-prefixes="xs porter2"
    version="2.0">
    
    <!-- Static variables -->
    
    <xsl:variable name="porter2:apos">'</xsl:variable>
    
    <xsl:variable name="porter2:nonwordchars">[^a-z']</xsl:variable>
    
    <xsl:variable name="porter2:s0_sfxs">('|'s|'s')$</xsl:variable>
    
    <xsl:variable name="porter2:s1a_exceptionlist">^(inning|outing|canning|herring|earring|proceed|exceed|succeed)$</xsl:variable>
    
    <!-- 
        
        Replacements sets
        
        Use the following attributes & define processing accordingly
        
        @ifprecededby    : suffix must be preceded by pattern to do replacement
        @ifin            : (tokenized list of "R1" or "R2") suffix must be in specified region to do replacement 
        @complexrule     : identifies a complex replacement rule to use
        
    -->
    <xsl:variable name="porter2:s1a_replacements">
        <replacements>
            <!-- ordered longest to shortest -->
            <replace suffix="sses" with="ss"/>
            <replace suffix="ied" with="i|ie" complexrule="s1a_ied_ies"/>
            <replace suffix="ies" with="i|ie" complexrule="s1a_ied_ies"/>
            <replace suffix="us" with="us"/>
            <replace suffix="ss" with="ss"/>
            <replace suffix="s" with="" ifprecededby="[aeiouy].+"/>
        </replacements>
    </xsl:variable>
    
    
    <xsl:template mode="porter2:replace_suffix" match="//replacements">
        <xsl:param name="thisword" as="xs:string"/>
        <xsl:param name="ismatch" as="xs:boolean" 
            select="1=count(./replace[matches($thisword,concat(@suffix,'$'))][1])"/>
        <xsl:param name="replace"
            select="./replace[matches($thisword,concat(@suffix,'$'))][1]"/>
        <xsl:param name="restrictions">
            <xsl:if test="contains($replace/@ifin,'R1')"><xsl:text>R1</xsl:text></xsl:if>
            <xsl:if test="contains($replace/@ifin,'R2')"><xsl:text>R2</xsl:text></xsl:if>
            <xsl:if test="string-length($replace/@ifprecededby)>0"><xsl:text>PrecededBy</xsl:text></xsl:if>
            <xsl:if test="string-length($replace/@complexrule)>0">
                <xsl:text>ComplexRule_</xsl:text>
                <xsl:value-of select="$replace/@complexrule"/>
            </xsl:if>
        </xsl:param>
        
        <xsl:choose>
            <xsl:when test="not($ismatch)">
                <xsl:value-of select="$thisword"/>
            </xsl:when>
            
        <!-- no restrictions -->
            <xsl:when test="string-length($restrictions)=0">
                <xsl:value-of select="replace($thisword,concat($replace/@suffix,'$'),$replace/@with)"/>
            </xsl:when>
        <!-- single restrictions -->
            <xsl:when test="$restrictions='R1' and ends-with(porter2:R1($thisword),$replace/@suffix)">
                <xsl:value-of select="replace($thisword,concat($replace/@suffix,'$'),$replace/@with)"/>
            </xsl:when>
            
            <xsl:when test="$restrictions='R2' and ends-with(porter2:R2($thisword),$replace/@suffix)">
                <xsl:value-of select="replace($thisword,concat($replace/@suffix,'$'),$replace/@with)"/>
            </xsl:when>
            
            <xsl:when test="$restrictions='PrecededBy' and matches($thisword,concat($replace/@ifprecededby,$replace/@suffix))">
                <xsl:value-of select="replace($thisword,concat($replace/@suffix,'$'),$replace/@with)"/>
            </xsl:when>
            
            <xsl:when test="$restrictions='ComplexRule_s1a_ied_ies'">
                <xsl:choose>
                    <xsl:when test="matches($thisword,'(..)(ied|ies)$')">
                        <xsl:value-of select="replace($thisword,'(ied|ies)$','i')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="replace($thisword,'(ied|ies)$','ie')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
        <!-- combinations -->
            
            
            <xsl:otherwise>
                <xsl:value-of select="$thisword"/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    
    <xsl:variable name="porter2:s2replacements">
        <!-- ordered longest to shortest -->
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
    </xsl:variable>
    
    <xsl:variable name="porter2:s3replacements">
        <!-- ordered longest to shortest -->
        <replace suffix="ational" with="ate"/>
        <replace suffix="tional" with="tion"/>
        <replace suffix="alize" with="al"/>
        <replace suffix="icate" with="ic"/>
        <replace suffix="iciti" with="ic"/>
        <replace suffix="ical" with="ic"/>
        <replace suffix="ness" with=""/>
        <replace suffix="ful" with=""/>
    </xsl:variable>
    
    <xsl:variable name="porter2:s4replacements">
        <!-- ordered longest to shortest -->
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
    </xsl:variable>
    
    <xsl:variable name="porter2:exceptionlist">
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
    </xsl:variable>
    
    
    <!-- Definitions -->
    
    <xsl:function name="porter2:R1base" as="xs:string">
        <xsl:param name="thisword" as="xs:string"/>
        <xsl:param name="exceptions" as="xs:boolean"/>
        <xsl:choose>
            <xsl:when test="$exceptions and matches($thisword,'^(gener|commun|arsen)')">
                <xsl:value-of select="replace($thisword,'^(gener|commun|arsen)','')"/>
            </xsl:when>
            <xsl:when test="matches($thisword,'^.*?[aeiouy][^aeiouy]')">
                <xsl:value-of  select="replace($thisword,'^.*?[aeiouy][^aeiouy]','')"/>
            </xsl:when>
            <xsl:otherwise><xsl:text></xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="porter2:R1" as="xs:string">
        <xsl:param name="thisword" as="xs:string"/>
        <!-- R1base with exceptions -->
        <xsl:value-of select="porter2:R1base($thisword,true())"/>
    </xsl:function>
    
    <xsl:function name="porter2:R2" as="xs:string">
        <xsl:param name="thisword" as="xs:string"/>
        <xsl:value-of select="porter2:R1base(porter2:R1($thisword),false())"/>
    </xsl:function>
    
    <xsl:function name="porter2:endsWithShortSyllable" as="xs:boolean">
        <xsl:param name="thisword" as="xs:string"/>
        <xsl:value-of select="(matches($thisword,'[^aeiouy][aeiouy][^aeiouywxY]$') or matches($thisword,'^[aeiouy][^aeiouy]$'))"/>
    </xsl:function>
    
    <xsl:function name="porter2:isShort" as="xs:boolean">
        <xsl:param name="thisword" as="xs:string"/>
        <xsl:value-of 
            select="string-length(porter2:R1($thisword))=0 and porter2:endsWithShortSyllable($thisword)"/>
    </xsl:function>
    <!--
    <!-\- Preprocessing -\->
    
    <xsl:function name="porter2:bareword" as="xs:string">
        <xsl:param name="thisword" as="xs:string"/>
        <xsl:value-of select="replace(lower-case($thisword),$porter2:nonwordchars,'')"/>
    </xsl:function>
    
    <xsl:function name="porter2:noinitpostrophes" as="xs:string">
        <xsl:param name="thisword" as="xs:string"/>
        <xsl:value-of select="replace(porter2:bareword($thisword),concat('^',$porter2:apos),'')"/>
    </xsl:function>
    
    <xsl:function name="porter2:consonantY" as="xs:string">
        <xsl:param name="thisword" as="xs:string"/>
        <xsl:value-of select="replace(porter2:noinitpostrophes($thisword),'(^|[aeiouy])y','$1Y')"></xsl:value-of>
    </xsl:function>
    
    <!-\- Steps -\->
    
    <xsl:function name="porter2:s0" as="xs:string">
        <xsl:param name="thisword" as="xs:string"/>
        <xsl:value-of select="replace(porter2:consonantY($thisword),$porter2:s0_sfxs,'')"/>
    </xsl:function>
    
    <xsl:function name="porter2:s1a" as="xs:string">
        <xsl:param name="thisword" as="xs:string"/>
        <xsl:value-of select="porter2:replacesfx(porter2:s0($thisword),$porter2:s1a_replacements)"/>
    </xsl:function>
    
    -->
    
    <xsl:function name="porter2:stem" as="xs:string">
        <xsl:param name="thisword" as="xs:string"/>
        <xsl:apply-templates select="porter2:word2node($thisword)" mode="porter2:getStem"/>
    </xsl:function>
    
    <xsl:function name="porter2:word2node" as="node()">
        <xsl:param name="thisword" as="xs:string"/>
        <word><xsl:value-of select="$thisword"/></word>
    </xsl:function>
    
    
    <xsl:template match="*" mode="porter2:getStem">
        
        <xsl:param name="word" select="lower-case(./text())"/>
        
        <xsl:param name="noinitpostrophes" select="replace($word,concat('^',$porter2:apos),'')"/>
        
        <xsl:param name="consonantY" select="replace($noinitpostrophes,'(^|[aeiouy])y','$1Y')"/>
        
        <xsl:param name="s0" select="replace($consonantY,$porter2:s0_sfxs,'')"/>
        
        <xsl:param name="s1a">
            <xsl:apply-templates select="$porter2:s1a_replacements" mode="porter2:replace_suffix">
                <xsl:with-param name="thisword" select="$s0"/>
            </xsl:apply-templates>
        </xsl:param>
        
        <xsl:param name="s1b_sfx">
            <!-- relies on greedy matching to get longest suffix -->
            <xsl:value-of select="concat(replace($s1a,'^.*?(eed|eedly|ed|edly|ing|ingly)$','$1'),'$')"/>
        </xsl:param>
        
        <xsl:param name="s1b_base">
            <xsl:value-of select="replace($s1a,concat('(.)',$s1b_sfx),'$1')"/>
        </xsl:param>
        
        <xsl:param name="s1b">
            <xsl:choose>
                <xsl:when test="string-length($s1b_sfx)=1">
                    <xsl:value-of select="$s1a"/>
                </xsl:when>
                <xsl:when test="($s1b_sfx='eed$' or $s1b_sfx='eedly$') and matches(porter2:R1($s1a),$s1b_sfx)">
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
                        <xsl:when test="porter2:isShort($s1b_base)">
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
        
        <xsl:param name="s2match" select="$porter2:s2replacements/replace[ends-with($s1c,@suffix)][1]/@suffix"/>
        
        <xsl:param name="s2replace" select="$porter2:s2replacements/replace[ends-with($s1c,@suffix)][1]/@with"/>
        
        <xsl:param name="s2">
            <xsl:choose>
                <xsl:when test="string-length($s2match)!=0 and contains(porter2:R1($s1c),$s2match)">
                    <xsl:value-of select="replace($s1c,concat($s2match,'$'),$s2replace)"/>
                </xsl:when>
                <xsl:when test="string-length($s2match)!=0">
                    <!-- don't attempt further s2 replacements -->
                    <xsl:value-of select="$s1c"/>
                </xsl:when>
                <xsl:when test="ends-with($s1c,'logi') and contains(porter2:R1($s1c),'ogi')">
                    <xsl:value-of select="replace($s1c,'ogi$','og')"/>
                </xsl:when>
                <xsl:when test="ends-with(porter2:R1($s1c),'li') and matches($s1c,'[cdeghkmnrt]li$')">
                    <xsl:value-of select="replace($s1c,'li$','')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$s1c"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        
        <xsl:param name="s3match" select="$porter2:s3replacements/replace[ends-with($s2,@suffix)][1]/@suffix"/>
        
        <xsl:param name="s3replace" select="$porter2:s3replacements/replace[ends-with($s2,@suffix)][1]/@with"/>
        
        <xsl:param name="s3">
            <xsl:choose>
                <xsl:when test="string-length($s3match)!=0 and contains(porter2:R1($s2),$s3match)">
                    <xsl:value-of select="replace($s2,concat($s3match,'$'),$s3replace)"/>
                </xsl:when>
                <xsl:when test="ends-with($s2,'ative') and contains(porter2:R1($s2),'ative') and contains(porter2:R2($s2),'ative')">
                    <xsl:value-of select="replace($s2,'ative$','')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$s2"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        
        <xsl:param name="s4match" select="$porter2:s4replacements/replace[ends-with($s3,@suffix)][1]/@suffix"/>
        
        <xsl:param name="s4replace" select="$porter2:s4replacements/replace[ends-with($s3,@suffix)][1]/@with"/>
        
        <xsl:param name="s4">
            <xsl:choose>
                <xsl:when test="string-length($s4match)!=0 and contains(porter2:R2($s3),$s4match)">
                    <xsl:value-of select="replace($s3,concat($s4match,'$'),$s4replace)"/>
                </xsl:when>
                <xsl:when test="matches($s3,'[st]ion$') and contains(porter2:R2($s3),'ion')">
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
                        <xsl:when test="string-length(porter2:R2($s4))!=0">
                            <xsl:value-of select="$s4DropE"/>
                        </xsl:when>
                        <xsl:when 
                            test="ends-with(porter2:R1($s4),'e') and not(porter2:endsWithShortSyllable($s4DropE))">
                            <xsl:value-of select="$s4DropE"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$s4"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="ends-with($s4,'ll')">
                    <xsl:choose>
                        <xsl:when test="ends-with(porter2:R2($s4),'l')">
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
        
        <xsl:param name="exceptionstem" select="$porter2:exceptionlist/exception[@word=$word][1]/@stem"/>
        
        <xsl:param name="finalstem">
            <xsl:choose>
                <xsl:when test="string-length($word) &lt;= 2">
                    <xsl:value-of select="$word"/>
                </xsl:when>
                <xsl:when test="string-length($exceptionstem)!=0">
                    <xsl:value-of select="$exceptionstem"/>
                </xsl:when>
                <xsl:when test="matches($s1a,$porter2:s1a_exceptionlist)">
                    <xsl:value-of select="$s1a"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="lower-case($s5)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        
        <xsl:value-of select="$finalstem"/>
        
    </xsl:template>    
    
</xsl:stylesheet>