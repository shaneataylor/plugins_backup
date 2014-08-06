PR.registerLangHandler(PR.createSimpleLexer(
// shortcut patterns (tried first if initial character in list)
[
    ["pln", /^[\t\n\r \xa0]+/,null,"\t\n\r \u00a0"],
    ["str", /^(?:["](?:[^"]|["]{2})(?:["]c|$)|["](?:[^"]|["]{2})*(?:["]|$))/i,null,'"'],
    ["com", /^\/\/.*/,null,"\/"]
],
// regular patterns
[
    ["kwd", /^\b(?:(?:if|elseif|else)\b|(?:abs|assert|compressUnique|format|gcd|isCommaDelimited|isInteger|isPrime|isSigned|lcm|mean|randNum|randPrime|round|sort|toWord|toNumber|unique)\()/,null],
    ["com", /\/\/.*/],
    ["lit", /^(?:true\b|false\b|nothing\b|\d+(?:e[+-]?\d+[dfr]?|[dfilrs])?|(?:&h[\da-f]+|&o[0-7]+)[ils]?|\d*\.\d+(?:e[+-]?\d+)?[dfr]?|#\s+(?:\d+[/-]\d+[/-]\d+(?:\s+\d+:\d+(?::\d+)?(\s*(?:am|pm))?)?|\d+:\d+(?::\d+)?(\s*(?:am|pm))?)\s+#)/i],
    ["pln", /^(?:(?:[a-z]|_\w)\w*(?:\[[!#%&@]+])?|\[(?:[a-z]|_\w)\w*])/i],
    ["pun", /^[^\w\t\n\r "'[\]\xa0]+/],
    ["pun", /^(?:\[|];+\-*\/=)/]
]),["wava","wavascript"]);

/*
pln - plain text
com - comment forms
str - string
kwd - keyword
lit - literal
pun - punctuation
*/