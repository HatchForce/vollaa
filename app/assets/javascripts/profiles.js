$("#remove_save_prop").live('click', function () {
    var property_id = $(this).attr("data-property-id");
    var user_id = $(this).attr("data-user-id");
    $.ajax(
        {   type:'POST',
            url:'../home/remove_save_prop',
            data:{
                'property_id':property_id,
                'user_id':user_id
            }
        });
    $('.sav_prop_'+property_id).remove();
    return false;
});
