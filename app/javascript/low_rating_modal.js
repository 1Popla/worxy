document.addEventListener('turbo:load', () => {
  const averageRatingElement = document.getElementById('user-average-rating');
  const averageRating = averageRatingElement ? averageRatingElement.dataset.averageRating : null;

  if (averageRating !== null && averageRating <= 2) {
    const modal = document.getElementById('low-rating-modal');
    const closeModalButton = document.getElementById('close-modal-button');
    
    modal.classList.remove('hidden');
    
    closeModalButton.addEventListener('click', () => {
      modal.classList.add('hidden');
    });
  }
});
