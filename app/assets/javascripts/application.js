// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap
//= require jquery.fancybox
//= require_self
//= require solr-autocomplete/ajax-solr/core/Core
//= require solr-autocomplete/ajax-solr/core/AbstractManager
//= require solr-autocomplete/ajax-solr/managers/Manager.jquery
//= require solr-autocomplete/ajax-solr/core/Parameter
//= require solr-autocomplete/ajax-solr/core/ParameterStore
//= require solr-autocomplete/jquery-autocomplete/jquery.autocomplete

$(document).ready(function(){

  //set iframe height
  $('iframe').height($(window).height());

  //close iframe
  $('.iframe_close').click(function(){
    window.location = $('.iframe_content').find('iframe').attr('src');
    return false;
  });
});


