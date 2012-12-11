<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:File="java:java.io.File" 
  xmlns:XSLTExtensionIOUtil="java:ro.sync.io.XSLTExtensionIOUtil"
  exclude-result-prefixes="File XSLTExtensionIOUtil">

  <xsl:import href="../../webhelp/xsl/rel-links.xsl"/>

  <xsl:template match="/|node()|@*" mode="gen-user-header">
    <!-- OXYGEN PATCH START -->
    <!-- Header navigation -->
    <table class="nav">
      <tbody>
        <tr>
          <!--<td>
            <div class="navheader">
                <span class="frames" onclick="redirectFrames(location.pathname)">
                  <script type="text/javascript">
                    <xsl:comment>
  if (parent.window.location.pathname == window.location.pathname ) document.write('With Frames');                    
                    </xsl:comment>
                  </script>
                </span>
              <xsl:call-template name="oxygenCustomHeaderAndFooter"/>
            </div>
          </td>-->
          <td>
            <xsl:if test="count(descendant::*[contains(@class, ' topic/link ')][@role='parent']) = 1">
              <xsl:variable name="parentTopic" select="document(descendant::*[contains(@class, ' topic/link ')][@role='parent'][1]/@href)"/>
              <xsl:if test="count($parentTopic//*[contains(@class, ' topic/link ')][@role='parent']) = 1">            
                <!-- Link to parent of parent. -->
                <xsl:variable name="parentOfParentTopic" select="$parentTopic//*[contains(@class, ' topic/link ')][@role='parent'][1]"/>
                <xsl:variable name="base-uri" select="document-uri(/)"/>
                <xsl:for-each select="$parentOfParentTopic">
                  <xsl:call-template name="makelink">
                    <!-- Shane (12/30/11): This version from Oxygen is dependent on other libraries
                      and fails when run in the DITA-OT. -->
                    <!--<xsl:with-param name="final-path"
                      tunnel="yes"
                      select="XSLTExtensionIOUtil:getAbsolutePath($base-uri, document-uri(/), @href)"
                      />-->
                    <!-- Shane (12/30/11):
                      This simpler version works so long as the relative path from the current topic
                      is the same as the relative path from the parent topic. 
                      For our topics, that is currently true. -->
                    <xsl:with-param name="final-path"
                      tunnel="yes"
                      select="@href"
                    />
                  </xsl:call-template>
                </xsl:for-each>
                <xsl:text> / </xsl:text>
              </xsl:if>
              <!-- Link to parent. -->
              <xsl:for-each select="descendant::*[contains(@class, ' topic/link ')][@role='parent']">
                <xsl:call-template name="makelink"/>
              </xsl:for-each>
            </xsl:if>
          </td>
        </tr>
      </tbody>
    </table>
    
    
    
    
    <!-- WebAssign header -->
    
    <!-- prevent Google indexing of header -->
    <xsl:text>
      
    </xsl:text>
    <xsl:comment>googleoff: all</xsl:comment>
    <div class="webassign_header">
      <script type="text/javascript" language="JavaScript" src="assets/webassign.js"><xsl:text> </xsl:text></script>
      <img src="assets/images/webassign_help_logo_16pt.png" alt="WebAssign Help"
        style="position: absolute; left: 10px; top: 3px;"/>
      <a class="actionlink framesaction" id="WA_showtoc" onclick="WA_showtoc()" alt="Show contents frame"
        title="Show contents frame">
        <img src="assets/images/application_side_list.png" /><span> Show Topics</span>
      </a>
      <a class="actionlink noframesaction" id="WA_hidetoc" onclick="WA_hidetoc()" alt="Hide contents frame. You can access the contents and search at the bottom of the topic."
        title="Hide contents frame. You can access the contents and search at the bottom of the topic.">
        <img src="assets/images/application_view_list.png" /><span> Hide Topics</span>
      </a>
      <a class="actionlink printaction" onclick="WA_printtopic()" alt="Print topic" title="Print topic">
        <img src="assets/images/printer.png" /><span> Print</span>
      </a>
      <!-- Direct CS link based on role -->
      <xsl:choose>
        <xsl:when test="$CUSTOM_WEBHELP_SEARCH = 'google_instructor'">
          <a class="actionlink csaction" onclick="WA_csform_instructor()" alt="Contact Customer Support" title="Contact Customer Support" >
            <img src="assets/images/email.png" /><span> Customer Support</span>
          </a>
        </xsl:when>
        <xsl:when test="$CUSTOM_WEBHELP_SEARCH = 'google_student'">
          <a class="actionlink csaction" onclick="WA_csform_student()" alt="Contact Customer Support" title="Contact Customer Support" >
            <img src="assets/images/email.png" /><span> Customer Support</span>
          </a>
        </xsl:when>
        <xsl:when test="$CUSTOM_WEBHELP_SEARCH = 'google_admin'">
          <!-- for now, not implementing admin cs form or javascript; using mailto: -->
          <!-- use script & break up link with underscores to resist spambots -->
          <script type="text/javascript" language="JavaScript"><xsl:comment> <![CDATA[ 
          var cslink="'m_a_i_l_t_o_:_integration_req_uests_@_w_ebassign_._n_e_t'";
          document.write("<a class='actionlink csaction' alt='Contact Customer Support' title='Contact Customer Support' href=" + cslink.replace(/_/g,"") + "><img src='assets/images/email.png' /><span> Customer Support</span></a>");
        // ]]> </xsl:comment></script>

          
        </xsl:when>
        <xsl:otherwise> </xsl:otherwise>
      </xsl:choose>


      <!-- Show feedback link only for instructors -->
      <xsl:if test="$CUSTOM_WEBHELP_SEARCH = 'google_instructor'">
        <a class="actionlink feedbackaction" onclick="WA_togglefeedback()">
          <img src="assets/images/page_white_edit.png" alt="Send a comment or correction for this topic"
            title="Send a comment or correction for this topic" /><span> Topic Feedback</span>
        </a>
      </xsl:if>

    </div>
    
    <!-- Include feedback div only for instructors -->
    <xsl:if test="$CUSTOM_WEBHELP_SEARCH = 'google_instructor'">
      <div class="feedback_drawer" id="feedback_drawer">
        <form action="https://docs.google.com/a/webassign.net/spreadsheet/formResponse?formkey=dFNOTVNGVXNTTTRaOF9zd3gybmNlQ2c6MQ" method="post" id="feedback_form" title="Documentation Feedback"  target="_new">
          <!-- 
            Google form field names must be set here. IE does not allow JS to change the name later.
            Update if the form field names change.
            
            ['feedback_topic','entry.0.single'],
            ['feedback_name','entry.1.single'],
            ['feedback_email','entry.2.single'],
            ['feedback_comment','entry.4.single'],
            ['feedback_status_text','entry.3.single'],
            ['feedback_rating_text','entry.5.single']
            
          -->
          <p>Use this form to send a comment or correction for this help topic.<br/>To request help or
            report a problem, click <b>Customer Support</b>.</p>
          
          <div class="formField">
            <label for="feedback_name">Full name</label>
            <input type="text" id="feedback_name" name="entry.1.single" tabindex="0" />
          </div>
          
          <div class="formField">
            <label for="feedback_email">Email address (required)</label>
            <input type="text" id="feedback_email" name="entry.2.single" tabindex="0" onchange="WA_validatefeedback()"
              onblur="WA_validatefeedback()"/>
            <span id="feedback_err_email" class="feedback_err"> </span>
          </div>
          
          <div class="formField">
            <label for="feedback_status_text">Role</label>
            <input type="text" id="feedback_status_text" name="entry.3.single" tabindex="0" onchange="WA_validatefeedback()" onblur="WA_validatefeedback()" value="Instructor"/>
          </div>
          
          <div class="formField">
            <label for="feedback_comment">Comment</label>
            <textarea id="feedback_comment" name="entry.4.single" rows="8" cols="60" tabindex="0"><xsl:text> </xsl:text> </textarea>
          </div>
          <fieldset>
            <legend>Rate this topic</legend>
            <input value="Very Poor" type="radio" name="feedback_rating" id="feedback_very_poor"/>
            <xsl:text> </xsl:text><label for="feedback_very_poor">Very Poor</label>
            <input value="Poor" type="radio" name="feedback_rating" id="feedback_poor"/>
            <xsl:text> </xsl:text><label for="feedback_poor">Poor</label>
            <input value="OK" type="radio" name="feedback_rating" id="feedback_ok"/>
            <xsl:text> </xsl:text><label for="feedback_ok">OK</label>
            <input value="Good" type="radio" name="feedback_rating" id="feedback_good"/>
            <xsl:text> </xsl:text><label for="feedback_good">Good</label>
            <input value="Very Good" type="radio" name="feedback_rating" id="feedback_very_good"/>
            <xsl:text> </xsl:text><label for="feedback_very_good">Very Good</label>
            <input type="hidden" id="feedback_rating_text" name="entry.5.single"></input>
          </fieldset>
          <input id="feedback_topic" name="entry.0.single" type="hidden"/>
          <div class="formField">
            <!-- Must use input tag for IE rather than button. Otherwise, sends the content of the tag rather than @value -->
            <input type="submit" name="submit" value="Submit" disabled="disabled" 
              id="feedback_submit" onclick="WA_submitfeedback();"/><xsl:text> </xsl:text>
            <input type="button" value="Cancel" onclick="WA_hidefeedback()"/>
          </div>
        </form>
        
        <xsl:comment><![CDATA[<form id="ss-form" name="ss-form" action="https://docs.google.com/a/webassign.net/spreadsheet/formResponse?formkey=dFNOTVNGVXNTTTRaOF9zd3gybmNlQ2c6MQ&amp;ifq" method="post" target="_new"> </form>]]></xsl:comment>
        
      </div>
    </xsl:if>
    <script type="text/javascript" language="JavaScript"><xsl:comment> <![CDATA[ 
        WA_init();
        // ]]> </xsl:comment></script>
    
    <!-- resume Google indexing -->
    <xsl:comment>googleon: all</xsl:comment>
    
    
    
    
    
    
    
    
    <!-- End WebAssign header -->
    
  </xsl:template>

  <xsl:template name="oxygenCustomHeaderAndFooter">
    <xsl:for-each select="descendant::*[contains(@class, ' topic/link ')][@role='parent' or
      @role='previous' or @role='next']">

      <xsl:variable name="textLinkBefore">
        <span class="navheader_label">
          <xsl:choose>
            <xsl:when test="@role = 'parent'">
              <xsl:text>Up</xsl:text>
            </xsl:when>
            <xsl:when test="@role = 'previous'">
              <xsl:text>Previous</xsl:text>
            </xsl:when>
            <xsl:when test="@role = 'next'">
              <xsl:text>Next</xsl:text>
            </xsl:when>
          </xsl:choose>
        </span>
        <span class="navheader_separator">
          <xsl:text>: </xsl:text>
        </span>
      </xsl:variable>
      
      <xsl:call-template name="makelink">
        <xsl:with-param name="label" select="$textLinkBefore"/>
      </xsl:call-template>
      <xsl:text>  </xsl:text>
<!--      <xsl:if test="@role = 'next'">
        <br />
      </xsl:if>
-->    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="generateCssLinks">
    <xsl:variable name="childlang">
      <xsl:choose>
        <!-- Update with DITA 1.2: /dita can have xml:lang -->
        <xsl:when test="self::dita[not(@xml:lang)]">
          <xsl:for-each select="*[1]"><xsl:call-template name="getLowerCaseLang"/></xsl:for-each>
        </xsl:when>
        <xsl:otherwise><xsl:call-template name="getLowerCaseLang"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="direction">
      <xsl:apply-templates select="." mode="get-render-direction">
        <xsl:with-param name="lang" select="$childlang"/>
      </xsl:apply-templates>
    </xsl:variable>
    <xsl:variable name="urltest"> <!-- test for URL -->
      <xsl:call-template name="url-string">
        <xsl:with-param name="urltext">
          <xsl:value-of select="concat($CSSPATH,$CSS)"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="($direction='rtl') and ($urltest='url') ">
        <link rel="stylesheet" type="text/css" href="{$CSSPATH}{$bidi-dita-css}" />
      </xsl:when>
      <xsl:when test="($direction='rtl') and ($urltest='')">
        <link rel="stylesheet" type="text/css" href="{$PATH2PROJ}{$CSSPATH}{$bidi-dita-css}" />
      </xsl:when>
      <xsl:when test="($urltest='url')">
        <link rel="stylesheet" type="text/css" href="{$CSSPATH}{$dita-css}" />
      </xsl:when>
      <xsl:otherwise>
        <link rel="stylesheet" type="text/css" href="{$PATH2PROJ}{$CSSPATH}{$dita-css}" />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="$newline"/>
    
    <!-- OXYGEN PATCH START EXM-20707 -->
    <link rel="stylesheet" type="text/css" href="{$PATH2PROJ}assets/webhelp_topic.css"/>
    <xsl:value-of select="$newline"/>
    <!-- OXYGEN PATCH END EXM-20707 -->
    
    <!-- Add user's style sheet if requested to -->
    <xsl:if test="string-length($CSS)>0">
      <xsl:choose>
        <xsl:when test="$urltest='url'">
          <link rel="stylesheet" type="text/css" href="{$CSSPATH}{$CSS}" />
        </xsl:when>
        <xsl:otherwise>
          <link rel="stylesheet" type="text/css" href="{$PATH2PROJ}{$CSSPATH}{$CSS}" />
        </xsl:otherwise>
      </xsl:choose><xsl:value-of select="$newline"/>
    </xsl:if>
  </xsl:template>
  
  
  <xsl:template match="/|node()|@*" mode="gen-user-footer">
    <!-- OXYGEN PATCH START -->
    <!-- Footer navigation -->
    <div class="navfooter">
      <xsl:call-template name="oxygenCustomHeaderAndFooter"/>
      <script type="text/javascript">
      <xsl:comment> <![CDATA[        
    function expand(){
        parent.tocwin.expandToTopic(window.location.href, this.getAttribute('href'));
    }
    var aArray = document.getElementsByTagName('a');
    var i;
    for (i = 0; i< aArray.length; i++){
      // add test to avoid errors for <a> with no href or href starting with "javascript"
      if ( aArray[i].href.search(/^(?!javascript)\S+/gi) > -1 ) {
        aArray[i].onclick = expand;
      }
    }
//]]></xsl:comment>
  </script>      
    </div>
    <!--<xsl:if test="string-length($CUSTOM_RATE_PAGE_URL) > 0">
      <div class="rate_page">
        <div id="rate_stars">
          <span><b>Rate this page</b>:</span> 
          <ul class="stars">
            <li><a href="#rate_stars" id="star1" onclick='setRate(this.id, this.title);' title="Not helpful">&#160;</a></li>
            <li><a href="#rate_stars" id="star2" onclick='setRate(this.id, this.title);' title="Somewhat helpful" class="">&#160;</a></li>
            <li><a href="#rate_stars" id="star3" onclick='setRate(this.id, this.title);' title="Helpful" class="">&#160;</a></li>
            <li><a href="#rate_stars" id="star4" onclick='setRate(this.id, this.title);' title="Very helpful" class="">&#160;</a></li>
            <li><a href="#rate_stars" id="star5" onclick='setRate(this.id, this.title);' title="Solved my problem" class="">&#160;</a></li>
          </ul>
        </div>
        <div id="rate_comment" class="hide">
          <span class="small">Optional Comment:</span><br/>
          <form name="contact" method="post" action="" enctype="multipart/form-data">
            <textarea rows='2' cols='20' name="feedback" id="feedback" class="text-input"><xsl:text> </xsl:text></textarea><br/>
            <input type="submit" name="submit" class="button" id="submit_btn" value="Send feedback" />
          </form>
        </div>
      </div>
    </xsl:if>-->
        
    <!-- 
    <div class="footer">
        WebHelp output generated by <a href="http://www.oxygenxml.com" target="_blank">
          <span class="oXygenLogo"><img src="{$PATH2PROJ}assets/images/LogoOxygen100x22.png" alt="Oxygen" /></span>
          <span class="xmlauthor">XML Author</span></a>.
    </div>
     -->
    <!-- OXYGEN PATCH END -->
  </xsl:template>
  
  <!-- OXYGEN PATCH START -->
  <xsl:template match="/|node()|@*" mode="gen-user-scripts">
    <script type="text/javascript" src="{$PATH2PROJ}assets/jquery-1.4.2.js"><xsl:text> </xsl:text></script>
    <!-- Do not remove this import. It's essential for WebHelp highlight -->
    <script type="text/javascript" src="{$PATH2PROJ}assets/jquery-ui-1.8.2.custom.min.js"><xsl:text> </xsl:text></script>
    <xsl:if test="string-length($CUSTOM_RATE_PAGE_URL) > 0">
      <script type="text/javascript" src="{$PATH2PROJ}assets/rate_article.js"><xsl:text> </xsl:text></script>
    </xsl:if>
    
    <xsl:variable name="js">
      <xsl:text><![CDATA[
    var prefix = "]]></xsl:text>

      <xsl:variable name="basedirJavaFile" select="File:new(string($CUSTOM_BASEDIR))"/>
      <xsl:variable name="basedirPath" select="File:getCanonicalPath($basedirJavaFile)"/>
      <xsl:variable name="topicJavaFile" select="File:new(base-uri())"/>
      <xsl:variable name="topicPath" select="File:getCanonicalPath($topicJavaFile)"/>
      <xsl:variable name="differencePath" select="substring-after($topicPath, $basedirPath)"/>
      <xsl:variable name="subdirCount" select="count(tokenize($differencePath, '\\')) - 2"/>
      <xsl:for-each select="for $i in (1 to $subdirCount) return $i">
        <xsl:text>../</xsl:text>
      </xsl:for-each>
        
      <xsl:text><![CDATA[index.html";
    var ratingFile = "]]></xsl:text>
      
      <xsl:if test="string-length($CUSTOM_RATE_PAGE_URL) > 0">
        <xsl:value-of select="$CUSTOM_RATE_PAGE_URL"/>
      </xsl:if>
      <xsl:text><![CDATA[";
    redirectToToc(window.location.search);
    function highlightSearchTerm(){
        if(parent.termsToHighlight != null){
        // highlight each term in the content view  
          for(i = 0 ; i < parent.termsToHighlight.length ; i++){        
              $('*', window.parent.frames[1].document).highlight(parent.termsToHighlight[i]);
          }
        }
    }
//]]></xsl:text>
    </xsl:variable>
    
    <script type="text/javascript" src="{$PATH2PROJ}assets/frames_redirect.js"><xsl:text> </xsl:text></script>    
    <script type="text/javascript"><xsl:comment><xsl:value-of select="$js"/></xsl:comment></script>    
  </xsl:template>
  <!-- OXYGEN PATCH END -->
  
  
  <xsl:template match="*" mode="addAttributesToBody">
    <xsl:attribute name="onload">highlightSearchTerm()</xsl:attribute>
  </xsl:template>
  
  <xsl:template name="getMeta">
    
    <!-- Processing note:
      getMeta is issued from the topic/topic context, therefore it is looking DOWN
      for most data except for attributes on topic, which will be current context.
    -->
    
    <!-- = = = = = = = = = = = CONTENT = = = = = = = = = = = -->
    
    <!-- CONTENT: Type -->
    <xsl:apply-templates select="." mode="gen-type-metadata"/>
    
    <!-- CONTENT: Title - title -->
    <xsl:apply-templates select="*[contains(@class,' topic/title ')] |
      self::dita/*[1]/*[contains(@class,' topic/title ')]" mode="gen-metadata"/>
    
    <!-- CONTENT: Description - shortdesc -->
    <!--  FIXED FOR WEBASSIGN  -->
    <xsl:variable name="shortdesc">
      <xsl:if test="//*[contains(@class,' topic/shortdesc ')]">
        <xsl:apply-templates
          select="//*[contains(@class,' topic/shortdesc ')]"
          mode="text-only"/>
      </xsl:if>
    </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="string-length(normalize-space($shortdesc)) > 0">
        <meta name="abstract">
          <xsl:attribute name="content"><xsl:value-of select="$shortdesc"/></xsl:attribute>
        </meta>
        <xsl:value-of select="$newline"/>
        <meta name="description">
          <xsl:attribute name="content"><xsl:value-of select="$shortdesc"/></xsl:attribute>
        </meta>
        <xsl:value-of select="$newline"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message>No short description found; not setting abstract or description metadata for topic.</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
    
    
    <!-- CONTENT: Source - prolog/source/@href -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/source ')]/@href |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/source ')]/@href" mode="gen-metadata"/>
    
    <!-- CONTENT: Coverage prolog/metadata/category -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/category ')] |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/category ')]" mode="gen-metadata"/>
    
    <!-- CONTENT: Subject - prolog/metadata/keywords -->
    <xsl:apply-templates select="." mode="gen-keywords-metadata"/>
    
    <!-- CONTENT: Relation - related-links -->
    <xsl:apply-templates select="*[contains(@class,' topic/related-links ')]/descendant::*/@href |
      self::dita/*/*[contains(@class,' topic/related-links ')]/descendant::*/@href" mode="gen-metadata"/>
    
    <!-- = = = = = = = = = = = Product - Audience = = = = = = = = = = = -->
    <!-- Audience -->
    <!-- prolog/metadata/audience/@experiencelevel and other attributes -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/audience ')]/@experiencelevel |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/audience ')]/@experiencelevel" mode="gen-metadata"/>
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/audience ')]/@importance |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/audience ')]/@importance" mode="gen-metadata"/>
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/audience ')]/@job |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/audience ')]/@job" mode="gen-metadata"/>
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/audience ')]/@name |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/audience ')]/@name" mode="gen-metadata"/>
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/audience ')]/@type |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/audience ')]/@type" mode="gen-metadata"/>
    
    
    <!-- <prodname> -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/prodname ')] |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/prodname ')]" mode="gen-metadata"/>
    
    <!-- <vrmlist><vrm modification="3" release="2" version="5"/></vrmlist> -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/vrmlist ')]/*[contains(@class,' topic/vrm ')]/@version |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/vrmlist ')]/*[contains(@class,' topic/vrm ')]/@version" mode="gen-metadata"/>
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/vrmlist ')]/*[contains(@class,' topic/vrm ')]/@release |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/vrmlist ')]/*[contains(@class,' topic/vrm ')]/@release" mode="gen-metadata"/>
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/vrmlist ')]/*[contains(@class,' topic/vrm ')]/@modification |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/vrmlist ')]/*[contains(@class,' topic/vrm ')]/@modification" mode="gen-metadata"/>
    
    <!-- <brand> -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/brand ')] |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/brand ')]" mode="gen-metadata"/>
    <!-- <component> -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/component ')] |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/component ')]" mode="gen-metadata"/>
    <!-- <featnum> -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/featnum ')] |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/featnum ')]" mode="gen-metadata"/>
    <!-- <prognum> -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/prognum ')] |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/prognum ')]" mode="gen-metadata"/>
    <!-- <platform> -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/platform ')] |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/platform ')]" mode="gen-metadata"/>
    <!-- <series> -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/series ')] |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/prodinfo ')]/*[contains(@class,' topic/series ')]" mode="gen-metadata"/>
    
    <!-- = = = = = = = = = = = INTELLECTUAL PROPERTY = = = = = = = = = = = -->
    
    <!-- INTELLECTUAL PROPERTY: Contributor - prolog/author -->
    <!-- INTELLECTUAL PROPERTY: Creator -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/author ')] |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/author ')]" mode="gen-metadata"/>
    
    <!-- INTELLECTUAL PROPERTY: Publisher - prolog/publisher -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/publisher ')] |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/publisher ')]" mode="gen-metadata"/>
    
    <!-- INTELLECTUAL PROPERTY: Rights - prolog/copyright -->
    <!-- Put primary first, then secondary, then remainder -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/copyright ')][@type='primary'] |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/copyright ')][@type='primary']" mode="gen-metadata"/>
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/copyright ')][@type='secondary'] |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/copyright ')][@type='seconday']" mode="gen-metadata"/>
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/copyright ')][not(@type)] |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/copyright ')][not(@type)]" mode="gen-metadata"/>
    
    <!-- Usage Rights - prolog/permissions -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/permissions ')] |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/permissions ')]" mode="gen-metadata"/>
    
    <!-- = = = = = = = = = = = INSTANTIATION = = = = = = = = = = = -->
    
    <!-- INSTANTIATION: Date - prolog/critdates/created -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/critdates ')]/*[contains(@class,' topic/created ')] |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/critdates ')]/*[contains(@class,' topic/created ')]" mode="gen-metadata"/>
    
    <!-- prolog/critdates/revised/@modified -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/critdates ')]/*[contains(@class,' topic/revised ')]/@modified |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/critdates ')]/*[contains(@class,' topic/revised ')]/@modified" mode="gen-metadata"/>
    
    <!-- prolog/critdates/revised/@golive -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/critdates ')]/*[contains(@class,' topic/revised ')]/@golive |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/critdates ')]/*[contains(@class,' topic/revised ')]/@golive" mode="gen-metadata"/>
    
    <!-- prolog/critdates/revised/@expiry -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/critdates ')]/*[contains(@class,' topic/revised ')]/@expiry |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/critdates ')]/*[contains(@class,' topic/revised ')]/@expiry" mode="gen-metadata"/>
    
    <!-- prolog/metadata/othermeta -->
    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/othermeta ')] |
      self::dita/*[1]/*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/othermeta ')]" mode="gen-metadata"/>
    
    <!-- INSTANTIATION: Format -->
    <xsl:apply-templates select="." mode="gen-format-metadata"/>
    
    <!-- INSTANTIATION: Identifier --> <!-- id is an attribute on Topic -->
    <xsl:apply-templates select="@id | self::dita/*[1]/@id" mode="gen-metadata"/>
    
    <!-- INSTANTIATION: Language -->
    <xsl:apply-templates select="@xml:lang | self::dita/*[1]/@xml:lang" mode="gen-metadata"/>
    
    <!-- Set viewport meta for iOS -->
    <meta content="width = device-width, height = device-height, initial-scale=1.0" name="viewport"/>
    
    
  </xsl:template>
    
  
</xsl:stylesheet>
