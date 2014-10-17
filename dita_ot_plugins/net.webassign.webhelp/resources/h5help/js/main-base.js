// build prepends h5help init and h5help.vendorpath to this file, e.g.:
//     var h5help = h5help || {};
//     h5help.vendorpath = "//www.webassign.net/manual/vendor";

// set fallback values if JSON file cannot be loaded
h5help.params = {
"help_name"                        : "WebAssign Help",
"toc_file"                         : "toc.htm",
"search"                           : "none",
"google_cse_id"                    : "",
"google_cse_api_key"               : "",
"google_cse_refinement"            : "",
"disqus_shortname"                 : "",
"feedback"                         : "no",
"prettify_code"                    : "no",
"watermark"                        : {}
};

h5help.embeddedUA = parent.h5help.embeddedUA || h5help.embeddedUA || false;
h5help.inframe = (window.location != window.parent.location) || (h5help.embeddedUA != false);
// TO DO: If query parameter noframes=true, then render topic without adding frame

requirejs.config({
    "baseUrl": "./h5help/js",
    "paths": {
      "jquery"         : h5help.vendorpath + "/jquery-1.8.3.min",
      "modernizr"      : h5help.vendorpath + "/modernizr-2.6.2.min",
      "mathjax"        : h5help.vendorpath + "/mathjax/MathJax",
      "prettify"       : h5help.vendorpath + "/google-code-prettify_minified/run_prettify.js?autorun=false&lang=wava",
      "search"        : "search",
      "porter2"        : "porter2",
      "internal-search": "internal-search",
      "google_search"  : "google_search",
      "feedback"       : "feedback",
      "help-functions" : (h5help.inframe) ? "helptopic" : "helpframe"
    }});

require(["jquery"],function(){
    $.getJSON('h5help/h5params.json',function(data, status, xhr){
        if (status !== 'error') { h5help.params = data; }
        var otherrequires = ["modernizr"];
        if (h5help.inframe) {
            !(h5help.params.prettify_code == "yes") || otherrequires.push("prettify");
            otherrequires.push("help-functions","mathjax");
        }
        else {
            switch(h5help.params.search){
                case "internal" : otherrequires.push("search","porter2","internal-search"); break;
                case "google"   : otherrequires.push("search","google-search"); break;
            }
            (h5help.params.feedback == "no") || otherrequires.push("feedback");
            otherrequires.push("help-functions");
        }
        require(otherrequires,function(){
            h5help.initAll();
        });
    });
});
