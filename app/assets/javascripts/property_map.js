$(document).ready(function () {


    Gmaps.map.callback = function () {

        var PopulationFilter = {
            min:800000,
            max:10000000
        };

        $("#filtered-pop").val((PopulationFilter.min) + " - " + (PopulationFilter.max))
        $("#population-range").slider({
            range:true,
            min:PopulationFilter.min,
            max:PopulationFilter.max,
            values:[ PopulationFilter.min, PopulationFilter.max ],
            slide:function (event, ui) {
                $("#filtered-pop").val((ui.values[ 0 ]) + " - " + (ui.values[ 1 ]))
                PopulationFilter.min = ui.values[ 0 ]
                PopulationFilter.max = ui.values[ 1 ]
                applyFilters()
            }
        });

        var VisibleMarkers = function () {
            var filtered = _.reject(Gmaps.map.markers, function (marker) {
                return marker.prop_details < PopulationFilter.min || marker.prop_details > PopulationFilter.max;
            });
            return filtered
        }

        var applyFilters = function () {
            _.each(Gmaps.map.markers, function (marker) {
                Gmaps.map.hideMarker(marker)
            })
            _.each(VisibleMarkers(), function (marker) {
                Gmaps.map.showMarker(marker)
            })
        };
    }

    $('#markers').live('mouseenter', function () {
        $(this).addClass("marker_hover");
        $(this).removeClass('marker');
//        $(this).
    });

    $('#markers').live('mouseout', function () {
        $(this).addClass("marker");
        $(this).removeClass('marker_hover');
    });

    $('#markers').live('click',function(){
//        $(this).modal('show')
    });

    Gmaps.map.infobox = function(boxText) {
        return {
            content: boxText
            ,disableAutoPan: false
            ,maxWidth: 0
            ,pixelOffset: new google.maps.Size(-140, 0)
            ,zIndex: null
            ,boxStyle: {
                background: "url('http://google-maps-utility-library-v3.googlecode.com/svn/tags/infobox/1.1.5/examples/tipbox.gif') no-repeat"
                ,opacity: 0.75
                ,width: "280px"
            }
            ,closeBoxMargin: "10px 3px 3px 3px"
            ,closeBoxURL: "http://www.google.com/intl/en_us/mapfiles/close.gif"
            ,infoBoxClearance: new google.maps.Size(1, 1)
            ,isHidden: false
            ,pane: "floatPane"
            ,enableEventPropagation: false
    }};


});