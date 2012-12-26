$(function(){

    var whatTags = [ "2 bhk", "1 bhk", "3 bhk", "4 bhk", "5 bhk", "Flat", "Land", "Office", "Residential" ];
    $( "#what" ).autocomplete({
        source: whatTags
    });

    var whereTags = ["Hyderabad", "Secunderabad", "Bangalore", "Chennai", "Delhi", "Kolkata", "Gujarath", "Mumbai", "Ahmedabad"];
    $("#where").autocomplete({
       source: whereTags
    });


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

    $(".save_prop").click(function(){
        $("#save_property_#{result.id}").slideToggle();
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

  $(".remove_recent").live('click',function(){
   $(".recent").remove();
      $.post('/home/revert_recent')
      return false;
    });

//    $('.price').click(function(){$(".p").animate({width:'toggle'},5); });
//    $('.type').click(function(){$(".tp").animate({width:'toggle'},1); });

//  regular_search working ajax  start
//    $('.search_btn').click(function() {
//        var what = $('#what').val();
//        var where = $('#where').val();
//        $('radios').change(function(){});
//        var selected_btn = $('input[name=property_for]:checked').val();
//        var send_params = {what:what,where:where,property_for:selected_btn}
//        $.get('/home/side_nav',send_params);
//        $.get('/home/view_results',send_params);
//        return false;
//    });
//  regular_search working ajax  end

    $.extend({
        getUrlVars: function(){
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for(var i = 0; i < hashes.length; i++)
            {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        },
        getUrlVar: function(name){
            return $.getUrlVars()[name];
        }
    });

//    $('.type_link').bind('click',function(){
//        //filter links
//        return false;
//    });

    //Property Price selection
    $('#price_min_').live('change',function(){
        $('#price_min_ option:selected').each(function(){
            var price_min = $(this).val()
//            $.get('/home/view_results',price_min)
//            alert('hi')
//            window.location.search -= '&price_min='
            window.location += '&price_min='+price_min;
            return false;
        })
    });

    $('#price_max_').change(function(){
        $('#price_max_ option:selected').each(function(){
            var price_max = $(this).val()
            location.href = location.href + '&price_max='+price_max;
            return false
        })
    });
});