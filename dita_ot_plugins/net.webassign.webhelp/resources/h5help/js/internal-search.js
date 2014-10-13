var h5help = h5help || {};

h5help.initSearch = function(){
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
};

h5help.doSearch = function() {
    // only for internal search
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
};

