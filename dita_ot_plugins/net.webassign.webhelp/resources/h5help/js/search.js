h5help.search = {
    "init"      : function() { /* redefined for each search type */  },
    "timer"     : null,
    "handlers"  : function() {
                    $("div#searchresults").on("click", "a#closesearch", h5help.search.hideResults);
                    $("div#searchresults").on("click", "a:not(#closesearch)", h5help.handleLink); 
                    $("div#searchbox").one("focus click", "input", h5help.search.showResults); 
                    $("div#searchbox").on("keyup", "input", function(){
                        window.clearTimeout(h5help.search.timer);
                        h5help.search.timer = window.setTimeout(h5help.search.search,500);
                    });
                    $("div#searchfacets").on("change","input", h5help.search.filterfacets);
    },
    "getQuery"  : function() {
                    var query = $("div#searchbox input").val().replace(/[^'a-zA-z]+/," ");
                    query = query.replace(/(^\s+|\s+$)/g,'');
                    return query;
    },
    "showResults" : function() {
                    $("div#searchresults").removeClass("hidden");
                    $("div#topic").addClass("hidden");
                    h5help.slideTOC(true);
    },
    "hideResults" : function() {
                    $("div#searchbox").one("focus click", "input", h5help.search.showResults);
                    $("div#searchresults").addClass("hidden");
                    $("div#topic").removeClass("hidden");
    },
    "htmlResults" : function( results ){
                    /* results data structure :
                              "labels"    : array,
                              "title"     : string,
                              "href"      : string,
                              "context"   : string,
                              "shortdesc" : string,
                              "terms"     : string,
                              "score"     : number 
                       some items might not be specified */
                                          
                    var resultsHTML = "";
                    if ( results.length > 0 ) {
                        for (var i = 0; i < results.length; i++) {
                            var shortdesc = (results[i].shortdesc.length == 0) ? '' 
                                                : '<p class="shortdesc">' + results[i].shortdesc + '</p>';
                            var context = (results[i].context.length == 0) ? '' 
                                                : '<p class="shortdesc">' + results[i].context + '</p>';
                            resultsHTML += '<li data-score="' + results[i].score 
                                            + ' data-stems="' + results[i].terms 
                                            + ' data-labels="' + results[i].labels.join(" ") + '">'
                                            + '<a href="' + results[i].href + '">' + results[i].title + '</a>'
                                            + shortdesc + context 
                                            + '</li>';
                        }
                    }
                    else {
                        resultsHTML = "<li>No topics found.</li>";
                    }
                    $("div#searchresults > div > ol#resultslist").append(resultsHTML);
                    h5help.search.updatefacets();
    },
    "html"      : {
        "box"       : '<div id="searchbox" role="search" aria-label="search">'
                        + '<span class="ua_control" id="search_icon"> </span>'
                        + '<input name="search" title="Search" placeholder="Search" '
                        + 'tabindex="3" type="text"></input></div>',
        "results"   : '  <div id="searchresults" title="Search results" role="search">'
                        + '<h1 tabindex="4">Search Results</h1>'
                        + '<a id="closesearch" alt="Close" title="Close"><span class="ua_control"> </span></a>'
                        + '<div id="searchfacets"></div><div><ol id="resultslist"></ol></div></div>'
    },
    "comparestrings" : function( stringa, stringb ) {
                    // need to normalize spaces or remove ellipses?
                    var a = stringa.trim();
                    var b = stringb.trim();
                    if (a == b) {
                        return 100;
                    }
                    else {
                        var l = Math.min(a.length, b.length);
                        a = a.substr(0,l);
                        b = b.substr(0,l);
                        for (var i = 0; a.substr(0,i) == b.substr(0,i); i++) {}
                        return Math.round(i*100/l);
                    }
    },
    "updatefacets" : function() {
                        if (h5help.search.labels.length > 1) {
                            $("div#searchfacets").show();
                        }
                        else {
                            $("div#searchfacets").hide();
                        }
                        var facetHTML = '';
                        for (var i = 0; i < h5help.search.labels.length; i++) {
                            facetHTML += '<span><input type="checkbox" id="label' + i + '" '
                                            + 'value="' + h5help.search.labels[i] + '" checked="checked" />'
                                            + '<label for="label' + i + '">'
                                            + h5help.search.labels[i] + '</label></span>';
                        }
                        $("div#searchfacets").html(facetHTML);
    },
    "filterfacets" : function() {
                    $("div#searchfacets input:checked").each( function() {
                        var facet = $(this).val();
                        $("div#searchresults li[data-labels ~= '"+facet+"']").show();
                    });
                    $("div#searchfacets input:not(:checked)").each( function() {
                        var facet = $(this).val();
                        $("div#searchresults li[data-labels ~= '"+facet+"']").hide();
                    });
    }
};
