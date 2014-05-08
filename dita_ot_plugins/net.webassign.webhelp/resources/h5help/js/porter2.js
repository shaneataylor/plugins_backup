    
    // Variables
    
    var porter2 = porter2 || {};
    porter2.apos = "'";
    porter2.nonwordchars = "[^a-z']";
    
    porter2.exceptionlist = [
        {"skis" : "ski"},
        {"skies" : "sky" },
        {"dying" : "die" },
        {"lying" : "lie" },
        {"tying" : "tie" },
        {"idly" : "idl" },
        {"gently" : "gentl" },
        {"ugly" : "ugli" },
        {"early" : "earli" },
        {"only" : "onli" },
        {"singly" : "singl" },
        {"sky" : "sky" },
        {"news" : "news" },
        {"howe" : "howe" },
        {"atlas" : "atlas" },
        {"cosmos" : "cosmos" },
        {"bias" : "bias" },
        {"andes" : "andes" }
    ];

    porter2.post_s1a_exceptions = [
        {"inning" : "inning"},
        {"outing" : "outing"},
        {"canning" : "canning"},
        {"herring" : "herring"},
        {"earring" : "earring"},
        {"proceed" : "proceed"},
        {"exceed" : "exceed"},
        {"succeed" : "succeed"}
    ];
    
    porter2.s0_sfxs =/('|'s|'s')$/;
    
    porter2.s1a_replacements = [
        { "suffix" : "sses", "with" : "ss" },
        { "suffix" : "ied", "with" : "i|ie", "complexrule" : "s1a" },
        { "suffix" : "ies", "with" : "i|ie", "complexrule" : "s1a" },
        { "suffix" : "us", "with" : "us" },
        { "suffix" : "ss", "with" : "ss" },
        { "suffix" : "s", "with" : "", "ifprecededby" : "[aeiouy].+" }
    ];
    
    porter2.s1b_replacements = [
            { "suffix" : "eedly", "with" : "ee", "ifin" : "R1" },
            { "suffix" : "ingly", "with" : "", "ifprecededby" : "[aeiouy].*", "complexrule" : "s1b" },
            { "suffix" : "edly", "with" : "", "ifprecededby" : "[aeiouy].*", "complexrule" : "s1b" },
            { "suffix" : "eed", "with" : "ee", "ifin" : "R1" },
            { "suffix" : "ing", "with" : "", "ifprecededby" : "[aeiouy].*", "complexrule" : "s1b" },
            { "suffix" : "ed", "with" : "", "ifprecededby" : "[aeiouy].*", "complexrule" : "s1b" }
        ];
    
    porter2.s2_replacements = [
            { "suffix" : "ization", "with" : "ize", "ifin" : "R1" },
            { "suffix" : "ational", "with" : "ate", "ifin" : "R1" },
            { "suffix" : "fulness", "with" : "ful", "ifin" : "R1" },
            { "suffix" : "ousness", "with" : "ous", "ifin" : "R1" },
            { "suffix" : "iveness", "with" : "ive", "ifin" : "R1" },
            { "suffix" : "tional", "with" : "tion", "ifin" : "R1" },
            { "suffix" : "biliti", "with" : "ble", "ifin" : "R1" },
            { "suffix" : "lessli", "with" : "less", "ifin" : "R1" },
            { "suffix" : "entli", "with" : "ent", "ifin" : "R1" },
            { "suffix" : "ation", "with" : "ate", "ifin" : "R1" },
            { "suffix" : "alism", "with" : "al", "ifin" : "R1" },
            { "suffix" : "aliti", "with" : "al", "ifin" : "R1" },
            { "suffix" : "ousli", "with" : "ous", "ifin" : "R1" },
            { "suffix" : "iviti", "with" : "ive", "ifin" : "R1" },
            { "suffix" : "fulli", "with" : "ful", "ifin" : "R1" },
            { "suffix" : "enci", "with" : "ence", "ifin" : "R1" },
            { "suffix" : "anci", "with" : "ance", "ifin" : "R1" },
            { "suffix" : "abli", "with" : "able", "ifin" : "R1" },
            { "suffix" : "izer", "with" : "ize", "ifin" : "R1" },
            { "suffix" : "ator", "with" : "ate", "ifin" : "R1" },
            { "suffix" : "alli", "with" : "al", "ifin" : "R1" },
            { "suffix" : "bli", "with" : "ble", "ifin" : "R1" },
            { "suffix" : "ogi", "with" : "og", "ifin" : "R1", "ifprecededby" : "l" },
            { "suffix" : "li", "with" : "", "ifin" : "R1", "ifprecededby" : "[cdeghkmnrt]" }
        ];
    
    porter2.s3_replacements = [
            { "suffix" : "ational", "with" : "ate", "ifin" : "R1" },
            { "suffix" : "tional", "with" : "tion", "ifin" : "R1" },
            { "suffix" : "alize", "with" : "al", "ifin" : "R1" },
            { "suffix" : "ative", "with" : "", "ifin" : "R1,R2" },
            { "suffix" : "icate", "with" : "ic", "ifin" : "R1" },
            { "suffix" : "iciti", "with" : "ic", "ifin" : "R1" },
            { "suffix" : "ical", "with" : "ic", "ifin" : "R1" },
            { "suffix" : "ness", "with" : "", "ifin" : "R1" },
            { "suffix" : "ful", "with" : "", "ifin" : "R1" }
        ];
    
    porter2.s4_replacements = [
            { "suffix" : "ement", "with" : "", "ifin" : "R2" },
            { "suffix" : "ance", "with" : "", "ifin" : "R2" },
            { "suffix" : "ence", "with" : "", "ifin" : "R2" },
            { "suffix" : "able", "with" : "", "ifin" : "R2" },
            { "suffix" : "ible", "with" : "", "ifin" : "R2" },
            { "suffix" : "ment", "with" : "", "ifin" : "R2" },
            { "suffix" : "ant", "with" : "", "ifin" : "R2" },
            { "suffix" : "ate", "with" : "", "ifin" : "R2" },
            { "suffix" : "ent", "with" : "", "ifin" : "R2" },
            { "suffix" : "ion", "with" : "", "ifin" : "R2", "ifprecededby" : "[st]" },
            { "suffix" : "ism", "with" : "", "ifin" : "R2" },
            { "suffix" : "iti", "with" : "", "ifin" : "R2" },
            { "suffix" : "ive", "with" : "", "ifin" : "R2" },
            { "suffix" : "ize", "with" : "", "ifin" : "R2" },
            { "suffix" : "ous", "with" : "", "ifin" : "R2" },
            { "suffix" : "ic", "with" : "", "ifin" : "R2" },
            { "suffix" : "er", "with" : "", "ifin" : "R2" },
            { "suffix" : "al", "with" : "", "ifin" : "R2" }
        ];
    
    porter2.s5_replacements = [
            { "suffix" : "e", "with" : "", "complexrule" : "s5" },
            { "suffix" : "l", "with" : "", "ifin" : "R2", "ifprecededby" : "l" }
        ];
    
    // Functions
    porter2.R1 = function(thisword) {
        var exceptions = /^(gener|commun|arsen)/;
        var r1base = /^.*?[aeiouy][^aeiouy]/;
        if (exceptions.test(thisword)) {
            return thisword.replace(exceptions,"");
        } else if (r1base.test(thisword)) {
            return thisword.replace(r1base,"");
        } else {
            return "";
        }
    };

    porter2.R2 = function(thisword) {
        thisword = porter2.R1(thisword);
        var r1base = /^.*?[aeiouy][^aeiouy]/;
        if (r1base.test(thisword)) {
            return thisword.replace(r1base,"");
        } else {
            return "";
        }
    };

    porter2.endsWithShortSyllable = function(thisword) {
        var eSS = /([^aeiouy][aeiouy][^aeiouywxY]$|^[aeiouy][^aeiouy]$)/;
        return eSS.test(thisword);
    }
    
    porter2.isShort = function(thisword) {
        return (porter2.R1(thisword).length == 0 && porter2.endsWithShortSyllable(thisword));
    }
    
    porter2.keyMatches = function(object) {
        // object is the array object passed from porter2.firstMatch
        var thisword = this[0];
        var wholeword = this[1];
        var suffix = object.suffix || Object.keys(object)[0]; 
        var regex = new RegExp(wholeword ? "^"+ suffix + "$" : suffix + "$");
        if (regex.test(thisword)) {
        }
        return regex.test(thisword);
    }
    
    porter2.firstMatch = function(array,thisword,wholeword) {
        var wholeword = wholeword || false;
        var data = [thisword,wholeword];
        return array.filter(porter2.keyMatches,data)[0] || [];
    }
    
    porter2.stem = function(thisword) {
        // note: porter2.stemOrException subsumed into porter2.stem
        
        thisword = thisword.toLowerCase().replace(porter2.nonwordchars,"");
        var exception = porter2.firstMatch(porter2.exceptionlist,thisword,true); 
        //  exception = array containing first matching object or nothing
        if (thisword.length <= 2) {
            return thisword;
        } else if (exception.length != 0) {
            return exception[thisword];
        } else {
            return porter2.getStem(thisword);
        }
    }
    
    porter2.replace_suffix = function(thisword,array) {
        var replacearray = porter2.firstMatch(array,thisword);
        if (typeof(replacearray) == 'undefined' || replacearray.length == 0) { // no matches
            return thisword;
        }
        var replace = replacearray;
        
        var restrictions = '';
        if (replace.hasOwnProperty("ifin")) {
            restrictions += (replace.ifin.indexOf('R1') > -1 ? 'R1' : '');
            restrictions += (replace.ifin.indexOf('R2') > -1 ? 'R2' : '');
        }
        if (replace.hasOwnProperty("ifprecededby")) {
            restrictions += (replace.ifprecededby.length > 0 ? 'PrecededBy' : '');
        }
        if (replace.hasOwnProperty("complexrule")) {
            restrictions += (replace.complexrule.length > 0 ? 'ComplexRule_'+replace.complexrule : '');
        }
        var suffix = new RegExp(replace.suffix + '$');
        var precededsuffix = new RegExp(replace.ifprecededby + suffix.source);
        
        switch (restrictions) {
            // no restrictions
            case "":
                thisword = thisword.replace(suffix,replace.with);
                break;
                
            // restrictions
            case "R1":
                if (porter2.R1(thisword).search(suffix) > -1) {
                    thisword = thisword.replace(suffix,replace.with);
                }
                break;
            case "R2":
                if (porter2.R2(thisword).search(suffix) > -1) {
                    thisword = thisword.replace(suffix,replace.with);
                }
                break;
            case "R1R2":
                if (porter2.R1(thisword).search(suffix) > -1 && porter2.R2(thisword).search(suffix) > -1) {
                    thisword = thisword.replace(suffix,replace.with);
                }
                break;
            case "PrecededBy":
                if (thisword.search(precededsuffix) > -1) {
                    thisword = thisword.replace(suffix,replace.with);
                }
                break;
            case "R1PrecededBy":
                if (porter2.R1(thisword).search(suffix) > -1 && thisword.search(precededsuffix) > -1) {
                    thisword = thisword.replace(suffix,replace.with);
                }
                break;
            case "R2PrecededBy":
                if (porter2.R2(thisword).search(suffix) > -1 && thisword.search(precededsuffix) > -1) {
                    thisword = thisword.replace(suffix,replace.with);
                }
                break;
            // complex rules
            case "ComplexRule_s1a":
                precededsuffix = new RegExp('..'+suffix.source);
                if (thisword.search(precededsuffix) > -1) {
                    thisword = thisword.replace(suffix,'i');
                } else {
                    thisword = thisword.replace(suffix,'ie');
                }
                break;
            case "PrecededByComplexRule_s1b":
                if (thisword.search(precededsuffix) > -1) {
                    thisword = thisword.replace(suffix,'');
                    if (thisword.search(/atbliz$/) > -1) {
                        thisword = thisword + 'e';
                    } else if (thisword.search(/(bb|dd|ff|gg|mm|nn|pp|rr|tt)$/) > -1) {
                        thisword = thisword.replace(/.$/,'');
                    } else if (porter2.isShort(thisword)) {
                        thisword = thisword + 'e';
                    } 
                }
                break;
            case "ComplexRule_s5":
                if ((porter2.R2(thisword).search(suffix) > -1) || (porter2.R1(thisword).search(suffix) > -1) && !(porter2.endsWithShortSyllable(thisword.replace(suffix,'')))) {
                    thisword = thisword.replace(suffix,'');
                }
                break;
        }
        return thisword;
    };
    
    porter2.getStem = function(word) {
        var noinitpostrophes = word.replace(/^'/,'');
        var consonantY = noinitpostrophes.replace(/(^|[aeiouy])y/,'$1Y');
        var s0 = consonantY.replace(porter2.s0_sfxs,'');
        var s1a = porter2.replace_suffix(s0,porter2.s1a_replacements);
        var s1b = porter2.replace_suffix(s1a,porter2.s1b_replacements);
        var s1c = s1b.replace(/(.[^aeiouy])[yY]$/,'$1i');
        var s2 = porter2.replace_suffix(s1c,porter2.s2_replacements);
        var s3 = porter2.replace_suffix(s2,porter2.s3_replacements);
        var s4 = porter2.replace_suffix(s3,porter2.s4_replacements);
        var s5 = porter2.replace_suffix(s4,porter2.s5_replacements);
        var post_s1a_exception = porter2.firstMatch(porter2.post_s1a_exceptions,s1a,true);
        if (post_s1a_exception.length != 0) {
            return post_s1a_exception[s1a];
        } else {
            return s5.toLowerCase();
        }
    };
    