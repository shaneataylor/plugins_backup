<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    
    
    <!-- Add empty breadcrumbs div to top of topic if flag is set  -->
    <!-- Help system will generate breadcrumb content from currently loaded TOC. -->
    <xsl:template name="generateBreadcrumbs">
        <xsl:if test="$BREADCRUMBS='yes'">
            <div id="topic-breadcrumbs"></div>
        </xsl:if>
    </xsl:template>
    
    
</xsl:stylesheet>