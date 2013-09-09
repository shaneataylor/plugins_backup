
// set fallback values if JSON file cannot be loaded
h5params = {
"help_name"                        : "WebAssign Help",
"toc_file"                         : "toc.htm",
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
      "prettify"       : "google-code-prettify/prettify",
      "help-functions" : "help-functions"
    }});

require(["modernizr","jquery","prettify","help-functions"],function(){
    $.getJSON('h5help/h5params.json',function(data, status, xhr){
        if (status !== 'error') { 
            h5params = data;
            initAll();
            /*window.alert("2. Prettify code: "+h5params.prettify_code);*/
            if ( h5params.prettify_code == 'yes') { PR.prettyPrint() }
        }
        else {
            window.alert("Missing configuration file. Using default values.");
            initAll();
        }
    });
    
});
