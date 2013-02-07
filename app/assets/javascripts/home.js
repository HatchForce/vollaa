$(function () {

    var whatTags = [ "Apartment", "House", "2 bhk", "1 bhk", "3 bhk", "4 bhk", "5 bhk", "Flat", "Land", "Office", "Residential" ];
    $("#what").autocomplete({
        source:whatTags
    });

    var whereTags = ["Hyderabad", "Secunderabad", "Bangalore", "Chennai", "Delhi", "Kolkata", "Gujarath", "Mumbai", "Ahmedabad"];
    $("#where").autocomplete({
        source:whereTags
    });


    $('.email_property').live('click', function () {
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
        var $prop_id = ($(this).attr("data-property-id"));
        var user_id = ($(this).attr("data-user-id"));
        var profile_id = $(this).attr("data-profile-id");
        var $this = $(this)
        if ($prop_id != null || user_id != null) {
            $.ajax(
                {   type:'POST',
                    url:'/home/saved_properties',
                    data:{
                        'property_id':$prop_id,
                        'user_id':user_id
                    }
                })
            $this.text("saving...");
            setTimeout(function () {
                $this.text('Saved');
            }, 500);
            setTimeout(function () {
                ($('#save_property_' + $prop_id)).slideUp();
            }, 2000);
//          $this.text("saving...").fadeIn(1000);
            $this.attr("href", "../profiles/" + profile_id);
            $this.removeAttr("onclick");
            $this.removeClass("save_prop");
            $this.addClass('saved');
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

    $(".hide_load_image").hide();

    $(".advanced_search").click(function () {
//        $(".for_hide").remove();
        $(".loading_adv_search").html("<img src='assets/loading_image.gif'>");
        $.ajax({
            type:'GET',
            url:'/home/adv_search'
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

    $(".more_type").hide();
    $(".p_type_more").live('click', function () {
        $(".more_type").slideDown();
        $(this).text("<<less");
        $(this).removeClass("p_type_more");
        $(this).addClass("p_type_less");
    });
    $(".p_type_less").live('click', function () {
        $(".more_type").hide();
        $(this).text("more>>");
        $(this).removeClass("p_type_less");
        $(this).addClass("p_type_more");
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

//    //------ Property price Slider function  Start------//
    $price_max = 100;
    $price_min = 0;
    if ((params["price_min"] != null) || (params["price_max"] != null)) {

        if ((params["price_min"]) != null && (params["price_max"]) != null) {
            var price_min = params["price_min"];
            var price_max = params["price_max"];
//            alert(price_min.toString() + " - " + price_max.toString());
        }
        else if ((params["price_min"] != null) && (params["price_max"] == null)) {
            alert("coming pmn");
            var price_min = params["price_min"];
            var price_max = $price_max;
        }
        else if ((params["price_min"]) == null && (params["price_max"]) != null) {
            alert("coming pmx");
            var price_min = $price_min;
            var price_max = params["price_max"];

        }
    }
    else {
        var price_min = $price_min;
        var price_max = $price_max;
    }

    var PropertyPriceFilter = { min:$price_min, max:$price_max };

    if ((params["price_min"]) != null && (params["price_max"]) != null) {
        $("#filtered-price").val("Rs." + currency(params["price_min"]) + " - " + "Rs." + currency(params["price_max"]));
    }
    else if ((params["price_min"]) == null && (params["price_max"]) == null) {
        $("#filtered-price").val("Min-price     :     Max-Price")
    }
    var trueValues = [0, 10000, 25000, 50000, 100000, 150000, 300000, 500000, 1000000, 2000000, 1500000, 2000000, 2500000, 3000000, 3500000, 4000000, 5000000, 10000000, 200000000, 500000000, 1000000000];
    var values = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100];
    var slider = $("#property_price").slider({
        orientation:'horizontal',
        range:true,
        animate:true,
        min:PropertyPriceFilter.min,
        max:PropertyPriceFilter.max,
        values:[ (price_min == 0) ? 0 : getSliderValue(price_min) , (price_max == 100) ? price_max : getSliderValue(price_max) ],
        slide:function (event, ui) {
            var includeLeft = event.keyCode != $.ui.keyCode.RIGHT;
            var includeRight = event.keyCode != $.ui.keyCode.LEFT;
            var value = findNearest(includeLeft, includeRight, ui.value);
            if (ui.value == ui.values[0]) {
                slider.slider('values', 0, value);
            }
            else {
                slider.slider('values', 1, value);
            }

            $("#filtered-price").val(("Rs." + currency(getRealValue(ui.values[ 0 ]))) + " - " + "Rs." + currency(getRealValue(ui.values[ 1 ])))

            PropertyPriceFilter.min = getRealValue(ui.values[ 0 ])
            PropertyPriceFilter.max = getRealValue(ui.values[ 1 ])
        },
        change:function (event, ui) {
            setTimeout(function () {
//                alert(PropertyPriceFilter.min + " - " + PropertyPriceFilter.max);
                window.location += '&price_min=' + PropertyPriceFilter.min + '&price_max=' + PropertyPriceFilter.max;
            }, 100);
        }
    });

    function findNearest(includeLeft, includeRight, value) {
        var nearest = null;
        var diff = null;
        for (var i = 0; i < values.length; i++) {
            if ((includeLeft && values[i] <= value) || (includeRight && values[i] >= value)) {
                var newDiff = Math.abs(value - values[i]);
                if (diff == null || newDiff < diff) {
                    nearest = values[i];
                    diff = newDiff;
                }
            }
        }
        return nearest;
    }

    function getRealValue(sliderValue) {
        for (var i = 0; i < values.length; i++) {
            if (values[i] >= sliderValue) {
                return trueValues[i];
            }
        }
        return 0;
    }

    function getSliderValue(sliderValue) {
        for (var i = 0; i < trueValues.length; i++) {
            if (trueValues[i] >= sliderValue) {
                return values[i];
            }
        }
        return 0;
    }

    function currency(numbr) {
        number = parseInt(numbr)
        if (number < 10000000 && number > 99999) {
            lk = (number / 100000)
            return (lk + " Lakhs")
        }
        else if (number > 9999999) {
            lk = (number / 10000000)
            return (lk + " Crores")
        }
        else if (number > 999 && number < 100000) {
            lk = (number / 1000)
            return (lk + " Thousands")
        }
        else {
            return number
        }
    }

//    //------ Property price Slider function  Ends------//


//    //------ Property AREA Slider function  Start------//
//    $area_max = 1000; $area_min = 0;
//    if ((params["area_min"] != null) || (params["area_max"] != null)) {
//
//        if ((params["area_min"]) != null && (params["area_max"]) != null) {
//            var area_min = params["area_min"];
//            var area_max = params["area_max"];
//        }
//        else if ((params["area_min"] != null) && (params["area_max"] == null)) {
//            var area_min = params["area_min"];
//            var area_max = $area_max;
//        }
//        else if ((params["area_min"]) == null && (params["area_max"]) != null) {
//            var area_min = $area_min;
//            var area_max = params["area_max"];
//
//        }
//    }
//    else {
//        var area_min = $area_min;
//        var area_max = $area_max;
//    }
//
//    var PropertyAreaFilter = { min:$area_min, max:$area_max };
//
//    if ((params["area_min"]) != null && (params["area_max"]) != null) {
//        $("#filtered-area").val((params["area_min"])+ " yards" + " - "  + (params["area_max"])+ " yards");
//    }
//    else if ((params["area_min"]) == null && (params["area_max"]) == null) {
//        $("#filtered-area").val("Min-area       :       Max-area")
//    }
//
//    $("#built_up_area").slider({
//
//        range:true,
//        min:PropertyAreaFilter.min,
//        max:PropertyAreaFilter.max,
//        values:[ area_min, area_max ],
//
//        slide:function (event, ui) {
//
//            $("#filtered-area").val(( ui.values[ 0 ])+ " yards" + " - " + (ui.values[ 1 ]) + " yards")
//            PropertyAreaFilter.min = ui.values[ 0 ]
//            PropertyAreaFilter.max = ui.values[ 1 ]
//
//            window.location += '&area_min=' + PropertyAreaFilter.min + '&area_max=' + PropertyAreaFilter.max;
//        }
//    });
//    //------ Property AREA Slider function  Ends------//


    $('.home_search_btn').live('click', function () {

        var search_url = "http://localhost:3000/home/results?commit=search&utf8=%E2%9C%93"
        var what = function () {
            if (params["what"] != null) {
                return ("&what=" + params["what"]);
            } else {
                return ''
            }
        }

        var where = function () {
            if (params["where"] != null) {
                return ("&where=" + params["where"])
            } else {
                return ''
            }
        }

        var property_for = function () {
            if (params["property_for"] != null) {
                return ("&property_for=" + params["property_for"])
            } else {
                return false
            }
        }

        var price_min = function () {
            if (params["price_min"] != null) {
                return ("&price_min=" + params["price_min"])
            } else {
                return false
            }
        }

        var price_max = function () {
            if (params["price_max"] != null) {
                return ("&price_max=" + params["price_max"])
            } else {
                return false
            }
        }

        var city = function () {
            if (params["city"] != null) {
                return ("&city=" + params["city"])
            } else {
                return false
            }
        }

        var property_type = function () {
            if (params["property_type"] != null) {
                return ("&property_type=" + params["property_type"])
            } else {
                return false
            }
        }

        var area_min = function () {
            if (params["area_min"] != null) {
                return ("&area_min=" + params["area_min"])
            } else {
                return false
            }
        }

        var area_max = function () {
            if (params["area_max"] != null) {
                return ("&area_max=" + params["area_max"])
            } else {
                return false
            }
        }

        window.location = search_url + what + where + property_for + property_type + price_min + price_max + area_min + area_max
    });
});