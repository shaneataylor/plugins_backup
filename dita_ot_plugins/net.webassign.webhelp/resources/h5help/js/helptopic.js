var h5help = h5help || {};

h5help.embeddedUA = parent.h5help.embeddedUA || h5help.embeddedUA || false;
h5help.userdata = h5help.userdata || {};
h5help.initialUrl=window.location.href; 
h5help.baseUrl=h5help.initialUrl.replace(/\/[^\/]*$/gi,'/'); 
h5help.baseUrl=h5help.baseUrl.replace(/^https?:/gi,""); // agnostic to http or https
h5help.href=h5help.initialUrl.replace(/^.*\//,""); // just the topic
//var h5Path=window.location.pathname;
//var h5help.timer;
//var disqus_shortname = h5help.params.disqus_shortname; 

h5help.initAll = function() {
    h5help.initEmbeddedUA();
    h5help.defineHandlers();
    h5help.loadInitialContent();
    h5help.initTopicJSON();
    h5help.initInteractions();
    h5help.addWatermark();
    // loadCommentScript();
};
/*
 *  TO DO: Incorporate functionality tested in demo
        var title = $("head>title").text();
        var location = window.location.href;
        window.parent.h5help.updateTopic(title, location);
*/


h5help.loadInitialContent = function(){
    var initialTopic = h5help.href; // because h5help.href will be reset by toc load
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
    case "search":
        h5help.showSearchResults(); // TO DO: Call parent to show search results
        break;
    default:
        // nothing
        h5help.populateUserData();
        h5help.prettifyIfEnabled();
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

    // TO DO:
    // Redefine this function based on topic in iframe
    
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

    // TO DO:
    // Redefine this function, maybe using the parent's loadDiv if needed


    addHistory = typeof addHistory !== 'undefined' ? addHistory : true;
    
    var hrefDiv = "";
    
    h5help.href = linkHref.replace(/index\.html$/,""); // normalize link
    // add code to be agnostic to www prefix, or change search results to exclude without www prefix?
    
    h5help.href = h5help.href.replace(/^https?:/gi,""); // agnostic to http or https (use current)
    h5help.href = h5help.href.replace(/^\/\/webassign.net/gi,"//www.webassign.net"); // adds "www" if omitted
    h5help.href = h5help.href.replace(h5help.baseUrl,""); // Allow breadcrumbs, TOC expansion when full URL is specified
    
    if (targetDiv == "div#topic") { hrefDiv = ' div#topic>*' }
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
            case "div#topic" : h5help.initTopic(addHistory,h5help.href); break;
        }
        $(targetDiv).trigger('divloaded'); // use this to let other processes know this is done
    });
    
}
h5help.initTopic = function(addHistory,thishref){
    if (Modernizr.history && addHistory) {
        window.history.pushState(null,null, thishref); // add page to history for modern browsers
    }
    var title = $("div#topic h1").text();
    $("title").html(title);
    h5help.initEmbeddedUA();
    h5help.populateUserData();
    h5help.prettifyIfEnabled();
    h5help.syncTOCandBreadcrumbs();
    h5help.addCommentSection();
    h5help.initTopicJSON();
    h5help.initInteractions();
    h5help.updateGoogleAnalytics();
    MathJax.Hub.Queue(["Typeset",MathJax.Hub]); // parse topic with MathJax
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

h5help.prettifyIfEnabled = function(){
    if ( h5help.params.prettify_code == 'yes') { PR.prettyPrint() }
}

h5help.syncTOCandBreadcrumbs = function() {
    // TO DO: Fire event to parent window when topic is loaded so TOC/breadcrumbs can be updated

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
}

h5help.googleAnalytics = function(){
    // storing generic GA code in a function for now. 
    // Refer to GA API docs for best way to use this for the help topics.
    var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
    (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
    g.src=('https:'==location.protocol?'//ssl':'//www')+'.google-analytics.com/ga.js';
    s.parentNode.insertBefore(g,s)}(document,'script'));
};

h5help.updateGoogleAnalytics = function() {
    if (typeof(ga) == 'function') {
        ga('set', 'location', window.location.href);
        ga('send', 'pageview');
    }
};


h5help.defineHandlers = function (){
    
    // TO DO: Trigger event for parent to close menu on clicks in topic
    
    $("div#toc,div#topic,div#searchresults").on("click", "a:not(#closesearch)", h5help.handleLink); 
    $("div#toc").on("click", "a", function(){
        $(this).addClass("clicked");
    });
    
};




h5help.initEmbeddedUA = function() {

    // TO DO: Remove unneeded bits when content loaded without frame stuff

    if (h5help.embeddedUA) {
        $("div#toc,div#sizer,div#toolbar,div#toolbar+div,div.brand_header").remove();
        $("div#topic-breadcrumbs,div#feedback,div.copyright,iframe.h5ftgt").remove();
        $("div#modal,div#modal_back,div#searchresults").remove();
        $("div.related-links").detach().appendTo("div.body");
        $("div#content_container").addClass("embeddedUA");
        
    }
}

h5help.initTopicJSON = function() {
    var datacontent = [];
    $("script[type='text/json'],div[data-type='text/json']").each( function(){
        datacontent.push( $(this).html() );
    })
    var datajoined = "{" + datacontent.join() + "}";
    h5help.topicJSON = JSON.parse(datajoined);
}

h5help.initInteractions = function() {
    h5help.myInteractionPath = '';
    $("div.lcSingleSelect").addClass("hidden");
    if (typeof(h5help.topicJSON.interactionpath) != 'undefined') {
        h5help.showInteraction(h5help.topicJSON.interactionpath.startwith);
    }
    
    /* FUTURE: LET USER GO BACK AND CHANGE ANSWERS */
    /*$("div.lcSingleSelect").on("click", "h2.lcSingleSelectTitle", function(){
        $(this).parents("div.lcSingleSelect").toggleClass("answered");
    });*/
    $("div.lcSingleSelect").one("click", "label", h5help.doInteraction);
}

h5help.showInteraction = function(iname,newInteraction) {
    if (typeof(newInteraction) == 'undefined') {
        var thisinteraction = $("div#" + iname + ".lcSingleSelect").detach();
    } else {
        var thisinteraction = newInteraction;
    }
    // move the interaction to the end & unhide
    $("div.lcSingleSelect").last().after(thisinteraction);
    $("div#" + iname + ".lcSingleSelect").removeClass("hidden");
}

h5help.doInteraction = function() {
    $(this).parents("div.lcAnswerOptionGroup").children("div.lcAnswerContent").removeClass("checked");
    $(this).parents("div.lcAnswerContent").addClass("checked");
    $(this).parents("div.lcSingleSelect").addClass("answered");
    var thispathstepid = $(this).parents("div.lcSingleSelect").attr('id');
    var thispathstepval = $(this).siblings("input[type='radio']").attr('value');
    h5help.myInteractionPath += thispathstepid + '=' + thispathstepval + ';';
    for (var i = 0; i < h5help.topicJSON.interactionpath.paths.length; i++ ) {
        if (h5help.topicJSON.interactionpath.paths[i].indexOf(h5help.myInteractionPath) == 0) {
            break;
        }
    }
    var restofpath = h5help.topicJSON.interactionpath.paths[i].substr(h5help.myInteractionPath.length).split(/[;=]/);
    if (restofpath[0] != 'endwith') {
        h5help.showInteraction(restofpath[0]);
    }
    else {
        var newInteraction = '<div class="fig lcInteractionBase lcSingleSelect withDelay"'
            + ' id="' + restofpath[0] + '"><h2 class="title lcSingleSelectTitle ">Finished</h2>'
            + 'Your topic will open in a few seconds.</div>';
        h5help.showInteraction(restofpath[0],newInteraction);
        var a = setTimeout(function(){
            h5help.loadDiv("div#topic", restofpath[1]);
            },3000);
    }
}

h5help.addWatermark = function() {

    // TO DO: Rewrite CSS for topic loaded in iframe
    var haswatermark = (typeof(h5help.params.watermark.file) == 'string');
    var nopattern = !(typeof(h5help.params.watermark.file) == 'string') || h5help.params.watermark.file == '';
    var patternmatches = !nopattern && h5help.baseUrl.match(new RegExp(h5help.params.watermark.urlpattern)) != null;
    if (haswatermark && (nopattern || patternmatches)) {
        var wmstyle = '<style type="text/css">div#topic:before {'
            + 'position: fixed; display: block; top: 40px; right: 0px;pointer-events: none;'
            + 'content:url('+h5help.params.watermark.file+'); opacity: 0.25;'
            + '}</style>';
        $("head").append(wmstyle);
    }
}



