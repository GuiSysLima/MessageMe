//= require jquery
//= require rails-ujs
//= require activestorage
//= require semantic-ui

var initDropdowns = function() {
  console.log("Reiniciando Dropdowns...");
  
  $('.ui.dropdown').dropdown('destroy');
  
  $('.ui.dropdown').dropdown({
    action: 'hide',
    onChange: function(value, text, $selectedItem) {
      console.log("Selecionado: " + value);
    }
  });
};

$(document).on('turbo:load', initDropdowns);
$(document).on('turbo:render', initDropdowns);

$(document).on('click', '.ui.dropdown', function(e) {
  if (!$(this).hasClass('active')) {
    $(this).dropdown('show');
  }
});