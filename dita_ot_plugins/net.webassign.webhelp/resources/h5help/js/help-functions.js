// Init globals

var h5help = h5help || {};

h5help.initialUrl=window.location.href; 
h5help.baseUrl=h5help.initialUrl.replace(/\/[^\/]*$/gi,'/'); 
h5help.baseUrl=h5help.baseUrl.replace(/^https?:/gi,""); // agnostic to http or https
h5help.href=h5help.initialUrl.replace(/^.*\//,""); // just the topic
//var h5Path=window.location.pathname;
//var h5help.timer;
//var disqus_shortname = h5help.params.disqus_shortname; 

h5help.initAll = function() {
    defineHandlers();
    improveCompatibility();
    loadInitialContent();
    h5help.initSearch(); // do this last so nothing else is waiting on google
    // loadCommentScript();
};
function improveCompatibility(){
    // detect old Android browsers and override CSS to minimally address overflow scrolling limitation
    if (navigator.userAgent.match(/Android [12]\./gi)) {
        $("div#toolbar,a#menu_button").css({'position':'fixed'});
        $("div#toc,div#topic,div#searchresults").css({'overflow':'visible','bottom':'auto','padding-bottom':'4in'});
        $("div#sizer").css({'overflow':'visible','bottom':'0px'});
    }
}
function toggleMenu(){
	$("ul#menu").toggleClass("hidden");
}
function closeMenu(){
	$("ul#menu").addClass("hidden");
}
function printTopic(){
    closeMenu();
    javascript:window.print();
}
function showAbout(){
    var modalContent="<h1>About Help</h1><p>Blah blah blah</p>";
    showModal(modalContent);
}
function showModal(modalContent){
    closeMenu();
    $("div#modal").html(modalContent);
	$("div#modal_back,div#modal").removeClass("hidden");
	$("div#modal").focus();
}
function hideModal(){
	$("div#modal_back,div.modal").addClass("hidden");
}
function loadInitialContent(){
    var initialTopic = h5help.href; // because h5help.href will be reset by toc load
    loadDiv("div#toc", h5help.params.toc_file); // open TOC 
    h5help.href = initialTopic; // restore to previous value
    var query = getQuery();
    switch (query[0]) {
    case "t":
        $.getJSON('h5csh.json', function(csh_array){
            var linkHref = csh_array[query[1]];
            if (linkHref != null) { loadDiv("div#topic", linkHref) }
            else { 
                showModal("Could not find topic associated with keyword "+query[1]);
                // nothing
            }
        });
        break;
    case "q":
        loadDiv("div#topic", query[1]);
        break;
    case "search":
        showSearchResults();
        break;
    default:
        // nothing
        prettifyIfEnabled();
        addCommentSection();

    }
}

function getQuery() {
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

function getServer(url){
    var urlObj=$("<a />");
    urlObj.attr('href',url);
    var server=urlObj.prop('hostname');
    server=server.replace(/^https?:/gi,""); // agnostic to http or https
    return server;
}

function handleLink(event){
    event.preventDefault(); // part 1 of 2 to prevent default behaviors
    var linkHref = $(this).attr("href");
    var linkTarget = $(this).attr("target");
    if (typeof linkTarget == 'undefined') {var linkTarget="h5topic";} // ensure defined
    if ( linkHref.indexOf("www.google.com/url?") >= 0 ) { 
        linkHref = $(this).attr("data-ctorig");
        linkTarget = "h5topic";
    }
    if (linkTarget == "h5topic" && (getServer(linkHref) != getServer(h5help.baseUrl)) ) {
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
    loadDiv("div#topic", linkHref);
    return false; // part 2 of 2 to prevent default behaviors
    }
}



function loadDiv(targetDiv, linkHref, addHistory){
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
    if (targetDiv == "div#toc" || targetDiv == "div#topic") { hideSearchResults() }
    $(targetDiv).html('<div class="spinner"> </div>');
    // FUTURE: allow base to change when switching help system contexts (instructor/admin)
    //         --Treat as external link--
    $(targetDiv).load(h5help.href+hrefDiv, function(response, status, xhr){
        if (status == "error") {
            var modalContent = "<h1>" + xhr.status + "</h1>";
            modalContent += "<p>Could not open " + h5help.href + ".</p>";
            modalContent += "<p>" + xhr.statusText + "</p>";
            showModal(modalContent);
            if (Modernizr.history) {
                history.back();
            }
            else {
                $(targetDiv).html('<p>Topic not loaded</p>');
            }
            return;
        }
        if (targetDiv == "div#toc") {
            initTOC();
        }
        else if (targetDiv == "div#topic") {
            initTopic(addHistory,h5help.href);
        }
        $(targetDiv).trigger('divloaded'); // use this to let other processes know this is done
    });
    
}
function initTopic(addHistory,thishref){
    if (Modernizr.history && addHistory) {
        window.history.pushState(null,null, thishref); // add page to history for modern browsers
    }
    var title = $("div#topic h1").text();
    $("title").html(title);
    prettifyIfEnabled();
    mobilize();
    syncTOCandBreadcrumbs();
    addCommentSection();
    MathJax.Hub.Queue(["Typeset",MathJax.Hub]); // parse topic with MathJax
}

function prettifyIfEnabled(){
    if ( h5help.params.prettify_code == 'yes') { PR.prettyPrint() }
}

function syncTOCandBreadcrumbs() {
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
function addCommentSection() {
    if (h5help.params.disqus_shortname.length > 0) {
        $('div#topic').append('<div id="disqus_thread"></div><a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a>');
        (function() {
            var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
            dsq.src = '//' + h5help.params.disqus_shortname + '.disqus.com/embed.js';
            $('div#topic').append(dsq);
        })();
    }
    if ( h5help.params.feedback == 'yes') {
        initFeedbackForm();
    }
}

function googleAnalytics(){
    // storing generic GA code in a function for now. 
    // Refer to GA API docs for best way to use this for the help topics.
    var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
    (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
    g.src=('https:'==location.protocol?'//ssl':'//www')+'.google-analytics.com/ga.js';
    s.parentNode.insertBefore(g,s)}(document,'script'));
        }

function defineHandlers(){
    // Future: create keyboard shortcuts for visually impaired users
    $("a#menu_button").on("click focusin focusout", toggleMenu); 
    $("div#topic,div#searchresults,div#toc,div#toolbar").on("click", closeMenu);
    
    // need to enable menu items via keyboard
    $("#view_contents").on("click", function(){slideTOC(false)});
    $("#view_topic").on("click", function(){slideTOC(true)});
    $("#view_min").on("click", toggleMenu);
    $("#view_max").on("click", toggleMenu);
    $("#print_topic").on("click", printTopic);
    $("#customer_support").on("click", closeMenu);
    
    $("#about_help").on("click", showAbout);
    $("#modal_back").on("click", hideModal);
    
    if (Modernizr.history) {
        $(window).on("popstate",function(){
            loadDiv("div#topic", location.pathname, false); // last arg to prevent adding to history
        })
    }
    
    // delegation binds handler to current and future a descendants of selector
    
    $("div#searchbox").one("focus click", "input", showSearchResults); 
    $("div#searchresults").on("click", "a#closesearch", hideSearchResults);
    
    $("div#toc,div#topic,div#searchresults").on("click", "a:not(#closesearch)", handleLink); 
    $("div#toc").on("click", "a", slideTOC);
    $("div#toc").on("click", "a", function(){
        $(this).addClass("clicked");
    });
    
    $("div#toc").on("click", "li.expandable", expandTOCItem); 
    $("div#toc").on("click", "li.collapsible>span.ua_control", collapseTOCItem); 
    
    $("div#sizer").on("click", slideTOC);
    $(window).resize(mobilize);
}
function initTOC(){
    $("div#toc li").prepend('<span class="ua_control">&nbsp;</span>');
    $("div#toc ul:empty").remove(); // remove empty ul so parent not expandable 
    $("div#toc li:has(ul)").addClass("expandable");
    $("div#toc li.expandable>span.ua_control").attr("title","Click to expand");
    /*$("div#toc a:not([title])").attr("title","Topic does not have a short description");*/
    slideTOC();
    mobilize();
    syncTOCandBreadcrumbs();
}
function expandTOCItem(){
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
function collapseTOCItem(){
    $(this).parent().addClass("expandable").removeClass("collapsible");
    $(this).attr("title","Click to expand");
    return false; // don't bubble event up to parents
}
h5help.initSearch = function(){
    // fix param values
    if ( h5help.params.search == '' && h5help.params.google_cse_id !== '' ) {
        h5help.params.search = 'google';
    } else if ( h5help.params.search == 'google'  && h5help.params.google_cse_id == '' ) {
        h5help.params.search = '';
    }
    switch (h5help.params.search) {
        case "internal":
            $.getJSON('helpindex.json', function(data, status, xhr) {
                if (status !== 'error') {
                    h5help.helpindex = data;
                    $("div#searchbox").html('<input name="search" title="Search the help" placeholder="Search the help" tabindex="3"></input>');
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
    var results = [];
    for (var i = 0; i < h5help.searchTerms.length; i++) { // each search term
        var stem = porter2.stem(h5help.searchTerms[i]);
        if ( typeof(h5help.helpindex[stem]) != 'undefined' ) {
            for (var j = 0; j < h5help.helpindex[stem].length; j++) { // each result for the term
                var thishref = Object.keys(h5help.helpindex[stem][j])[0];
                results.push({
                    "href":thishref,
                    "term":h5help.searchTerms[i],
                    "score":h5help.helpindex[stem][j][thishref]
                });
            }
        }
    }
    if (h5help.searchTerms.length > 1) {
    // combine dups
        var uniqueresults = [];
        while (results.length > 0) {
            var matched = results.filter(function(item){ return item.href == results[0].href; }); 
            var unmatched = results.filter(function(item){ return item.href != results[0].href; }); 
            var thisresult = {"href":results[0].href,"term":"","score":0};
            for (var j = 0; j < matched.length; j++) {
                thisresult.term += matched[j].term + " ";
                thisresult.score += parseInt(matched[j].score) + 1000; // each term has 1000 bonus
            }
            uniqueresults.push(thisresult);
            results = unmatched;
        }
        results = uniqueresults;
    }
    results.sort(function(a,b) {return b.score - a.score});
    // display results
    var resultsHTML = "";
    for (var i = 0; i < results.length; i++) {
        resultsHTML += '<li><a href="' + results[i].href + '" title="' + results[i].term + results[i].score + '">';
        resultsHTML += results[i].href + '</a></li>';
    }
    $("div#searchresults > div").html('<ul>'+resultsHTML+'</ul>');
};

function showSearchResults(){
    $("div#searchresults").removeClass("hidden");
    $("div#topic").addClass("hidden");
    slideTOC(true);
}
function hideSearchResults(){
    $("div#searchbox").one("focus click", "input", showSearchResults);
    $("div#searchresults").addClass("hidden");
    $("div#topic").removeClass("hidden");
}
function initFeedbackForm() {
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

    $("div#feedback").on("blur", "input[required='required']", validateFeedback);
    $("div#feedback").on("submit", "form", submitFeedback);
    $("div#feedback").on("click", "a#cancel", closeFeedback);
    $("div#feedback").on("click", "input#feedback_next, input#feedback_previous", function(){
        $("div#feedback_p1, div#feedback_p2, div.formcontrols > input").toggleClass("hidden");
    });
}

function validateFeedback() {
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
function submitFeedback() {
    
    $("div#feedback input[required='required']").each(function(){
        $(this).trigger("blur"); // validate all required fields
        });
    var warned = $("div#feedback input.warn").length;
    if (warned > 0) {
        event.preventDefault(); // part 1 of 2 to prevent default behaviors
        showModal("<p>Some required information was not completed.</p>");
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
    showModal("<p>Thank you for your feedback.  The Communications team will review your comments and take action as needed.</p>");
    $("#modal_back").one("click", closeFeedback);
}
function closeFeedback() {
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
function mobilize() {
    // do this on window resize and after any load of TOC or topic
    var myWin = windowWidth();
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
    adjustForBanner();
}
function slideTOC(hideTOC) {
    var myWin = windowWidth();
    hideTOC = (typeof hideTOC == 'boolean') ? myWin.isSmall && hideTOC : myWin.isSmall && myWin.toc.isOpen;
    closeMenu();
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
function windowWidth() {
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

function adjustForBanner() {
    var bannerheight = $("div.brand_header").outerHeight(true);
    if (bannerheight != null) {
        var adjustTop = (40 + bannerheight) + "px";
        $("div#content_container").css("top",adjustTop);
        $("div#sizer").css("top",adjustTop);
    }
    
}
