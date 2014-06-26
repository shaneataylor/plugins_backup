// Init globals

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
    h5help.improveCompatibility();
    h5help.loadInitialContent();
    h5help.initSearch(); // do this last so nothing else is waiting on google
    // loadCommentScript();
};
h5help.improveCompatibility = function (){
    // detect old Android browsers and override CSS to minimally address overflow scrolling limitation
    if (navigator.userAgent.match(/Android [12]\./gi)) {
        $("div#toolbar,a#menu_button").css({'position':'fixed'});
        $("div#toc,div#topic,div#searchresults").css({'overflow':'visible','bottom':'auto','padding-bottom':'4in'});
        $("div#sizer").css({'overflow':'visible','bottom':'0px'});
    }
}
h5help.toggleMenu = function(){
	$("ul#menu").toggleClass("hidden");
}
h5help.closeMenu = function(){
	$("ul#menu").addClass("hidden");
}
h5help.printTopic = function(){
    h5help.closeMenu();
    window.print();
};

h5help.showAbout = function(){
    var modalContent="<h1>About Help</h1><p>Blah blah blah</p>";
    h5help.showModal(modalContent);
}
h5help.showModal = function(modalContent){
    h5help.closeMenu();
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
    case "search":
        h5help.showSearchResults();
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
    if (targetDiv == "div#toc" || targetDiv == "div#topic") { h5help.hideSearchResults() }
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
    h5help.mobilize();
    h5help.syncTOCandBreadcrumbs();
    h5help.addCommentSection();
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

h5help.googleAnalytics = function(){
    // storing generic GA code in a function for now. 
    // Refer to GA API docs for best way to use this for the help topics.
    var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
    (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
    g.src=('https:'==location.protocol?'//ssl':'//www')+'.google-analytics.com/ga.js';
    s.parentNode.insertBefore(g,s)}(document,'script'));
        }

h5help.defineHandlers = function (){
    $("a#menu_button").on("click focusin focusout", h5help.toggleMenu); 
    $("div#topic,div#searchresults,div#toc,div#toolbar").on("click", h5help.closeMenu);
    
    // need to enable menu items via keyboard
    $("#view_contents").on("click", function(){h5help.slideTOC(false)});
    $("#view_topic").on("click", function(){h5help.slideTOC(true)});
    $("#view_min").on("click", h5help.toggleMenu);
    $("#view_max").on("click", h5help.toggleMenu);
    $("#print_topic").on("click", h5help.printTopic);
    $("#customer_support").on("click", h5help.closeMenu);
    
    $("#about_help").on("click",h5help.showAbout);
    $("#modal_back").on("click", h5help.hideModal);
    
    if (Modernizr.history) {
        $(window).on("popstate",function(){
            h5help.loadDiv("div#topic", location.pathname, false); // last arg to prevent adding to history
        });
    }
    
    // delegation binds handler to current and future a descendants of selector
    
    $("div#searchbox").one("focus click", "input", h5help.showSearchResults); 
    $("div#searchresults").on("click", "a#closesearch", h5help.hideSearchResults);
    
    $("div#toc,div#topic,div#searchresults").on("click", "a:not(#closesearch)", h5help.handleLink); 
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
h5help.initSearch = function(){
    switch (h5help.params.search) {
        case "internal":
            $.getJSON('helpindex.json', function(data, status, xhr) {
                if (status !== 'error') {
                    h5help.helpindex = data;
                    $.getJSON('topicsummaries.json', function(data, status, xhr) { 
                        if (status !== 'error') { h5help.topicsummaries = data; }
                        else { h5help.topicsummaries = {}; }
                    });
                    porter2.exceptionlist = h5help.params.searchconfig.exceptionalforms; // override porter2 defaults 
                    $("div#searchbox").html('<input name="search" title="Search the help" placeholder="Search the help" tabindex="3" type="text"></input>');
                    $("div#searchresults").html('<h1 tabindex="4">Search Results</h1>'+
                    '<a id="closesearch" alt="Close" title="Close"><span class="ua_control"> </span></a><div></div>');
                    $("div#searchbox").on("keyup", "input", function(){
                        window.clearInterval(h5help.timer);
                        h5help.timer = window.setInterval(h5help.doSearch,500);
                    });
                }
            });
        break;
        case "google":
                h5help.timer = window.setInterval(function() { // test for search box periodically until found
                    if ($("div#searchbox input").length != 0) {
                        $("div#searchbox input").attr({ placeholder:"Search the help", tabindex:3 });
                        window.clearInterval(h5help.timer);
                    }
                },100);
            $("div#searchbox").html('<div class="gcse-searchbox" data-gname="wasearch" data-queryParameterName="search" data-defaultToRefinement="' + h5help.params.google_cse_refinement + '" data-webSearchResultSetSize="20"></div>');
            $("div#searchresults").html('<h1 tabindex="4">Search Results</h1>'+
            '<a id="closesearch" alt="Close" title="Close"><span class="ua_control"> </span></a>'+
            '<div class="gcse-searchresults" data-gname="wasearch"></div>');
            (function() {
                var gcse = document.createElement('script'); gcse.type = 'text/javascript'; gcse.async = true;
                gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') + '//www.google.com/cse/cse.js?cx=' + h5help.params.google_cse_id;
                var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(gcse, s);
            })();
        break;
        default:
            window.clearInterval(h5help.timer);
        break;
    }
};

h5help.doSearch = function() {
    window.clearInterval(h5help.timer);
    h5help.searchTerms = $("div#searchbox input").val().replace(/[^'a-zA-z]/," ").split(" ");
    h5help.searchStems = [];
    for (var i = 0; i < h5help.searchTerms.length; i++) { // stem each search term
        h5help.searchStems.push(porter2.stem(h5help.searchTerms[i]));
    }
    h5help.searchStems = h5help.searchStems.concat(h5help.getSynonyms(h5help.searchStems));
    
    var results = [];
    for (var i = 0; i < h5help.searchStems.length; i++) { // each search stem (including synonyms)
        var termbonus = (i >= h5help.searchTerms.length ? 100 : 1000 ); // reduced bonus for synonyms
        var stem = h5help.searchStems[i];
        if ( typeof(h5help.helpindex[stem]) != 'undefined' ) {
            for (var j = 0; j < h5help.helpindex[stem].length; j++) { // each result for the term
                var thishref = Object.keys(h5help.helpindex[stem][j])[0];
                var thisresult = {
                    "href":thishref,
                    "term":stem,
                    "score":parseInt(h5help.helpindex[stem][j][thishref]) + termbonus
                    };
                if (h5help.searchStems.length > 1) { // combine dups
                    var matched = results.filter(function(item){ return item.href == thishref; }); 
                    if (matched.length == 1) { // matched.length can be 0 or 1
                        var unmatched = results.filter(function(item){ return item.href != thishref; }); 
                        thisresult.term += " " + matched[0].term;
                        thisresult.score += matched[0].score;
                        results = unmatched;
                    }
                }
                results.push(thisresult);
            }
        }
    }
    results.sort(function(a,b) {return b.score - a.score});
    // display results
    var resultsHTML = "";
    if ( results.length > 0 ) {
        resultsHTML += "<ol>";
        for (var i = 0; i < results.length; i++) {
            var thissummary = h5help.topicsummaries[results[i].href] || {"searchtitle":"","shortdesc": ""};
            var thistitle = (thissummary.searchtitle.length > 0) ? thissummary.searchtitle.replace(/[<>]/gi,'') : "[no title]";
            var thisdesc = (thissummary.shortdesc.length > 0) ? thissummary.shortdesc.replace(/[<>]/gi,'') : "";
            resultsHTML += '<li score="' + results[i].score + ' stems="' + results[i].term + '">';
            resultsHTML += '<a href="' + results[i].href + '">' + thistitle + '</a>';
            resultsHTML += '<p class="shortdesc">' + thisdesc + '</p></li>';
        }
        resultsHTML += "</ol>";
    }
    else {
        resultsHTML = "<p>No topics matched your search criteria.</p>";
    }
    $("div#searchresults > div").html(resultsHTML);
};

h5help.getSynonyms = function(stemlist){
    var synonyms = [];
    for (var i = 0; i < stemlist.length; i++) {
        for (var j = stemlist.length; j >= i; j--) { // find longest matching phrase from end
            var phrase = stemlist.slice(i,j+1).join('_');
            if ( phrase in h5help.params.searchconfig.synonyms ) {
                synonyms = synonyms.concat(h5help.params.searchconfig.synonyms[phrase]);
            }
        }
    }
    // remove duplicates
    for (var i = 0; i < synonyms.length; i++) { 
        for (var j = 0; j < stemlist.length; j++) {
            if (synonyms[i] == stemlist[j]) { synonyms.splice(i,1); }
        }
    }
    for (var i = 0; i < synonyms.length; i++) { 
        for (var j = i+1; j < synonyms.length; j++) {
            if (synonyms[i] == synonyms[j]) { synonyms.splice(j,1); }
        }
    }
    return synonyms;
}

h5help.showSearchResults = function(){
    $("div#searchresults").removeClass("hidden");
    $("div#topic").addClass("hidden");
    h5help.slideTOC(true);
}
h5help.hideSearchResults = function(){
    $("div#searchbox").one("focus click", "input", h5help.showSearchResults);
    $("div#searchresults").addClass("hidden");
    $("div#topic").removeClass("hidden");
}
h5help.initFeedbackForm = function() {
    if (Modernizr.inputtypes.range) {
        // substitute slider control
        var rating_fs = '<label for="rating">Rate this topic</label>';
        rating_fs += '<div class="rangecontrol">';
        rating_fs += '<label for="rating">Poor</label>';
        rating_fs += '<label for="rating">OK</label>';
        rating_fs += '<label for="rating">Good</label>';
        rating_fs += '<input type="range" id="rating" name="rating" tabindex="0" value="3" min="1" max="5" step="1" />';
        rating_fs += '</div>';
        $("fieldset#rating_fs").html(rating_fs);
    }
    // get user data in localStorage if available
    if(typeof(Storage)!=="undefined") {
        $("div#feedback input#name").val(localStorage.name);
        $("div#feedback input#email").val(localStorage.email);
        $("div#feedback input#role").val(localStorage.role);
    }

    $("div#feedback").on("blur", "input[required='required']", h5help.validateFeedback);
    $("div#feedback").on("submit", "form", h5help.submitFeedback);
    $("div#feedback").on("click", "a#cancel", h5help.closeFeedback);
    $("div#feedback").on("click", "input#feedback_next, input#feedback_previous", function(){
        $("div#feedback_p1, div#feedback_p2, div.formcontrols > input").toggleClass("hidden");
    });
}

h5help.validateFeedback = function() {
    var isValid = true;
    var pattern = new RegExp($(this).attr('pattern'));
    var value = $(this).val();
    value = value.replace(/^\s+|\s+$/g,"");
    $(this).val(value);
    if ( value.match(pattern) ) {
        $(this).removeClass("warn");
    }
    else {
        isValid = false;
        $(this).addClass("warn");
    }
    return isValid; 
}
h5help.submitFeedback = function() {
    
    $("div#feedback input[required='required']").each(function(){
        $(this).trigger("blur"); // validate all required fields
        });
    var warned = $("div#feedback input.warn").length;
    if (warned > 0) {
        event.preventDefault(); // part 1 of 2 to prevent default behaviors
        h5help.showModal("<p>Some required information was not completed.</p>");
        return false; // part 2 of 2 to prevent default behaviors
    }
    // store user data in localStorage if available
    if(typeof(Storage)!=="undefined") {
        localStorage.name = $("div#feedback input#name").val();
        localStorage.email = $("div#feedback input#email").val();
        localStorage.role = $("div#feedback input#role").val();
    }
    // change names of form fields to match Google form
    feedbackNames = {
    'name'    : 'entry.1.single',
    'email'   : 'entry.2.single',
    'role'    : 'entry.3.single',
    'rating'  : 'entry.5.single',
    'comment' : 'entry.4.single',
    'helptopic'   : 'entry.0.single'};
    var formURL = 'https://docs.google.com/a/webassign.net/spreadsheet/formResponse';
    var formKey = 'dFNOTVNGVXNTTTRaOF9zd3gybmNlQ2c6MQ';
    for (var name in feedbackNames) {
        $("div#feedback #"+name).attr("name",feedbackNames[name]);
    }
    $("div#feedback form#feedback_form").attr("action",formURL);
    $("div#feedback form#feedback_form input#helptopic").val(window.location);
    $("div#feedback form#feedback_form input#formkey").val(formKey);
    // Display success message
    h5help.showModal("<p>Thank you for your feedback.  The Communications team will review your comments and take action as needed.</p>");
    $("#modal_back").one("click", h5help.closeFeedback);
}
h5help.closeFeedback = function() {
    $("div#feedback").addClass('hidden');
    $("iframe#h5ftgt").addClass('hidden');
    // give it 2 seconds in case user clicked through before form fully submitted,
    // then destroy form
    window.setTimeout(function(){
        $("div#feedback").remove(); 
        $("iframe#h5ftgt").remove();
    },2000);
    return false; // don't try to process link
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
    h5help.closeMenu();
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
    
}

h5help.initEmbeddedUA = function() {
    if (h5help.embeddedUA) {
        $("div#toc,div#sizer,div#toolbar,div#toolbar+div,div.brand_header").remove();
        $("div#topic-breadcrumbs,div#feedback,div.copyright,iframe.h5ftgt").remove();
        $("div#modal,div#modal_back,div#searchresults").remove();
        $("div.related-links").detach().appendTo("div.body");
        $("div#content_container").addClass("embeddedUA");
        
    }
}
