$(document).ready(function() {


    Gmaps.map.callback = function() {

        var PopulationFilter = {
            min: 800000,
            max: 10000000
        };

        $( "#filtered-pop" ).val( (PopulationFilter.min)+ " - " + (PopulationFilter.max))
        $("#population-range").slider({
            range: true,
            min: PopulationFilter.min,
            max: PopulationFilter.max,
            values: [ PopulationFilter.min, PopulationFilter.max ],
            slide: function(event, ui) {
                $( "#filtered-pop" ).val( (ui.values[ 0 ])+ " - " + (ui.values[ 1 ]))
                PopulationFilter.min = ui.values[ 0 ]
                PopulationFilter.max = ui.values[ 1 ]
                applyFilters()
            }
        });

        var VisibleMarkers = function() {
            var filtered = _.reject(Gmaps.map.markers, function(marker) {
                return marker.prop_details < PopulationFilter.min || marker.prop_details > PopulationFilter.max;
            });
            return filtered
        }

        var applyFilters = function() {
            _.each(Gmaps.map.markers, function(marker) {
                Gmaps.map.hideMarker(marker)
            })
            _.each(VisibleMarkers(), function(marker) {
                Gmaps.map.showMarker(marker)
            })
        };
    }


});