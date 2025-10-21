//= require jquery
//= require rails-ujs
//= require activestorage
//= require semantic-ui
//= require action_cable

$(document).on('turbo:load', function() {
  
  console.log("Turbo loaded. Running all JavaScript...");

  // 1. Initialize Dropdowns
  try {
    $('.ui.dropdown').dropdown();
    console.log("Dropdowns initialized.");
  } catch(e) {
    console.error("Dropdowns failed to initialize:", e);
  }

  // 2. Start Action Cable
  try {
    // Check if it's already running to avoid duplicates
    if (!window.App || !window.App.cable) {
      console.log("Creating Action Cable consumer...");
      window.App || (window.App = {});
      window.App.cable = ActionCable.createConsumer();
      console.log("Action Cable consumer created.");
    } else {
      console.log("Action Cable consumer already exists.");
    }
  } catch(e) {
    console.error("Action Cable failed to create consumer:", e);
    console.error("This usually means 'ActionCable' is not defined. Check your require statements.");
  }
  
});