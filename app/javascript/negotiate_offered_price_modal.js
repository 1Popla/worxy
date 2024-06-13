document.addEventListener('turbo:load', function() {
    const openModalBtn = document.getElementById('negotiate-modal-open-btn');
    const closeModalBtn = document.getElementById('negotiate-modal-close-btn');
    const modal = document.getElementById('negotiate-modal');
  
    if (openModalBtn && closeModalBtn && modal) {
      openModalBtn.addEventListener('click', function() {
        modal.classList.remove('hidden');
        modal.classList.add('flex');
      });
  
      closeModalBtn.addEventListener('click', function() {
        modal.classList.remove('flex');
        modal.classList.add('hidden');
      });
    }
  });
  