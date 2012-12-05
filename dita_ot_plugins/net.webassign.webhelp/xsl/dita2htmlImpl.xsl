<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="../../../xsl/xslhtml/dita2htmlImpl.xsl"/>


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
    <xsl:choose>
      <xsl:when test="$isSVG">
        <!--<object data="file.svg" type="image/svg+xml" width="500" height="200">-->
        <!-- now invoke the actual content and its alt text -->
        <embed>
          <xsl:call-template name="commonattributes">
            <xsl:with-param name="default-output-class">
              <xsl:if test="@placement='break'">
                <!--Align only works for break-->
                <xsl:choose>
                  <xsl:when test="@align='left'">imageleft</xsl:when>
                  <xsl:when test="@align='right'">imageright</xsl:when>
                  <xsl:when test="@align='center'">imagecenter</xsl:when>
                </xsl:choose>
              </xsl:if>
            </xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="setid"/>
          <xsl:attribute name="src"><xsl:value-of select="@href"/></xsl:attribute>
          <xsl:apply-templates select="@height|@width"/>
        </embed>
      </xsl:when>
      <xsl:otherwise>
        <img>
          <xsl:call-template name="commonattributes">
            <xsl:with-param name="default-output-class">
              <xsl:if test="@placement='break'"><!--Align only works for break-->
                <xsl:choose>
                  <xsl:when test="@align='left'">imageleft</xsl:when>
                  <xsl:when test="@align='right'">imageright</xsl:when>
                  <xsl:when test="@align='center'">imagecenter</xsl:when>
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
          <!-- Add by Alan for Bug:#2900417 on Date: 2009-11-23 begin -->
          <xsl:apply-templates select="@scale"/>
          <!-- Add by Alan for Bug:#2900417 on Date: 2009-11-23 end   -->
          <xsl:choose>
            <xsl:when test="*[contains(@class,' topic/alt ')]">
              <xsl:variable name="alt-content"><xsl:apply-templates select="*[contains(@class,' topic/alt ')]" mode="text-only"/></xsl:variable>
              <xsl:attribute name="alt"><xsl:value-of select="normalize-space($alt-content)"/></xsl:attribute>
            </xsl:when>
            <xsl:when test="@alt">
              <xsl:attribute name="alt"><xsl:value-of select="@alt"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="output-message">
                <!-- need to add message definition in plugin -->
                <xsl:with-param name="msgnum">099</xsl:with-param>
                <xsl:with-param name="msgsev">W</xsl:with-param>
                <xsl:with-param name="msgparams"></xsl:with-param>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </img>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*[contains(@class,' topic/alt ')]">
    <xsl:apply-templates select="." mode="text-only"/>
  </xsl:template>

</xsl:stylesheet>