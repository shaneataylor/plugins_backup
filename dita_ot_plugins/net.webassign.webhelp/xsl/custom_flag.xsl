<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="1.0" 
  xmlns:exsl="http://exslt.org/common" 
  xmlns:dita2html="http://dita-ot.sourceforge.net/ns/200801/dita2html"
  xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
  exclude-result-prefixes="exsl dita2html ditamsg">

 <xsl:template match="prop" mode="start-flagit">  
  <xsl:choose> <!-- Ensure there's an image to get, otherwise don't insert anything -->
   <xsl:when test="startflag/@imageref">
    <xsl:variable name="imgsrc" select="startflag/@imageref"/>
    <img>
     <xsl:attribute name="src">
      <xsl:if test="string-length($PATH2PROJ) > 0"><xsl:value-of select="$PATH2PROJ"/></xsl:if>
      <!-- 
       <xsl:call-template name="get-file-name">
       <xsl:with-param name="file-path" select="$imgsrc"/>
       </xsl:call-template>
      -->
      <xsl:value-of select="$imgsrc"/>
     </xsl:attribute>
     <xsl:if test="startflag/alt-text">
      <xsl:attribute name="alt">
       <xsl:value-of select="startflag/alt-text"/>
      </xsl:attribute>
     </xsl:if>     
    </img>
   </xsl:when>
   <xsl:when test="startflag/alt-text">
    <b><xsl:value-of select="startflag/alt-text"/></b>
   </xsl:when>
   <xsl:when test="@img">
    <!-- output the flag -->
    <xsl:variable name="imgsrc" select="@img"/>    
    <img>
     <xsl:attribute name="src">
      <xsl:if test="string-length($PATH2PROJ) > 0"><xsl:value-of select="$PATH2PROJ"/></xsl:if>
      <!--
       <xsl:call-template name="get-file-name">
       <xsl:with-param name="file-path" select="$imgsrc"/>
       </xsl:call-template>
      -->
      <xsl:value-of select="$imgsrc"/>
     </xsl:attribute>
     <xsl:attribute name="alt"> <!-- always insert an ALT - if it's blank, assume the user didn't want to fill it. -->
      <xsl:value-of select="@alt"/>
     </xsl:attribute>
    </img>
   </xsl:when>
   <xsl:otherwise/> <!-- that flag not active -->
  </xsl:choose>
  <xsl:apply-templates select="following-sibling::prop[1]" mode="start-flagit"/>
 </xsl:template>
 
</xsl:stylesheet>