// TEMP
h5help.params.google_cse_api_key = "AIzaSyCMGfdDaSfjqv5zYoS0mTJnOT3e9MURWkU";
// TO DO: Add this as a build parameter. Needed by JSON REST API

h5help.search = $.extend(h5help.search, {
    "api_url"   : "https://www.googleapis.com/customsearch/v1",
    "search"    : function( start ){
                    // get 10 at a time (max per api query)
                    // if more results exist, display "more" button and add results in place
                    var start = start || 1;
                    if (start == 1) {
                        h5help.search.results = [];
                        h5help.search.labels = [];
                        $("div#searchresults > div > ol#resultslist").empty();
                    }
                    var query = h5help.search.getQuery();
                    var data = {
                        "key"   : h5help.params.google_cse_api_key,
                        "cx"    : h5help.params.google_cse_id,
                        "start" : start,
                        "q"     : query
                    };
                    $.getJSON(h5help.search.api_url, data)
                        .done( function( data ){
                            h5help.search.results.push.apply(h5help.search.results,h5help.search.parseJSON(data));
                            h5help.search.htmlResults(h5help.search.results);
                            if (start == 1 && h5help.search.results.length == 10) { h5help.search.search(11); }
                        })
                        .fail( function(){
                            // error handling, if any. might need to account for timeouts not caught by this.
                        });
        
    },
    "parseJSON" : function( json ) {
                    var results = [];
                    var resultcount = (json.items) ? json.items.length : 0;
                    for( var i = 0; i < resultcount; i++ ) {
                        var labels = [];
                        for( var j = 0; j < json.items[i].labels.length; j++ ) {
                            h5help.search.labels.push(json.items[i].labels[j].displayName);
                            labels.push(json.items[i].labels[j].displayName);
                        }
                        var shortdesc = json.items[i].pagemap.metatags[0]["abstract"];
                        var snippet = json.items[i].snippet;
                        if (h5help.search.comparestrings(shortdesc,snippet) > 25) { snippet = ''; }
                        else { snippet = '...' + snippet; }
                        
                        results.push({
                            "labels"    : labels,
                            "title"     : json.items[i].title,
                            "href"      : h5help.search.relativeURL(json.items[i].link),
                            "context"   : snippet,
                            "shortdesc" : shortdesc,
                            "terms"     : "",
                            "score"     : ""
                        });
                    }
                    h5help.search.labels.sort();
                    for( var i = 0; i < h5help.search.labels.length - 1; i++ ) {
                        while (h5help.search.labels[i] == h5help.search.labels[i+1]) {
                            h5help.search.labels.splice(i,1);
                        }
                    }
                    return results;
                    // TO DO: return flag if (no) more results exist
    },
    "relativeURL" : function( url ) {
                    var relativeLocations = /^https?:\/\/(www\.)?webassign\.(net|com)\/manual\//;
                    return url.replace(relativeLocations,"../");
    },
    "init"      : function() {
                    h5help.search.handlers();
    }
});

/*h5help.searchListener = {
    "currentquery"      : "",
    "getQuery"          : function() {
        var oldquery = h5help.searchListener.currentquery;
        h5help.searchListener.currentquery = encodeURIComponent( $("div#searchbox input.gsc-input").val() );
        return (oldquery != h5help.searchListener.currentquery);
    },
    "start"             : function() {
        $("div#searchbox").on("keyup", "input.gsc-input", function(evt) {
            if ( evt.which == 13 ) { h5help.searchListener.sendQueryToGA(); }
        });
        $("div#searchbox").on("change", "input.gsc-input", function(evt) {
            // wait for field to be updated from autocomplete
            window.setTimeout( h5help.searchListener.sendQueryToGA, 2000);
        });
    },
    "sendQueryToGA"     : function() {
        if (typeof(ga) == 'function' && h5help.searchListener.getQuery() ) {
            ga('set', 'location', h5help.baseUrl + "?s=" + h5help.searchListener.currentquery );
            ga('send', 'pageview');
        }
    }
};*/
