
var h5help = h5help || {};

// set fallback values if JSON file cannot be loaded
h5help.params = {
"help_name"                        : "WebAssign Help",
"toc_file"                         : "toc.htm",
"search"                           : "internal",
"google_cse_id"                    : "",
"google_cse_refinement"            : "",
"disqus_shortname"                 : "",
"feedback"                         : "no",
"prettify_code"                    : "no"
};

requirejs.config({
    "baseUrl": "./h5help/js",
    "paths": {
      "jquery"         : "vendor/jquery-1.8.3.min",
      "modernizr"      : "vendor/modernizr-2.6.2.min",
      "mathjax"        : "../../../vendor/mathjax/MathJax",
      "prettify"       : "prettify-code-google/prettify",
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
