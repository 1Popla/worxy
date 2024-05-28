document.addEventListener('turbo:load', () => {
    const averageRating = document.getElementById('user-average-rating').dataset.averageRating;
    if (averageRating <= 2) {
      const modal = document.getElementById('low-rating-modal');
      const closeModalButton = document.getElementById('close-modal-button');
      
      modal.classList.remove('hidden');
      
      closeModalButton.addEventListener('click', () => {
        modal.classList.add('hidden');
      });
    }
  });
  