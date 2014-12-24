
//the drafts by AJAX function

function formData(){

    var url='/emails/test_ajax'

    var myAttributes = $("#form").serialize()

    $.ajax({
            type: "POST",
            url: url,
            data: {
                //id for subject is registered as email_subject in the html
                //in controller, we have to display using params only, like params[:subject]
                "subject": $('#email_subject').val(),
                "receiver": $('#email_receiver_email').val(),
                "message": $('#email_message').val()
            },

            success:function(response) {
                alert(response);
            }




        });
}


//to check javascript function
function throughAjax(){

    window.alert("Through AJAX!!");
}
