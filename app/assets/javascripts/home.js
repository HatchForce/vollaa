$(function () {

    var whatTags = [ "2 bhk", "1 bhk", "3 bhk", "4 bhk", "5 bhk", "Flat", "Land", "Office", "Residential" ];
    $("#what").autocomplete({
        source:whatTags
    });

    var whereTags = ["Hyderabad", "Secunderabad", "Bangalore", "Chennai", "Delhi", "Kolkata", "Gujarath", "Mumbai", "Ahmedabad"];
    $("#where").autocomplete({
        source:whereTags
    });


    $('.email_property').live('click',function () {
        var id = ($(this).attr("data-property-id"));
        $('.send_details_form > #property_id').val(id);
        $(this).fancybox({
            closeBtn:false,
            beforeShow:function () {
                $('.send_details_form #emails').val('');
            },
            beforeClose:function () {
            }
        });
        return false;
    });

//    ### Save Property Start ###
    $(".save_prop").live('click', function () {
        $('#save_property_result.id').slideToggle();
        var prop_id = ($(this).attr("data-property-id"));
        var user_id = ($(this).attr("data-user-id"));
        var profile_id = $(this).attr("data-profile-id");
        if (prop_id != null || user_id != null) {
            $.ajax(
                {   type:'POST',
                    url:'/home/saved_properties',
                    data:{
                        'property_id':prop_id,
                        'user_id':user_id
                    }
                })
            $(this).text("Saved");
            $(this).attr("href", "../profiles/"+ profile_id);
            $(this).removeAttr("onclick");
            $(this).removeClass("save_prop");
            $(this).addClass('saved');
            return false;
        }
        else {
            return false;
        }
    });

//    ### Save Property End ###

    $('#email_submit').submit(function () {
        $.fancybox.close();
        return true;
    });

//  $(".regular_search").change(function(){
//    $(".adv_search").hide();
//      $(".for_hide").show();
//    });

    $(".advanced_search").click(function () {
//        $(".for_hide").remove();
//        $(".adv_search").show();
        $.ajax({
            type: 'GET',
            url: '/home/adv_search'
        });
    });

    $(".remove_recent").live('click', function () {
        $(".recent").remove();
        $.post('/home/revert_recent')
        return false;
    });

//    #### more less start ####
    $(".more").hide();
    $(".bed_more").live('click', function () {
        $(".more").slideDown();
        $(this).text("<<less");
        $(this).removeClass("bed_more");
        $(this).addClass("bed_less");
    });
    $(".bed_less").live('click', function () {
        $(".more").hide();
        $(this).text("more>>");
        $(this).removeClass("bed_less");
        $(this).addClass("bed_more");
    });
//    #### more less end ####

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

//    $('.type_link').bind('click',function(){
//        //filter links
//        return false;
//    });

    //Property Price selection
//    $('#price_min_').live('change', function () {
//        $('#price_min_ option:selected').each(function () {
//            var price_min = $(this).val()
////            window.location.search -= '&price_min='
////            url = window.location.href.split("?")[1]
//            window.location += '&price_min=' + price_min;
//            return false;
//        })
//    });
//
//    $('#price_max_').live('change',function () {
//        $('#price_max_ option:selected').each(function () {
//            var price_max = $(this).val()
//            location.href = location.href + '&price_max=' + price_max;
//            return false
//        })
//    });

//    // Property price Slider function

    if ((params["price_min"] != null) || (params["price_max"] != null)) {

        if ((params["price_min"]) != null && (params["price_max"]) != null) {
//            alert((params["price_min"]) + (params["price_max"]));
            var price_min = params["price_min"];
            var price_max = params["price_max"];
        }
        else if ((params["price_min"] != null) && (params["price_max"] == null)) {
            alert("coming pmn");
            var price_min = params["price_min"];
            var price_max = 10000000;
        }
        else if ((params["price_min"]) == null && (params["price_max"]) != null) {
            alert("coming pmx");
            var price_min = 100000;
            var price_max = params["price_max"];

        }
    }
    else {
        var price_min = 100000;
        var price_max = 10000000;
    }

    var PropertyPriceFilter = { min:100000, max:10000000 };

    if ((params["price_min"]) != null && (params["price_max"]) != null) {
        $("#filtered-price").val("Rs." + (params["price_min"]) + " - " + "Rs." + (params["price_max"]));
    }
    else if ((params["price_min"]) == null && (params["price_max"]) == null) {
        $("#filtered-price").val("Rs." + (PropertyPriceFilter.min) + " - " + "Rs." + (PropertyPriceFilter.max));
    }

    $("#property_price").slider({

        range:true,
        min:PropertyPriceFilter.min,
        max:PropertyPriceFilter.max,
        values:[ price_min, price_max ],

        slide:function (event, ui) {

            $("#filtered-price").val(("Rs." + ui.values[ 0 ]) + " - " + "Rs." + (ui.values[ 1 ]))
            PropertyPriceFilter.min = ui.values[ 0 ]
            PropertyPriceFilter.max = ui.values[ 1 ]

            window.location += '&price_min=' + PropertyPriceFilter.min + '&price_max=' + PropertyPriceFilter.max;
        }
    });

  $('.home_search_btn').live('click', function(){

        var search_url = "http://localhost:3000/home/results?commit=search&utf8=%E2%9C%93"
        var what = function () {
            if (params["what"] != null) {
                return ("&what=" + params["what"]);
            } else { return '' }
        }

        var where = function () {
            if (params["where"] != null) {
                return ("&where=" + params["where"])
            } else { return '' }
        }

        var property_for = function () {
            if (params["property_for"] != null) {
                return ("&property_for=" + params["property_for"])
            } else { return false }
        }

        var price_min = function () {
            if (params["price_min"] != null) {
                return ("&price_min=" + params["price_min"])
            } else { return false }
        }

        var price_max = function () {
            if (params["price_max"] != null) {
                return ("&price_max=" + params["price_max"])
            } else { return false}
        }

        var city = function () {
            if (params["city"] != null) {
                return ("&city=" + params["city"])
            } else { return false }
        }

        var property_type = function () {
            if (params["property_type"] != null) {
                return ("&property_type=" + params["property_type"])
            } else { return false }
        }

        var area_min = function () {
            if (params["area_min"] != null) {
                return ("&area_min=" + params["area_min"])
            } else { return false }
        }

        var area_max = function () {
            if (params["area_max"] != null) {
                return ("&area_max=" + params["area_max"])
            } else { return false }
        }

        window.location = search_url + what + where + property_for + property_type + price_min + price_max + area_min + area_max
  });
});
