// build prepends h5help init and h5help.vendorpath to this file, e.g.:
//     var h5help = h5help || {};
//     h5help.vendorpath = "//www.webassign.net/manual/vendor";

// set fallback values if JSON file cannot be loaded
h5help.params = {
"help_name"                        : "WebAssign Help",
"toc_file"                         : "toc.htm",
"search"                           : "none",
"google_cse_id"                    : "",
"google_cse_refinement"            : "",
"disqus_shortname"                 : "",
"feedback"                         : "no",
"prettify_code"                    : "no"
};

requirejs.config({
    "baseUrl": "./h5help/js",
    "paths": {
      "jquery"         : h5help.vendorpath + "/jquery-1.8.3.min",
      "modernizr"      : h5help.vendorpath + "/modernizr-2.6.2.min",
      "mathjax"        : h5help.vendorpath + "/mathjax/MathJax",
      "prettify"       : h5help.vendorpath + "/google-code-prettify_minified/run_prettify.js?autorun=false&lang=wava",
      "porter2"        : "porter2",
      "help-functions" : "help-functions"
    }});

require(["jquery"],function(){
    $.getJSON('h5help/h5params.json',function(data, status, xhr){
        if (status !== 'error') { h5help.params = data; }
        var otherrequires = ["modernizr"];
        if (h5help.params.prettify_code == "yes") { otherrequires.push("prettify"); }
        if (h5help.params.search == "internal")   { otherrequires.push("porter2"); }
        otherrequires.push("help-functions","mathjax");
        require(otherrequires,function(){
            h5help.initAll();
        });
    });
});
