var unsaved;

function check_before(){

unsaved = true;

//function to trigger change in case of any input change

$(":input").change(function(){

    //we need to change data-no-turbolink in order for the onbeforeunload to execute
    $('body').attr("data-no-turbolink", "true");
    unsaved = true;
});

function unloadPage(){
    if(unsaved){
        return "You have unsaved changes on this page.Are you sure you want to leave?";
    }
}

//to turn off verification in case of any submit button

$("input[type='submit']").click(function() {
    unsaved = false;
});



window.onbeforeunload = unloadPage;
}