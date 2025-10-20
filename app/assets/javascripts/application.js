//= require jquery
//= require rails-ujs
//= require activestorage
//= require semantic-ui

// Log to prove the file is loading at all
console.log("application.js loaded");

// Function to initialize dropdowns
function initializeDropdowns() {
  console.log("Running initializeDropdowns()...");
  
  // Find all dropdowns on the page
  var dropdowns = $('.ui.dropdown');
  
  // Log what we found
  console.log("Found " + dropdowns.length + " dropdowns.");

  // Initialize them
  dropdowns.dropdown();
}

// Run the function on 'turbo:load'
$(document).on('turbo:load', function() {
  console.log("'turbo:load' event fired.");
  initializeDropdowns();
});

// As a fallback, run it on the classic 'ready' event too
$(document).ready(function() {
  console.log("'document.ready' event fired.");
  initializeDropdowns();
});