var h5help = h5help || {};

// TO DO
// Address any overlap with functions in helptopic.js

h5help.timestamp = new Date();
h5help.initialUrl=window.location.href; 
h5help.iframeSrc = h5help.initialUrl + '?h5help=' + h5help.timestamp.getTime();
h5help.baseUrl=h5help.initialUrl.replace(/\/[^\/]*$/gi,'/'); 
h5help.baseUrl=h5help.baseUrl.replace(/^https?:/gi,""); // agnostic to http or https
h5help.href=h5help.initialUrl.replace(/^.*\//,""); // just the topic
h5help.userdata = h5help.userdata || {};
//var h5Path=window.location.pathname;
//var disqus_shortname = h5help.params.disqus_shortname; 

h5help.framehtml =    '<div id="toolbar">'
                    + '  <h1 class="help_name">' + h5help.params.help_name + '</h1>'
                    + '  <a href="#topic" class="hidden508nav" tabindex="1">Skip to start of help topic</a>'
                    + h5help.search.html.box
                    /*+ '  <a id="email_topic" alt="Email topic" title="Email topic"><span class="ua_control"> </span></a>'*/
                    + '  <a id="print_topic" alt="Print topic" title="Print topic"><span class="ua_control"> </span></a>'
                    + '  <a id="get_support" alt="Get support" title="Get support"><span class="ua_control"> </span></a>'
                    + '</div>'
                    + '<div id="modal_back" class="hidden"></div>'
                    + '<div id="modal" class="modal hidden" role="alert"></div>'
                    + '<div id="content_container">'
                    + h5help.search.html.results
                    + '  <div id="toc" title="Table of contents" role="navigation"></div>'
                    + '  <div id="sizer" class="slideright" alt="Show or hide the contents"'
                    + '    title="Show or hide the contents"><span class="ua_control"> </span></div>'
                    + '  <div id="topic"><iframe name="contentwin" id="contentwin" src="' + h5help.iframeSrc + '"></iframe></div>'
                    + '</div>';

h5help.initAll = function() {
    h5help.initFrame();
    h5help.defineHandlers();
    h5help.improveCompatibility();
    h5help.loadInitialContent();
    if (h5help.search) {
        h5help.search.init();
    }
    else {
        window.alert("no search today");
    }
};

h5help.initFrame = function() {

    // TO DO: 1. Add build flag specifying header file for the frame
    //        2. Use that flag to get content here
    //        3. Don't add runninghead to the frame

    var runninghead = $("div.running-header").html();
    $("body").addClass("h5helpframe");
    $("body").html(runninghead + h5help.framehtml);
};
/*
 * TO DO: Incorporate functionality tested in demo
        $("div#topic > iframe").on("load",function(){
            var iframetitle = $("div#topic > iframe").contents().find("head>title").text();
            h5help.addMessage("loaded " + iframetitle);
            if ( iframetitle.match(/^[1-5]\d\d /) ) {
                $("div#topic > iframe").contents().find("head").append(
                    '<link rel="stylesheet" href="css/style.css" type="text/css"/>');
                var status = $("div#topic > iframe").contents().find("body").text();
                $("div#topic > iframe").contents().find("body").addClass("errpage");
                $("div#topic > iframe").contents().find("body").html(
                    "<div><h1>There was a problem getting this content</h1>"
                    + '<p>The server returned the following status:</p>'
                    + '<pre>'+iframetitle+'</pre>'
                    + '<pre>'+status+'</pre></div>'
                    );
            }
        });
*/
/*
 * TO DO: Incorporate functionality tested in demo
    updateTopic : function(title, location) {
        var newlocation = location.replace(/\?h5help=\d+/,'');
        window.history.replaceState({}, title, newlocation);
        $("head>title").text(title);
    }
*/


h5help.improveCompatibility = function (){

    // TO DO: Verify scrolling works without this code after content rendered in iframe

    // detect old Android browsers and override CSS to minimally address overflow scrolling limitation
    if (navigator.userAgent.match(/Android [12]\./gi)) {
        $("div#toc,div#topic,div#searchresults").css({'overflow':'visible','bottom':'auto','padding-bottom':'4in'});
        $("div#sizer").css({'overflow':'visible','bottom':'0px'});
    }
}
h5help.printTopic = function(){
    window.frames["contentwin"].focus();
    window.frames["contentwin"].print();
};
h5help.emailTopic = function(){
    // TO DO: Use topic title for subject and include link (and short description?) in body
    window.open('mailto:?subject=subject&body=body');
}

h5help.showModal = function(modalContent){
    $("div#modal").html(modalContent);
	$("div#modal_back,div#modal").removeClass("hidden");
	$("div#modal").focus();
}
h5help.hideModal = function(){
	$("div#modal_back,div.modal").addClass("hidden");
}
h5help.loadInitialContent = function(){
    var initialTopic = h5help.href; // because h5help.href will be reset by toc load
    h5help.loadDiv("div#toc", h5help.params.toc_file); // open TOC 
    h5help.href = initialTopic; // restore to previous value
    var query = h5help.getQuery();
    switch (query[0]) {
    case "t":
        $.getJSON('h5csh.json', function(csh_array){
            var linkHref = csh_array[query[1]];
            if (linkHref != null) { h5help.loadDiv("div#topic", linkHref) }
            else { 
                h5help.showModal("Could not find topic associated with keyword "+query[1]);
                // nothing
            }
        });
        break;
    case "q":
        h5help.loadDiv("div#topic", query[1]);
        break;
    case "search":  // removing this functionality for now
        // h5help.search.showResults(); 
        break;
    default:
        // nothing
        h5help.populateUserData();
        h5help.addCommentSection();
    }
};

h5help.getQuery = function() {
    var searchString = window.location.search;
    if (searchString == "") { return [null,null] }
    var queries = ["t","q","search"];
    for (var i = 0; i < queries.length; i++) {
        var thisregex = new RegExp('[\\?&]'+queries[i]+'=([^&#]*)');
        var thisquery = searchString.match(thisregex);
        if (thisquery != null) { return [queries[i],thisquery[1]] }
    }
    return [null,null];
}

h5help.getServer = function(url){
    var urlObj=$("<a />");
    urlObj.attr('href',url);
    var server=urlObj.prop('hostname');
    server=server.replace(/^https?:/gi,""); // agnostic to http or https
    return server;
}

h5help.handleLink = function(event){

    // TO DO: pare this back to only what might now be needed to correctly handle search results
    
    event.preventDefault(); // part 1 of 2 to prevent default behaviors
    var linkHref = $(this).attr("href");
    var linkTarget = $(this).attr("target");
    if (typeof linkTarget == 'undefined') {var linkTarget="h5topic";} // ensure defined
    if ( linkHref.indexOf("www.google.com/url?") >= 0 ) { 
        linkHref = $(this).attr("data-ctorig");
        linkTarget = "h5topic";
    }
    if (linkTarget == "h5topic" && (h5help.getServer(linkHref) != h5help.getServer(h5help.baseUrl)) ) {
        // COMM-587: Compare server of link & help system; set linkTarget="_top" if different
        linkTarget="_top";
    }
    
    if (linkTarget[0] == "_") {
        window.open(linkHref,linkTarget);
    }
    else if (linkHref[0] == "#") { 
        // cannot use browser default handling for anchor links within topic
        // this method does not handle anchor links in TOC frame, but none should exist
        
        var hashTarget = 'div#topic #' + linkHref.substring(1) + ',div#topic a[name="' + linkHref.substring(1) + '"]';
        var linkPosition = $(hashTarget).position().top;
        $("div#topic").scrollTop(linkPosition);
        return false;
    } 
    else {
    // FUTURE: handle some non-HTML target types?
    h5help.loadDiv("div#topic", linkHref);
    return false; // part 2 of 2 to prevent default behaviors
    }
}



h5help.loadDiv = function(targetDiv, linkHref, addHistory){
    addHistory = typeof addHistory !== 'undefined' ? addHistory : true;
    // TO DO:
    // + Do not load the help system itself into a frame
    // + If redirected from a topic, do not store two entries in history
    
    var hrefDiv = "";
    
    h5help.href = linkHref.replace(/index\.html$/,""); // normalize link
    // add code to be agnostic to www prefix, or change search results to exclude without www prefix?
    
    h5help.href = h5help.href.replace(/^https?:/gi,""); // agnostic to http or https (use current)
    h5help.href = h5help.href.replace(/^\/\/webassign.net/gi,"//www.webassign.net"); // adds "www" if omitted
    h5help.href = h5help.href.replace(h5help.baseUrl,""); // Allow breadcrumbs, TOC expansion when full URL is specified
    
    if (targetDiv == "div#topic") { hrefDiv = ' div#topic>*' }
    if (targetDiv == "div#toc" || targetDiv == "div#topic") { h5help.search.hideResults() }
    $(targetDiv).html('<div class="spinner"> </div>');
    // FUTURE: allow base to change when switching help system contexts (instructor/admin)
    //         --Treat as external link--
    $(targetDiv).load(h5help.href+hrefDiv, function(response, status, xhr){
        if (status == "error") {
            var modalContent = "<h1>" + xhr.status + "</h1>";
            modalContent += "<p>Could not open " + h5help.href + ".</p>";
            modalContent += "<p>" + xhr.statusText + "</p>";
            h5help.showModal(modalContent);
            if (Modernizr.history) {
                history.back();
            }
            else {
                $(targetDiv).html('<p>Topic not loaded</p>');
            }
            return;
        }
        switch(targetDiv) {
            case "div#toc"   : h5help.initTOC(); break;
        }
        $(targetDiv).trigger('divloaded'); // use this to let other processes know this is done
    });
    
}


h5help.populateUserData = function() {
    $("span.data.userdata").each(function(){
        var dataname = $(this).attr("name");
        var dataval = h5help.userdata[dataname] || parent.h5help.userdata[dataname];
        if ( typeof dataval != 'undefined' ) {
            $(this).html(dataval);
        } else {
            $(this).removeClass("userdata"); 
        }
    })
}


h5help.syncTOCandBreadcrumbs = function() {
    // highlight & if needed, expand parents of matching TOC entries
    $("div#toc a.current").removeClass("current");
    $('div#toc a.clicked').addClass("current").removeClass("clicked");
    if ($('div#toc a.current').length == 0) {
        $('div#toc a[href="' + h5help.href + '"]:eq(0)').addClass("current"); // pick the first matching href
    }
    $("div#toc a.current").parents("li.expandable").addClass("collapsible").removeClass("expandable");
    
    // add breadcrumbs based on the "current" TOC entry
    $("div#toc a.current").parent("li").each(function(){
        $("div#topic-breadcrumbs").prepend('<div class="breadcrumb"></div>');
        $(this).parents("li").each(function(){
            $("div#topic-breadcrumbs > div.breadcrumb:first-child").prepend("&#160;> ");
            $(this).children("a").clone().prependTo("div#topic-breadcrumbs > div.breadcrumb:first-child");
        });
    });

}
h5help.addCommentSection = function() {
    if (h5help.params.disqus_shortname.length > 0) {
        $('div#topic').append('<div id="disqus_thread"></div><a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a>');
        (function() {
            var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
            dsq.src = '//' + h5help.params.disqus_shortname + '.disqus.com/embed.js';
            $('div#topic').append(dsq);
        })();
    }
    if ( h5help.params.feedback == 'yes') {
        h5help.initFeedbackForm();
    }
}


h5help.defineHandlers = function (){
    
    $("#view_contents").on("click", function(){h5help.slideTOC(false)});
    $("#view_topic").on("click", function(){h5help.slideTOC(true)});
    $("a#email_topic").on("click", h5help.emailTopic);
    $("#print_topic").on("click", h5help.printTopic);
    // TO DO: If possible, redefine print method of frames window to print only the topic frame
    
    $("#modal_back").on("click", h5help.hideModal);
    
    if (Modernizr.history) {
        $(window).on("popstate",function(){
            h5help.loadDiv("div#topic", location.pathname, false); // last arg to prevent adding to history
        });
    }
    
    // delegation binds handler to current and future a descendants of selector
    
    $("div#toc").on("click", "a", h5help.slideTOC);
    $("div#toc").on("click", "a", function(){
        $(this).addClass("clicked");
    });
    
    $("div#toc").on("click", "li.expandable", h5help.expandTOCItem); 
    $("div#toc").on("click", "li.collapsible>span.ua_control", h5help.collapseTOCItem); 
    
    $("div#sizer").on("click", h5help.slideTOC);
    $(window).resize(h5help.mobilize);
};

h5help.initTOC = function(){
    $("div#toc li").prepend('<span class="ua_control">&nbsp;</span>');
    $("div#toc ul:empty").remove(); // remove empty ul so parent not expandable 
    $("div#toc li:has(ul)").addClass("expandable");
    $("div#toc li.expandable>span.ua_control").attr("title","Click to expand");
    /*$("div#toc a:not([title])").attr("title","Topic does not have a short description");*/
    h5help.slideTOC();
    h5help.mobilize();
    h5help.syncTOCandBreadcrumbs();
}
h5help.expandTOCItem = function(){
    // handle differently if clicked item was li vs. span
    if ($(this).is("span")) {
       $(this).parent().addClass("collapsible").removeClass("expandable");
       $(this).attr("title","Click to collapse");
    }
    else { // must be li
       $(this).addClass("collapsible").removeClass("expandable");
       $(this).children("span.ua_control").attr("title","Click to collapse");
    }
    return false; // don't bubble event up to parents
}
h5help.collapseTOCItem = function(){
    $(this).parent().addClass("expandable").removeClass("collapsible");
    $(this).attr("title","Click to expand");
    return false; // don't bubble event up to parents
}

h5help.mobilize = function() {
    // do this on window resize and after any load of TOC or topic
    var myWin = h5help.windowWidth();
    if (myWin.isSmall) {
        $("div#toc").css("width",myWin.toc.width);
        
        if (myWin.toc.isOpen) {
            $("div#toc").css("left",myWin.toc.openLeft);
            $("div#sizer").css("left",myWin.sizer.openLeft);
            $("#view_topic").removeClass("hidden");
            $("#view_contents").addClass("hidden");
        }
        else {
            $("div#toc").css("left",myWin.toc.closedLeft);
            $("div#sizer").css("left",myWin.sizer.closedLeft);
            $("#view_topic").addClass("hidden");
            $("#view_contents").removeClass("hidden");
        }
        $("body").scrollLeft(0); // fix for iPhone
    }
    else {
        var cssObj = {
            'left'   : '',
            'width'  : ''
        };
        $("div#toc").css(cssObj); // revert to stylesheet declaration
        $("#view_topic,#view_contents").addClass("hidden"); // hide menu items
    }
    h5help.adjustForBanner();
}
h5help.slideTOC = function(hideTOC) {
    var myWin = h5help.windowWidth();
    hideTOC = (typeof hideTOC == 'boolean') ? myWin.isSmall && hideTOC : myWin.isSmall && myWin.toc.isOpen;
    if (hideTOC) {
        $("div#toc").css("left",myWin.toc.closedLeft);
        $("div#sizer").css("left",myWin.sizer.closedLeft);
    }
    else {
        $("div#toc").css("left",myWin.toc.openLeft);
        $("div#sizer").css("left",myWin.sizer.openLeft);
    }
    $("#view_topic,#view_contents").toggleClass("hidden");
    $("div#sizer").toggleClass("slideright slideleft");
}
h5help.windowWidth = function() {
    var tocLRpaddingSum = 48; // Add left & right padding for TOC div in px
    var width = $(window).width(); // see also: $(document).width()
    var isSmall = (width <= 800);
    var toc = { 
        isOpen     : $("div#sizer").hasClass("slideright") , 
        width      : (width-20-tocLRpaddingSum) + "px" ,
        openLeft   : "0px" ,
        closedLeft : (tocLRpaddingSum - width - 20) + "px"
        };
    var sizer = {
        openLeft   : (width-20) + "px" ,
        closedLeft : "0px"
        }
    return { width:width, isSmall:isSmall, toc:toc, sizer:sizer };
}

h5help.adjustForBanner = function() {
    var bannerheight = $("div.brand_header").outerHeight(true);
    if (bannerheight != null) {
        var adjustTop = (40 + bannerheight) + "px";
        $("div#content_container").css("top",adjustTop);
        $("div#sizer").css("top",adjustTop);
    }
    
};


