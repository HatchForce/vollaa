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

//  $(".regular_search").change(function(){
//    $(".adv_search").hide();
//      $(".for_hide").show();
//    });

  $(".advanced_search").click(function(){
      $(".for_hide").hide();
      $(".adv_search").show();
   });

  $(".remove_recent").click(function(){
   $(".recent").remove();
      $.post('/home/revert_recent')
      return false;
    });



    $('.search_btn').click(function() {

        var what = $('#what').val();
        var where = $('#where').val();
        $('radios').change(function(){});
        var selected_btn = $('input[name=property_for]:checked').val();
        $.get('/home/view_results',{what:what,where:where,property_for:selected_btn});
        return false;
    });
});