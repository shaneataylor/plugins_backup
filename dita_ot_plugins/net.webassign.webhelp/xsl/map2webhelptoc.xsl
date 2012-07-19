<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:java="org.dita.dost.util.StringUtils"
    exclude-result-prefixes="java">

   <xsl:param name="INDEXER_LANGUAGE"/>

  <xsl:template name="generate-toc">
    <!-- OXYGEN PATCH START  EXM-18337 & EXM-18402 -->
    <xsl:variable name="toc">
      <xsl:apply-templates/>
    </xsl:variable>
    <xsl:variable name="mapTitle">
      <xsl:call-template name="generateMapTitle"/> <!-- Generate the <title> element -->
    </xsl:variable>
    <!-- OXYGEN PATCH END  EXM-18337 & EXM-18402 -->
    <html><xsl:value-of select="$newline"/>
    <head><xsl:value-of select="$newline"/>
      <xsl:if test="string-length($contenttarget)>0 and
  	        $contenttarget!='NONE'">
        <base target="{$contenttarget}"/>
        <xsl:value-of select="$newline"/>
      </xsl:if>
      <!-- initial meta information -->
      <xsl:call-template name="generateCharset"/>   <!-- Set the character set to UTF-8 -->
      <xsl:call-template name="generateDefaultCopyright"/> <!-- Generate a default copyright, if needed -->
      <xsl:call-template name="generateDefaultMeta"/> <!-- Standard meta for security, robots, etc -->
      <xsl:call-template name="copyright"/>         <!-- Generate copyright, if specified manually -->
      <xsl:call-template name="generateCssLinks"/>  <!-- Generate links to CSS files -->
      <!-- OXYGEN PATCH START EXM-18402 -->
      <xsl:copy-of select="$mapTitle"/>
      <!-- OXYGEN PATCH END EXM-18402 -->
      <xsl:call-template name="gen-user-head" />    <!-- include user's XSL HEAD processing here -->
      <xsl:call-template name="gen-user-scripts" /> <!-- include user's XSL javascripts here -->
      <xsl:call-template name="gen-user-styles" />  <!-- include user's XSL style element and content here -->
    </head><xsl:value-of select="$newline"/>
      <!-- Set viewport meta for iOS -->
      <meta content="width = device-width, height = device-height, initial-scale=1.0" name="viewport"/>
      
	  <!-- OXYGEN PATCH START EXM-17248 -->
      <xsl:element name="body">
        <xsl:choose>
          <xsl:when test="$CUSTOM_WEBHELP_SEARCH != 'yes'">
          <xsl:attribute name="onload">javascript:hideDiv('searchDiv','displayContentDiv');</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
            <xsl:attribute name="onload">checkTab()</xsl:attribute>            
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="string-length($OUTPUTCLASS) &gt; 0">
          <xsl:attribute name="class">
            <xsl:value-of select="$OUTPUTCLASS"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="generateMapTitleInBody"/>
        <xsl:if test="$CUSTOM_WEBHELP_SEARCH != 'yes' and not(starts-with($CUSTOM_WEBHELP_SEARCH,'google'))"><!-- was !='yes' -->
          <div id="contentAndSearchDiv">
            <div id="divContent" style="display:inline"><xsl:comment/></div>
            <!---->|<!---->
            <div id="divSearch" style="display:inline"><xsl:comment/></div>
          </div>
          
          <div id="searchDiv">
            <form name="searchForm" action="javascript:void(0)" onsubmit="Verifie('searchForm');">
              Keywords : <xsl:comment> </xsl:comment>
              <input type="text" id="textToSearch" name="textToSearch" class="textToSearch" size="30"/>
              <xsl:comment> </xsl:comment>
              <input type="button" value="Search" name="searchButton" class="searchButton"
                onclick="Verifie('searchForm');"/>
            </form>

            <div id="searchResults">
              <xsl:comment> </xsl:comment>
            </div>
          </div>
        </xsl:if>
        <xsl:if test="$CUSTOM_WEBHELP_SEARCH = 'google_student'"><!-- new section for google site search -->
          
          <div id="contentAndSearchDiv">
            <div id="google_search_form"><xsl:comment/></div>
            <div id="divContent" style="display:inline"><xsl:comment/></div>
            <!---->|<!---->
            <div id="divSearch" style="display:inline"><xsl:comment/></div>
          </div>
          
          <div id="searchDiv">
            <!-- Create search here -->
            
            <div id="google_search_results" style="width: 100%;">Loading</div>
            <script src="https://www.google.com/jsapi" type="text/javascript"><xsl:comment> </xsl:comment></script>
            <script type="text/javascript">
              
              google.load('search', '1', {language : 'en'});
              google.setOnLoadCallback(function() {
                // Use CSE
                var customSearchControl = new google.search.CustomSearchControl('007971622242349957768:_vlyaxcspak');
                
                // Put the search box in a different element
                var drawOptions = new google.search.DrawOptions();
                drawOptions.setSearchFormRoot(document.getElementById("google_search_form"));
                drawOptions.setAutoComplete(true);

                // Show search results tab
                 customSearchControl.setSearchStartingCallback(this, function() {
hideDiv('displayContentDiv','searchDiv');
});

                customSearchControl.setResultSetSize(google.search.Search.FILTERED_CSE_RESULTSET);
                customSearchControl.setLinkTarget("contentwin");
                customSearchControl.draw('google_search_results', drawOptions);
              }, true);
              
              
        </script>
          </div>
        </xsl:if>
        <xsl:if test="$CUSTOM_WEBHELP_SEARCH = 'google_instructor'"><!-- new section for google site search -->
          
          <div id="contentAndSearchDiv">
            <div id="google_search_form"><xsl:comment/></div>
            <div id="divContent" style="display:inline"><xsl:comment/></div>
            <!---->|<!---->
            <div id="divSearch" style="display:inline"><xsl:comment/></div>
          </div>
          
          <div id="searchDiv">
            <!-- Create search here -->
            <div id="google_search_results" style="width: 100%;">Loading</div>
            <script src="https://www.google.com/jsapi" type="text/javascript"><xsl:comment> </xsl:comment></script>
            <script type="text/javascript">
              
              google.load('search', '1', {language : 'en'});
              google.setOnLoadCallback(function() {
                // CSE Options
                var options = {'defaultToRefinement' : 'Instructors'};
                // Use CSE
                var customSearchControl = new google.search.CustomSearchControl('007971622242349957768:bdcsvwjjwci',options);
                
                // Put the search box in a different element
                var drawOptions = new google.search.DrawOptions();
                drawOptions.setSearchFormRoot(document.getElementById("google_search_form"));
                drawOptions.setAutoComplete(true);

                // Show search results tab
                 customSearchControl.setSearchStartingCallback(this, function() {
hideDiv('displayContentDiv','searchDiv');
});

                customSearchControl.setResultSetSize(google.search.Search.FILTERED_CSE_RESULTSET);
                customSearchControl.setLinkTarget("contentwin");
                // Restrict to instructor and student results
                // customSearchControl.setQueryAddition("more:Instructors OR more:Students");
                customSearchControl.draw('google_search_results', drawOptions);
              }, true);
              
              
        </script>
          </div>
        </xsl:if>
        <xsl:if test="$CUSTOM_WEBHELP_SEARCH = 'google_admin'"><!-- new section for google site search -->
          
          <div id="contentAndSearchDiv">
            <div id="google_search_form"><xsl:comment/></div>
            <div id="divContent" style="display:inline"><xsl:comment/></div>
            <!---->|<!---->
            <div id="divSearch" style="display:inline"><xsl:comment/></div>
          </div>
          
          <div id="searchDiv">
            <!-- Create search here -->
            <div id="google_search_results" style="width: 100%;">Loading</div>
            <script src="https://www.google.com/jsapi" type="text/javascript"><xsl:comment> </xsl:comment></script>
            <script type="text/javascript">
              
              google.load('search', '1', {language : 'en'});
              google.setOnLoadCallback(function() {
                // CSE Options
                var options = {'defaultToRefinement' : 'Admins'};
                // Use CSE
                var customSearchControl = new google.search.CustomSearchControl('007971622242349957768:bdcsvwjjwci',options);
                
                // Put the search box in a different element
                var drawOptions = new google.search.DrawOptions();
                drawOptions.setSearchFormRoot(document.getElementById("google_search_form"));
                drawOptions.setAutoComplete(true);

                // Show search results tab
                 customSearchControl.setSearchStartingCallback(this, function() {
hideDiv('displayContentDiv','searchDiv');
});

                customSearchControl.setResultSetSize(google.search.Search.FILTERED_CSE_RESULTSET);
                customSearchControl.setLinkTarget("contentwin");
                customSearchControl.draw('google_search_results', drawOptions);
              }, true);
              
              
        </script>
          </div>
        </xsl:if>
        <div id="displayContentDiv">
          <div class="contentsHeader">
            <a onclick="WA_expand_toc()" 
              title="Expand all entries in the Table of Contents">Expand All</a>  |  <a 
                onclick="WA_expand_toc('collapse')" 
                title="Collapse all entries in the Table of Contents">Collapse All</a>            
          </div>
          <div id="tab_nav_tree_placeholder">
            <div id="tab_nav_tree">
              <xsl:choose>
                <xsl:when test="$CUSTOM_WEBHELP_SEARCH != 'yes' and not(starts-with($CUSTOM_WEBHELP_SEARCH,'google'))"><!-- was !='yes' -->
                  <xsl:attribute name="class">visible_tab</xsl:attribute>  
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="class">hide</xsl:attribute>            
                </xsl:otherwise>
              </xsl:choose>
              <!-- OXYGEN PATCH END EXM-17248 -->
              <xsl:value-of select="$newline"/>
              <!-- OXYGEN PATCH START EXM-18337 -->
              <xsl:copy-of select="$toc"/>
              <!-- OXYGEN PATCH END EXM-18337 -->
              <!-- OXYGEN PATCH START EXM-17248 -->
            </div>
          </div>
        </div>
        <xsl:call-template name="gen-user-footer"/>
        <!-- OXYGEN PATCH END EXM-17248 -->
      </xsl:element><xsl:value-of select="$newline"/>
    </html>
    <!-- OXYGEN PATCH START EXM-18337 - Generate XHTML frameset with two frames: 
            Tabel of Contents in left rame and topic content in right frame. -->
    <xsl:result-document doctype-public="-//W3C//DTD XHTML 1.0 Frameset//EN" 
      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd"
      href="index.html" indent="yes" encoding="UTF-8" 
      xmlns:xhtml="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xhtml">
      <html>
        <head>
          <!-- OXYGEN PATCH START EXM-18402 -->
          <title><xsl:value-of select="normalize-space($mapTitle)"/></title>
          <!-- OXYGEN PATCH END EXM-18402 -->
          <link rel="stylesheet" type="text/css" href="commonltr.css" />
          <link rel="stylesheet" type="text/css" href="assets/webhelp_frameset.css" />
          <script type="text/javascript">
            <xsl:comment xml:space="preserve">            
            function getHTMLPage(){
               var currentPage = "<xsl:value-of select="($toc/ul[1]//li/a[@href])[1]/@href"/>";
               var page = window.location.search.substr(1);
      
               if (page != ""){
                page = page.split("=");
                if (page[0] == 'q') currentPage = page[1];
               }
               
               return currentPage;
            }
            //</xsl:comment>
          </script>
        </head>
        <!-- Set viewport meta for iOS -->
        <meta content="width = device-width, height = device-height, initial-scale=1.0" name="viewport"/>
        <frameset cols="25%,*" onload="frames.contentwin.location = getHTMLPage()"> 
          <frame name="tocwin" id="tocwin" src="{$TOC_FILE_NAME}" title="Table of contents and search"/>
          <frame name="contentwin" id="contentwin" src="{($toc/ul[1]//li/a[@href])[1]/@href}" title="Help topic"/>
        </frameset>
      </html>
    </xsl:result-document>
    <!-- OXYGEN PATCH END EXM-18337 -->
  </xsl:template>
  
  <xsl:template name="generateMapTitleInBody">
      <!-- from map2htmltoc.xsl, added h1's -->
      <!--<xsl:choose>
        <xsl:when test="/*[contains(@class,' map/map ')]/*[contains(@class,' topic/title ')]">
          <h1>
            <xsl:value-of select="normalize-space(/*[contains(@class,' map/map ')]/*[contains(@class,' topic/title ')])"/>
          </h1>          
        </xsl:when>
        <xsl:when test="/*[contains(@class,' map/map ')]/@title">
          <h1>
            <xsl:value-of select="/*[contains(@class,' map/map ')]/@title"/>
          </h1>
        </xsl:when>
      </xsl:choose>-->
      <xsl:value-of select="$newline"/>
      <!-- end -->
      <xsl:if test="$CUSTOM_WEBHELP_SEARCH = 'yes'">
        <div id="nav_tree_and_search">
          <xsl:processing-instruction name="php"> $_GET['P'] = "<xsl:value-of
            select="$CUSTOM_PHP_SEARCH_TARGET"/>"; include($_SERVER['DOCUMENT_ROOT']."/site-commons/php/userguide_search_dita.php");  </xsl:processing-instruction>
        </div>
        <xsl:value-of select="$newline"/>
      </xsl:if>
  </xsl:template>
    
  <xsl:template match="/*[contains(@class, ' map/map ')]">
    <xsl:param name="pathFromMaplist"/>
    <xsl:if test=".//*[contains(@class, ' map/topicref ')][not(@toc='no')][not(@processing-role='resource-only')]">
      <!-- OXYGEN PATCH START EXM-17248 -->
      <ul id="tree"><xsl:value-of select="$newline"/>
        <!-- OXYGEN PATCH END EXM-17248 -->
        
        <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]">
          <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
        </xsl:apply-templates>
      </ul><xsl:value-of select="$newline"/>
    </xsl:if>
  </xsl:template>
  
    
  <xsl:template match="*[contains(@class, ' map/topicref ')][not(@toc='no')][not(@processing-role='resource-only')]">
    <xsl:param name="pathFromMaplist"/>
    <xsl:variable name="title">
      <xsl:call-template name="navtitle"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$title and $title!=''">
        <!-- OXYGEN PATCH START EXM-17960 -->
        <li id="{generate-id()}">
        <!-- OXYGEN PATCH END EXM-17960 -->
          <xsl:choose>
            <!-- If there is a reference to a DITA or HTML file, and it is not external: -->
            <xsl:when test="@href and not(@href='')">
              <xsl:element name="a">
                <xsl:attribute name="href">
                  <xsl:choose>        <!-- What if targeting a nested topic? Need to keep the ID? -->
                    <!-- edited by william on 2009-08-06 for bug:2832696 start -->
                    <xsl:when test="contains(@copy-to, $DITAEXT) and not(contains(@chunk, 'to-content')) and 
                      (not(@format) or @format = 'dita' or @format='ditamap' ) ">
                    <!-- edited by william on 2009-08-06 for bug:2832696 end -->
                      <xsl:if test="not(@scope='external')"><xsl:value-of select="$pathFromMaplist"/></xsl:if>
                      <!-- added by William on 2009-11-26 for bug:1628937 start-->
                      <xsl:value-of select="java:getFileName(@copy-to,$DITAEXT)"/>
                      <!-- added by William on 2009-11-26 for bug:1628937 end-->
                      <xsl:value-of select="$OUTEXT"/>
                      <xsl:if test="not(contains(@copy-to, '#')) and contains(@href, '#')">
                        <xsl:value-of select="concat('#', substring-after(@href, '#'))"/>
                      </xsl:if>
                    </xsl:when>
                    <!-- edited by william on 2009-08-06 for bug:2832696 start -->
                    <xsl:when test="contains(@href,$DITAEXT) and (not(@format) or @format = 'dita' or @format='ditamap')">
                    <!-- edited by william on 2009-08-06 for bug:2832696 end -->
                      <xsl:if test="not(@scope='external')"><xsl:value-of select="$pathFromMaplist"/></xsl:if>
                      <!-- added by William on 2009-11-26 for bug:1628937 start-->
                      <!--xsl:value-of select="substring-before(@href,$DITAEXT)"/-->
                      <xsl:value-of select="java:getFileName(@href,$DITAEXT)"/>
                      <!-- added by William on 2009-11-26 for bug:1628937 end-->
                      <xsl:value-of select="$OUTEXT"/>
                      <xsl:if test="contains(@href, '#')">
                        <xsl:value-of select="concat('#', substring-after(@href, '#'))"/>
                      </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>  <!-- If non-DITA, keep the href as-is -->
                      <xsl:if test="not(@scope='external')"><xsl:value-of select="$pathFromMaplist"/></xsl:if>
                      <xsl:value-of select="@href"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:if test="@scope='external' or @type='external' or ((@format='PDF' or @format='pdf') and not(@scope='local'))">
                  <xsl:attribute name="target">_blank</xsl:attribute>
                </xsl:if>
                <xsl:value-of select="$title"/>
              </xsl:element>
            </xsl:when>
            
            <xsl:otherwise>
              <xsl:value-of select="$title"/>
            </xsl:otherwise>
          </xsl:choose>
          
          <!-- If there are any children that should be in the TOC, process them -->
          <xsl:if test="descendant::*[contains(@class, ' map/topicref ')][not(contains(@toc,'no'))][not(@processing-role='resource-only')]">
            <xsl:value-of select="$newline"/><ul><xsl:value-of select="$newline"/>
              <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]">
                <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
              </xsl:apply-templates>
            </ul><xsl:value-of select="$newline"/>
          </xsl:if>
        </li><xsl:value-of select="$newline"/>
      </xsl:when>
      <xsl:otherwise>
        <!-- if it is an empty topicref -->
        <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]">
          <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>
  
  <xsl:template name="gen-user-footer">
    <!-- OXYGEN PATCH START EXM-17248 -->
    <!-- map footer -->
    <div class="footer">
      <!-- OXYGEN PATCH START EXM-17248 -->
      <xsl:value-of select="$WEBHELP_COPYRIGHT"/>
      <!-- OXYGEN PATCH END EXM-17248 -->
      
    </div>
    
    <script type="text/javascript">
      <xsl:comment> <![CDATA[
  	$(function() {
  			$("#tree").treeview({
  				collapsed: true,
  				animated: "fast",
  				control:"#sidetreecontrol",
  				persist: "location"
  		});
  	});
    function select(){
      selectLink(this.parentNode.id);
    }  	     
    
function getHTMLPage2Expand(url){
      var page = url.substr(1);
      currentPage = page;
      page = parent.location.search.substr(1).split("&");
      for (x in page) {
        var q;
        q = page[x].split("=");;
        if(q[0] == 'q'){
         currentPage = q[1];
        }
      }
      return currentPage;
   }
   
    var aElements = document.getElementById(tree).getElementsByTagName("a");
    var i;
    var pathPrefix = parent.location.pathname;
    var expandPage = getHTMLPage2Expand(parent.contentwin.location.pathname);
    expandPage = expandPage.replace(pathPrefix, "");
    for (i = 0; i< aElements.length; i++){
      aElements[i].onclick = select;
    }
    if(parent.location.search != ''){ 
      setTimeout('expandToTopic(window.location.href, expandPage)',200);
    }
//]]></xsl:comment>
  	</script>
    <!-- OXYGEN PATCH END EXM-17248 -->
    <xsl:apply-templates select="." mode="gen-user-footer"/>
  </xsl:template>
  
  <xsl:template match="/|node()|@*" mode="gen-user-scripts">
    <!-- OXYGEN PATCH START EXM-17248 -->
    <script type="text/javascript" src="{$PATH2PROJ}assets/jquery-1.4.2.js">
      <xsl:comment></xsl:comment>
    </script>
    <script type="text/javascript" src="{$PATH2PROJ}assets/jquery-ui-1.8.2.custom.min.js">
      <xsl:comment></xsl:comment>
    </script>
    <script type="text/javascript" src="{$PATH2PROJ}assets/jquery.treeview.js">
      <xsl:comment></xsl:comment>    
    </script>
    <xsl:if test="$CUSTOM_WEBHELP_SEARCH != 'yes' and not(starts-with($CUSTOM_WEBHELP_SEARCH,'google'))"><!-- was !='yes' -->

      <script type="text/javascript" src="{$PATH2PROJ}search/htmlFileList.js">
        <xsl:comment></xsl:comment>    
      </script>
      <script type="text/javascript" src="{$PATH2PROJ}search/htmlFileInfoList.js">
        <xsl:comment></xsl:comment>    
      </script>
      <script type="text/javascript" src="{$PATH2PROJ}search/nwSearchFnt.js">
        <xsl:comment></xsl:comment>    
      </script>
      <script type="text/javascript" src="{$PATH2PROJ}search/stemmers/{$INDEXER_LANGUAGE}_stemmer.js">
        <xsl:comment></xsl:comment>
      </script>
      <script type="text/javascript" src="{$PATH2PROJ}search/index-1.js">
        <xsl:comment></xsl:comment>
      </script>
      <script type="text/javascript" src="{$PATH2PROJ}search/index-2.js">
        <xsl:comment></xsl:comment>
      </script>
      <script type="text/javascript" src="{$PATH2PROJ}search/index-3.js">
        <xsl:comment></xsl:comment>
      </script>
    </xsl:if>
    <script src="{$PATH2PROJ}assets/webhelp.js" type="text/javascript">
      <xsl:comment></xsl:comment>
    </script>
      <!-- Add WebAssign functions -->
    <script src="{$PATH2PROJ}assets/webassign.js" type="text/javascript">
      <xsl:comment></xsl:comment>
    </script>
    <!-- WebHelp is not working on Chrome, so do not delete this import -->
    <script src="{$PATH2PROJ}assets/browserDetect.js" type="text/javascript">
      <xsl:comment></xsl:comment>
    </script>    
    <!-- OXYGEN PATCH END EXM-17248 -->
  </xsl:template>
  
  <xsl:template match="/|node()|@*" mode="gen-user-styles">
    <!-- OXYGEN PATCH START EXM-17248 -->
    <link href="{$PATH2PROJ}assets/jquery.treeview.css" type="text/css" rel="stylesheet"/>
    <link href="{$PATH2PROJ}assets/webhelp_toc.css" type="text/css" rel="stylesheet"/>
    <link href="{$PATH2PROJ}assets/jquery.treeview.addon.css" type="text/css" rel="stylesheet"/>
    <!-- OXYGEN PATCH END EXM-17248 -->
  </xsl:template>
</xsl:stylesheet>