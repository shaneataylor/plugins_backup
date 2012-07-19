<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../../../xsl/dita2xhtml.xsl"/>
  <xsl:import href="dita2webhelpImpl.xsl"/>

  <xsl:param name="CUSTOM_RATE_PAGE_URL" select="''"/>
  <xsl:param name="CUSTOM_BASEDIR" select="''"/>
  <xsl:param name="CUSTOM_WEBHELP_SEARCH" select="''"/>
  
  <xsl:output method="xml" encoding="UTF-8"
    indent="no"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
    omit-xml-declaration="yes"/>
</xsl:stylesheet>