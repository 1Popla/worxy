  function scrollToBottom() {
    const messagesDiv = document.getElementById("messages");
    if (messagesDiv) {
      messagesDiv.scrollTop = messagesDiv.scrollHeight;
    }
  }

  document.addEventListener("turbo:load", function() {
    scrollToBottom();

    const messageBody = document.getElementById("message_body");
    if (messageBody) {
      messageBody.addEventListener("keydown", function(event) {
        if (event.key === "Enter" && !event.shiftKey) {
          event.preventDefault();
          const newMessageForm = document.getElementById("new_message");
          if (newMessageForm) {
            newMessageForm.requestSubmit();
          }
        }
      });
    }

    const messagesDiv = document.getElementById("messages");
    if (messagesDiv) {
      const observer = new MutationObserver(scrollToBottom);
      observer.observe(messagesDiv, { childList: true });
    }
  });

  document.addEventListener("turbo:submit-end", function(event) {
    const form = event.target;
    if (form && form.id === "new_message") {
      const messageBody = document.getElementById("message_body");
      if (messageBody) {
        messageBody.value = "";
        scrollToBottom();
      }
    }
  });

  document.addEventListener("turbo:frame-render", function(event) {
    scrollToBottom();
  });