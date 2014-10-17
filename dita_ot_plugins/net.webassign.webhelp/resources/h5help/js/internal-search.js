h5help.search = $.extend(h5help.search, {
    "init"      : function(){
                    $.getJSON('helpindex.json')
                        .done( function( data ){
                            h5help.helpindex = data;
                            $.getJSON('topicsummaries.json', function(data, status, xhr) { 
                                if (status !== 'error') { h5help.topicsummaries = data; }
                                else { h5help.topicsummaries = {}; }
                            });
                            porter2.exceptionlist = h5help.params.searchconfig.exceptionalforms; // override porter2 defaults 
                            h5help.search.handlers();
                        })
                        .fail( function(){
                            // error handling, if any. might need to account for timeouts not caught by this.
                        });
    },
    "search"    : function(){
                      var query = h5help.search.getQuery();
                      var terms = query.split(" ");
                      h5help.searchStems = [];
                      for (var i = 0; i < terms.length; i++) { // stem each search term
                          h5help.searchStems.push(porter2.stem(terms[i]));
                      }
                      h5help.searchStems = h5help.searchStems.concat(h5help.search.getSynonyms(h5help.searchStems));
                      
                      var results = [];
                      for (var i = 0; i < h5help.searchStems.length; i++) { // each search stem (including synonyms)
                          var termbonus = (i >= terms.length ? 100 : 1000 ); // reduced bonus for synonyms
                          var stem = h5help.searchStems[i];
                          if ( typeof(h5help.helpindex[stem]) != 'undefined' ) {
                              for (var j = 0; j < h5help.helpindex[stem].length; j++) { // each result for the term
                                  var thishref = Object.keys(h5help.helpindex[stem][j])[0];
                                  var thissummary = h5help.topicsummaries[thishref] || {"searchtitle":"","shortdesc": ""};
                                  var thistitle = (thissummary.searchtitle.length > 0) ? thissummary.searchtitle.replace(/[<>]/gi,'') : "[no title]";
                                  var thisdesc = (thissummary.shortdesc.length > 0) ? thissummary.shortdesc.replace(/[<>]/gi,'') : "";
                                  
                                  var thisresult = {
                                      "labels"    : [],
                                      "title"     : thistitle,
                                      "href"      : thishref,
                                      "context"   : "",
                                      "shortdesc" : thisdesc,
                                      "terms"     : stem,
                                      "score"     : parseInt(h5help.helpindex[stem][j][thishref]) + termbonus
                                      };
                                  if (h5help.searchStems.length > 1) { // combine dups
                                      var matched = results.filter(function(item){ return item.href == thishref; }); 
                                      if (matched.length == 1) { // matched.length can be 0 or 1
                                          var unmatched = results.filter(function(item){ return item.href != thishref; }); 
                                          thisresult.terms += " " + matched[0].terms;
                                          thisresult.score += matched[0].score;
                                          results = unmatched;
                                      }
                                  }
                                  results.push(thisresult);
                              }
                          }
                      }
                      results.sort(function(a,b) {return b.score - a.score});
                      h5help.search.htmlResults(results);
        
    },
    "getSynonyms"   : function(stemlist){
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
});