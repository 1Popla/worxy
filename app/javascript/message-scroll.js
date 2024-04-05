document.addEventListener("DOMContentLoaded", function() {
  var messagesContainer = document.querySelector(".messages");
  if (messagesContainer) {
    messagesContainer.scrollTop = messagesContainer.scrollHeight;
  }
});
