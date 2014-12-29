var error_free;

function validate_data() {

    //Client side validations

    

    $("#error_span").html("");

    error_free=true;
    unsaved=true;

    $('#submit_button').click(function (event) {

        error_free=true;
        var msg=" ";

        var ele = $('#email_subject');
        var is_filled = ele.val();
        if (is_filled) {
            ele.removeClass("invalid").addClass("valid");
        }
        else {
            error_free=false;
            ele.removeClass("valid").addClass("invalid");
            msg = "*Subject cannot be blank*";
        }



        var ele1 = $('#email_receiver_email');
        is_filled = ele1.val();
        if (is_filled) {
            ele1.removeClass("invalid").addClass("valid");
        }
        else {
            error_free=false;
            ele1.removeClass("valid").addClass("invalid");
            msg = msg + "*Receiver cannot be blank*";
        }


       /* var form_data = $("#form").serializeArray();
        error_free = true;
        for (var input in form_data) {
            var element = $("#email_" + form_data[input]['name']);
            var valid = element.hasClass("valid");

           // var error_element = $("span", element.parent());
            if (!valid) {

                //error_element.removeClass("error").addClass("error_show");
                error_free = false;
            }
            else {
                error_element.removeClass("error_show").addClass("error");
            }
            */
        
        if (!error_free) {
            
            $("#error_span").html(msg);
            event.preventDefault();
            return false;
        }
    });

}
   
//the drafts by AJAX function
function formData() {

    var url = '/emails/test_ajax';

    //var myAttributes = $("#form").serialize()

    $.ajax({
        type: "POST",
        url: url,
        data: {
            //id for subject is registered as email_subject in the html
            //in controller, we have to display using params only, like params[:subject]
            "subject": $('#email_subject').val(),
            "receiver": $('#email_receiver_email').val(),
            "message": $('#email_message').val(),
            "id": $('#email_id').val()
        },

        success: function () {
            $('#para').html("Draft successfully saved!");
        },

        error: function () {

            $('#para').html("Draft not saved!");
        }


    });
}



//to check javascript function
function throughAjax(){

}
