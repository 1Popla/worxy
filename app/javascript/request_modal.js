document.addEventListener('turbo:load', function() {
    const openModalButton = document.getElementById('open-modal');
    const cancelModalButton = document.getElementById('cancel-modal');
    const requestModal = document.getElementById('request-modal');
  
    if (openModalButton && cancelModalButton && requestModal) {
      openModalButton.addEventListener('click', function() {
        requestModal.classList.remove('hidden');
      });
  
      cancelModalButton.addEventListener('click', function() {
        requestModal.classList.add('hidden');
      });
    }
  });
  