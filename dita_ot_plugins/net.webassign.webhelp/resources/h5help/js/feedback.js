var h5help = h5help || {};


h5help.initFeedbackForm = function() {
    if (Modernizr.inputtypes.range) {
        // substitute slider control
        var rating_fs = '<label for="rating">Rate this topic</label>';
        rating_fs += '<div class="rangecontrol">';
        rating_fs += '<label for="rating">Poor</label>';
        rating_fs += '<label for="rating">OK</label>';
        rating_fs += '<label for="rating">Good</label>';
        rating_fs += '<input type="range" id="rating" name="rating" tabindex="0" value="3" min="1" max="5" step="1" />';
        rating_fs += '</div>';
        $("fieldset#rating_fs").html(rating_fs);
    }
    // get user data in localStorage if available
    if(typeof(Storage)!=="undefined") {
        $("div#feedback input#name").val(localStorage.name);
        $("div#feedback input#email").val(localStorage.email);
        $("div#feedback input#role").val(localStorage.role);
    }

    $("div#feedback").on("blur", "input[required='required']", h5help.validateFeedback);
    $("div#feedback").on("submit", "form", h5help.submitFeedback);
    $("div#feedback").on("click", "a#cancel", h5help.closeFeedback);
    $("div#feedback").on("click", "input#feedback_next, input#feedback_previous", function(){
        $("div#feedback_p1, div#feedback_p2, div.formcontrols > input").toggleClass("hidden");
    });
};

h5help.validateFeedback = function() {
    var isValid = true;
    var pattern = new RegExp($(this).attr('pattern'));
    var value = $(this).val();
    value = value.replace(/^\s+|\s+$/g,"");
    $(this).val(value);
    if ( value.match(pattern) ) {
        $(this).removeClass("warn");
    }
    else {
        isValid = false;
        $(this).addClass("warn");
    }
    return isValid; 
};

h5help.submitFeedback = function() {
    
    $("div#feedback input[required='required']").each(function(){
        $(this).trigger("blur"); // validate all required fields
        });
    var warned = $("div#feedback input.warn").length;
    if (warned > 0) {
        event.preventDefault(); // part 1 of 2 to prevent default behaviors
        h5help.showModal("<p>Some required information was not completed.</p>");
        return false; // part 2 of 2 to prevent default behaviors
    }
    // store user data in localStorage if available
    if(typeof(Storage)!=="undefined") {
        localStorage.name = $("div#feedback input#name").val();
        localStorage.email = $("div#feedback input#email").val();
        localStorage.role = $("div#feedback input#role").val();
    }
    // change names of form fields to match Google form
    feedbackNames = {
    'name'    : 'entry.1.single',
    'email'   : 'entry.2.single',
    'role'    : 'entry.3.single',
    'rating'  : 'entry.5.single',
    'comment' : 'entry.4.single',
    'helptopic'   : 'entry.0.single'};
    var formURL = 'https://docs.google.com/a/webassign.net/spreadsheet/formResponse';
    var formKey = 'dFNOTVNGVXNTTTRaOF9zd3gybmNlQ2c6MQ';
    for (var name in feedbackNames) {
        $("div#feedback #"+name).attr("name",feedbackNames[name]);
    }
    $("div#feedback form#feedback_form").attr("action",formURL);
    $("div#feedback form#feedback_form input#helptopic").val(window.location);
    $("div#feedback form#feedback_form input#formkey").val(formKey);
    // Display success message
    h5help.showModal("<p>Thank you for your feedback.  The Communications team will review your comments and take action as needed.</p>");
    $("#modal_back").one("click", h5help.closeFeedback);
};

h5help.closeFeedback = function() {
    $("div#feedback").addClass('hidden');
    $("iframe#h5ftgt").addClass('hidden');
    // give it 2 seconds in case user clicked through before form fully submitted,
    // then destroy form
    window.setTimeout(function(){
        $("div#feedback").remove(); 
        $("iframe#h5ftgt").remove();
    },2000);
    return false; // don't try to process link
};