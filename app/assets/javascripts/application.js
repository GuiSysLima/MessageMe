//= require jquery
//= require activestorage
//= require semantic-ui
//= require turbo
//= require actioncable
//= require custom_cable

var initDropdowns = function() {
  console.log("Reiniciando Dropdowns...");
  
  $('.ui.dropdown').dropdown('destroy');
  
  $('.ui.dropdown').dropdown({
    action: 'hide',
    onChange: function(value) {
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

$(document).on('turbo:frame-load', function() {
  var chatBox = document.getElementById("private_messages");
  if (chatBox) {
    chatBox.scrollTop = chatBox.scrollHeight;
  }
});