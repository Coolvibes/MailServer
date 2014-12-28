
function validate_data(){

    //Client side validations

    <!--Subject can't be blank-->
    /*var ele = $('#email_subject');
    var is_filled=ele.val();
    if(is_filled){ele.removeClass("invalid").addClass("valid");}
    else{ele.removeClass("valid").addClass("invalid");}*/


   $('#submit_button').click(function(event) {

        var ele = $('#email_subject');
        var is_filled = ele.val();
        if (is_filled) {
            ele.removeClass("invalid").addClass("valid");
        }
        else {
            ele.removeClass("valid").addClass("invalid");
        }

        var form_data = $("#form").serializeArray();
        var error_free = true;
        for (var input in form_data) {
            var element = $("#email_" + form_data[input]['name']);
            var valid = element.hasClass("valid");

            var error_element = $("span", element.parent());
            if (!valid) {
                error_element.removeClass("error").addClass("error_show");
                error_free = false;
            }
            else {
                error_element.removeClass("error_show").addClass("error");
            }
        }
        if (!error_free) {
            //alert("Error submitting form!");
            $("#error_span").html("Errors filling form.")
            event.preventDefault();
            return false;
        }
        else {
            alert('No errors in input: Mail is sent');
        }
    });


//the drafts by AJAX function
function formData(){

    //window.alert("In formdata!")

    var url='/emails/test_ajax'

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

            success:function() {
                $('#para').html("Draft successfully saved!") ;
                //alert(response);
            },

            error:function(){

                $('#para').html("Draft not saved!");
            }




        });
}


//to check javascript function
function throughAjax(){

    window.alert("Through AJAX!!");
}
