// Init globals
var h5Url=window.location.href; 
var h5baseUrl=h5Url.replace(/\/[^\/]*$/gi,'/'); 
    h5baseUrl=h5baseUrl.replace(/^https?:/gi,""); // agnostic to http or https
var h5Path=window.location.pathname;
var h5timer;
var thisHref=h5Url.replace(/^.*\//,""); // just the topic
var disqus_shortname; 
h5params = {
"help_name"                        : "WebAssign Help",
"toc_file"                         : "toc.htm",
"google_cse_id"                    : "",
"google_cse_refinement"            : "",
"disqus_shortname"                 : "",
"feedback"                         : "no"
};


function initAll() {
    $.getJSON('h5help/h5params.json',function(data, status, xhr){
        if (status !== 'error') { h5params = data }
        disqus_shortname = h5params.disqus_shortname;
        defineHandlers();
        improveCompatibility();
        loadInitialContent();
        initSearch(); // do this last so nothing else is waiting on google
        // loadCommentScript();
    }); 
}
function improveCompatibility(){
    // detect old Android browsers and override CSS to minimally address overflow scrolling limitation
    if (navigator.userAgent.match(/Android [12]\./gi)) {
        $("div#toolbar,img#menu_button").css({'position':'fixed'});
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
    var initialTopic = thisHref; // because thisHref will be reset by toc load
    loadDiv("div#toc", h5params.toc_file); // open TOC 
    thisHref = initialTopic; // restore to previous value
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
    if (linkTarget == "h5topic" && (getServer(linkHref) != getServer(h5baseUrl)) ) {
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
    
    thisHref = linkHref.replace(/index\.html$/,""); // normalize link
    if ( (thisHref==h5Url) || (thisHref==h5Path) || (thisHref=="") ) {
        return;
    }
    // add code to be agnostic to www prefix, or change search results to exclude without www prefix?
    
    thisHref = thisHref.replace(/^https?:/gi,""); // agnostic to http or https (use current)
    thisHref = thisHref.replace(/^\/\/webassign.net/gi,"//www.webassign.net"); // adds "www" if omitted
    thisHref = thisHref.replace(h5baseUrl,""); // Allow breadcrumbs, TOC expansion when full URL is specified
    
    if (targetDiv == "div#topic") { hrefDiv = ' div#topic>div' }
    if (targetDiv == "div#toc" || targetDiv == "div#topic") { hideSearchResults() }
    $(targetDiv).html('<div class="spinner"> </div>');
    // FUTURE: allow base to change when switching help system contexts (instructor/admin)
    //         --Treat as external link--
    $(targetDiv).load(thisHref+hrefDiv, function(response, status, xhr){
        if (status == "error") {
            var modalContent = "<h1>" + xhr.status + "</h1>";
            modalContent += "<p>Could not open " + thisHref + ".</p>";
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
            initTopic(addHistory,thisHref);
        }
        $(targetDiv).trigger('divloaded'); // use this to let other processes know this is done
    });
    
}
function initTopic(addHistory,thisHref){
    if (Modernizr.history && addHistory) {
        window.history.pushState(null,null, thisHref); // add page to history for modern browsers
        var title = $("div#topic h1").text();
        $("title").html(title);  
    }
    addCommentSection();
    syncTOCandBreadcrumbs();
}
function syncTOCandBreadcrumbs() {
    // highlight & if needed, expand parents of matching TOC entries
    $("div#toc a.current").removeClass("current");
    $('div#toc a.clicked').addClass("current").removeClass("clicked");
    if ($('div#toc a.current').length == 0) {
        $('div#toc a[href="' + thisHref + '"]:eq(0)').addClass("current"); // pick the first matching href
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
    if (disqus_shortname.length > 0) {
        $('div#topic').append('<div id="disqus_thread"></div><a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a>');
        (function() {
            var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
            dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
            $('div#topic').append(dsq);
        })();
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
    $("img#menu_button").on("click", toggleMenu); // click required for FF ("focus" did not work)
    $("div#topic,div#searchresults,div#toc,div#toolbar").on("click", closeMenu);
    
    // need to enable menu items via keyboard
    $("#view_contents").on("click", function(){slideTOC(false)});
    $("#view_topic").on("click", function(){slideTOC(true)});
    $("#view_min").on("click", toggleMenu);
    $("#view_max").on("click", toggleMenu);
    $("#print_topic").on("click", printTopic);
    $("#customer_support").on("click", closeMenu);
    if ( h5params.feedback == 'yes') {
        $("#topic_feedback").on("click", showFeedbackForm);
    }
    else {
        $("#topic_feedback").addClass("hidden");
    }

    $("#about_help").on("click", showAbout);
    $("#modal_back").on("click", hideModal);
    
    if (Modernizr.history) {
        $(window).on("popstate",function(){
            loadDiv("div#topic", location.pathname, false); // last arg to prevent adding to history
        })
    }
    
    // delegation binds handler to current and future a descendants of selector
    
    $("div#searchbox").one("focus click", "input", showSearchResults); 
    
    $("div#toc,div#topic,div#searchresults").on("click", "a", handleLink); 
    $("div#toc").on("click", "a", slideTOC);
    $("div#toc").on("click", "a", function(){
        $(this).addClass("clicked");
    });
    
    $("div#toc").on("click", "li.expandable", expandTOCItem); 
    $("div#toc").on("click", "li.collapsible>span.control", collapseTOCItem); 
    
    $("div#sizer").on("click", slideTOC);
    $(window).resize(mobilize);
}
function initTOC(){
    $("div#toc li").prepend('<span class="control">&nbsp;</span>');
    $("div#toc li:has(ul)").addClass("expandable");
    $("div#toc li.expandable>span.control").attr("title","Click to expand");
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
       $(this).children("span.control").attr("title","Click to collapse");
    }
    return false; // don't bubble event up to parents
}
function collapseTOCItem(){
    $(this).parent().addClass("expandable").removeClass("collapsible");
    $(this).attr("title","Click to expand");
    return false; // don't bubble event up to parents
}
function initSearch(){
    if ( h5params.google_cse_id !== '' ) {
        $("div#searchbox").html('<div class="gcse-searchbox" data-gname="wasearch" data-queryParameterName="search" data-defaultToRefinement="' + h5params.google_cse_refinement + '" data-webSearchResultSetSize="20"></div>');
        $("div#searchresults").html('<h1>Search Results</h1><div class="gcse-searchresults" data-gname="wasearch"></div>');
        (function() {
            var gcse = document.createElement('script'); gcse.type = 'text/javascript'; gcse.async = true;
            gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') + '//www.google.com/cse/cse.js?cx=' + h5params.google_cse_id;
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(gcse, s);
        })();
        h5timer = window.setInterval(function() { // test for search box periodically until found
            if ($("div#searchbox input").length != 0) {
                $("div#searchbox input").attr("placeholder","Search the help");
                window.clearInterval(h5timer);
            }
        },100);
    }

}
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
function showFeedbackForm() {
    closeMenu();
    $("div#feedback").remove(); // in case it exists from before
    $("iframe#h5ftgt").remove(); // in case it exists from before
    $("div#topic").prepend('<iframe id="h5ftgt" name="h5ftgt" seamless></iframe>');
    $("div#topic").prepend('<div id="feedback"></div>');
    loadDiv("div#feedback","h5help/feedback.html",false);
    $("div#feedback").on("divloaded",init_feedback);
}
function init_feedback(){
    init_form();
    initFeedbackHandlers();
}
function init_form() {
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
}
// <form id="ss-form" name="ss-form" action="https://docs.google.com/a/webassign.net/spreadsheet/formResponse?formkey=dFNOTVNGVXNTTTRaOF9zd3gybmNlQ2c6MQ&amp;ifq" method="post" target="_new"> </form>
function initFeedbackHandlers() {
    $("div#feedback").on("blur", "input[required='required']", validateFeedback);
    $("div#feedback").on("submit", "form", submitFeedback);
    $("div#feedback").on("click", "a#cancel", closeFeedback);
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
    // change names of form fields to match Google form
    feedbackNames = {
    'name'    : 'entry.1.single',
    'email'   : 'entry.2.single',
    'role'    : 'entry.3.single',
    'rating'  : 'entry.5.single',
    'comment' : 'entry.4.single',
    'topic'   : 'entry.0.single'};
    var formURL = 'https://docs.google.com/a/webassign.net/spreadsheet/formResponse';
    var formKey = 'dFNOTVNGVXNTTTRaOF9zd3gybmNlQ2c6MQ';
    for (var name in feedbackNames) {
        $("div#feedback #"+name).attr("name",feedbackNames[name]);
    }
    $("div#feedback form#feedback_form").attr("action",formURL);
    $("div#feedback form#feedback_form input#topic").val(window.location);
    $("div#feedback form#feedback_form input#formkey").val(formKey);
    // Display success message
    // FUTURE: Use localstorage to save feedback field data
    showModal("<p>Thank you for your feedback.  The Communications team will review your comments and take action as needed.</p>");
    $("#modal_back").one("click", closeFeedback);
}
function closeFeedback() {
        // FUTURE: Use localstorage to save feedback field data
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
    // do this on window resize and after any load of TOC
    var width = $(window).width();
    if (width > 800) {
        var cssObj = {
            'left'   : '',
            'width'  : ''
        };
        $("div#toc").css(cssObj); // revert to stylesheet declaration
        $("#view_topic").addClass("hidden");
        $("#view_contents").addClass("hidden");
    }
    else {
        var isright = $("div#sizer").hasClass("slideright");
        var tocleft = isright ? "0px" : (20-width) + "px";
        width = (width-20) + "px";
        $("div#toc").css("width",width);
        $("div#toc").css("left",tocleft);
        if (isright) {
            $("div#sizer").css("left",width);
            $("#view_topic").removeClass("hidden");
            $("#view_contents").addClass("hidden");
        }
        else {
            $("#view_topic").addClass("hidden");
            $("#view_contents").removeClass("hidden");
        }
        $("body").scrollLeft(0); // fix for iPhone
    }
}
function slideTOC(hideTOC) {
    var width = $(window).width(); // see also: $(document).width()
    var smallwin = (width <= 800);
    hideTOC = (typeof hideTOC == 'boolean') ? smallwin && hideTOC : smallwin && $("div#sizer").hasClass("slideright");
    closeMenu();
    var tocleft = "0px";
    var sizerleft = (width-20) + "px";
    if (hideTOC) {
        tocleft = (20 - width) + "px";
        sizerleft = "0px";
        $("#view_topic").addClass("hidden");
        $("#view_contents").removeClass("hidden");
    }
    else {
        $("#view_topic").removeClass("hidden");
        $("#view_contents").addClass("hidden");
    }
    $("div#sizer").toggleClass("slideright slideleft");
    $("div#toc").css("left",tocleft);
    $("div#sizer").css("left",sizerleft);
}
