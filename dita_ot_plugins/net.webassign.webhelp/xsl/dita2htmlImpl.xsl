<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- Add redirect script to every topic -->
    <xsl:template name="gen-user-header">
        <script type="text/javascript" ><xsl:comment><![CDATA[
if (typeof h5Url == 'undefined') { // won't run if help system loaded topic
   var urlparts=window.location.pathname.split("/"); 
   var thistopic=urlparts.pop();
   var baseurl=urlparts.join("/");
   var newurl = baseurl + "?q=" + thistopic;
   if ( !!(window.history && history.pushState) ) {
      window.history.replaceState(null,null, newurl);
   }
   window.location=newurl;
}
]]></xsl:comment></script>
    </xsl:template>
    
    <!-- Add empty breadcrumbs div to top of topic if flag is set  -->
    <!-- Help system will generate breadcrumb content from currently loaded TOC. -->
    <xsl:template name="generateBreadcrumbs">
        <xsl:if test="$BREADCRUMBS='yes'">
            <div class="topic-breadcrumbs"></div>
        </xsl:if>
    </xsl:template>
    
    
</xsl:stylesheet>