(function() {
  var ensureLibs = function() {
    if (typeof ActionCable === 'undefined' || typeof Turbo === 'undefined') {
      setTimeout(ensureLibs, 100);
      return;
    }
    startApp();
  };

  var startApp = function() {
    if (!window.App) window.App = {};

    if (!window.App.cable) {
      window.App.cable = ActionCable.createConsumer();
    }

    var connectStreams = function() {
      var tags = document.querySelectorAll("turbo-cable-stream-source");
      
      tags.forEach(function(tag) {
        if (tag.dataset.connected) return;

        var channel = tag.getAttribute("channel");
        var signedName = tag.getAttribute("signed-stream-name");

        if (channel && signedName) {
          window.App.cable.subscriptions.create(
            { channel: channel, signed_stream_name: signedName },
            {
              connected() { 

              },
              received(data) {
                var parser = new DOMParser();
                var doc = parser.parseFromString(data, "text/html");
                var stream = doc.querySelector("turbo-stream");
                
                if (stream) {
                  var targetId = stream.getAttribute("target");
                  var content = stream.querySelector("template").innerHTML;
                  var targetElement = document.getElementById(targetId);
                  
                  if (targetElement) {
                    targetElement.insertAdjacentHTML("beforeend", content);

                    targetElement.scrollTop = targetElement.scrollHeight;
                  } 
                }
              }
            }
          );
          tag.dataset.connected = "true";
        }
      });
    };

    connectStreams();
    document.addEventListener("turbo:load", connectStreams);
  };

  ensureLibs();
})();