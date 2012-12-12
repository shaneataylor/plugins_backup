<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:dita2html="http://dita-ot.sourceforge.net/ns/200801/dita2html"
  xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
  xmlns:exsl="http://exslt.org/common"
  xmlns:java="org.dita.dost.util.ImgUtils"
  xmlns:url="org.dita.dost.util.URLUtils"
  exclude-result-prefixes="dita-ot dita2html ditamsg exsl java url">

  <xsl:include href="../../../xsl/common/output-message.xsl"/>

  <xsl:template match="*[contains(@class,' topic/image ')]">
    <xsl:choose>
      <xsl:when test="*[contains(@class,' topic/alt ')]"></xsl:when>
      <xsl:when test="@alt"></xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="output-message">
          <xsl:with-param name="msgnum">099</xsl:with-param>
          <xsl:with-param name="msgsev">W</xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="topic.image"/>
  </xsl:template>

</xsl:stylesheet>