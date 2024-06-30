document.addEventListener("turbo:load", function() {
  const submitButton = document.getElementById('posts-new-submit-button');
  const loadingModal = document.getElementById('posts-new-loading-modal');
  
  if (submitButton && loadingModal) {
    const form = submitButton.closest('form');
    
    if (form) {
      form.addEventListener('submit', function(event) {
        submitButton.disabled = true;
        loadingModal.classList.remove('hidden');
      });
  
      document.addEventListener('turbo:submit-end', function(event) {
        submitButton.disabled = false;
        loadingModal.classList.add('hidden');
      });
  
      document.addEventListener('turbo:before-cache', function() {
        submitButton.disabled = false;
        loadingModal.classList.add('hidden');
      });
    }
  }
});
