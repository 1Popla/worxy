document.addEventListener('turbo:load', () => {
    const starLabels = document.querySelectorAll('.star-label');
    const selectedRating = document.getElementById('selected-rating');

    starLabels.forEach(label => {
      label.addEventListener('click', (event) => {
        const starValue = event.currentTarget.querySelector('svg').getAttribute('data-star');
        updateStars(starValue);
        selectedRating.textContent = `Wybrano: ${starValue} gwiazdek`;
      });
    });

    function updateStars(starValue) {
      starLabels.forEach(label => {
        const svg = label.querySelector('svg');
        const star = svg.getAttribute('data-star');
        if (star <= starValue) {
          svg.classList.remove('text-gray-300');
          svg.classList.add('text-yellow-400');
        } else {
          svg.classList.remove('text-yellow-400');
          svg.classList.add('text-gray-300');
        }
      });
    }
  });