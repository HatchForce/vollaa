$(function(){
  $('.email_property').click(function(){
     var id = ($(this).attr("data-property-id"));
    $('.send_details_form > #property_id').val(id);
    $(this).fancybox({
      closeBtn: false,
      beforeShow: function(){
        $('.send_details_form #emails').val('');
      },
        beforeClose: function() {

      }
    });
    return false;
  });

  $('#email_submit').submit(function(){
    $.fancybox.close();
    return true;
  });

});