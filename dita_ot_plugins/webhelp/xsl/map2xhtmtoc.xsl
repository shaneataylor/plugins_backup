<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="../../../xsl/map2xhtmtoc.xsl"/>
  <xsl:import href="map2webhelptoc.xsl"/>

  <xsl:param name="CUSTOM_WEBHELP_SEARCH" select="'no'"/>
  <xsl:param name="CUSTOM_PHP_SEARCH_TARGET" select="'SVN'"/>
  <xsl:param name="WEBHELP_COPYRIGHT"/>
  <xsl:param name="TOC_FILE_NAME" select="'toc.html'"/>
  
  <xsl:output method="xml" encoding="UTF-8"
	indent="no"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
	doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
    omit-xml-declaration="yes"/>
</xsl:stylesheet>