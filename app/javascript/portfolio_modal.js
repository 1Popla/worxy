document.addEventListener('turbo:load', () => {
  const openPortfolioButton = document.getElementById('open-portfolio');
  const closePortfolioButton = document.getElementById('user-show-close-portfolio');
  const portfolioModal = document.getElementById('user-show-portfolio-modal');

  if (openPortfolioButton && closePortfolioButton && portfolioModal) {
    openPortfolioButton.addEventListener('click', () => {
      portfolioModal.classList.remove('hidden');
    });

    closePortfolioButton.addEventListener('click', () => {
      portfolioModal.classList.add('hidden');
    });
  }
});

document.addEventListener('turbo:load', () => {
  [...Array(6).keys()].forEach(i => {
    const input = document.getElementById(`upload-input-${i}`);
    const plusSign = document.getElementById(`plus-sign-${i}`);
    const uploadedImage = document.getElementById(`uploaded-image-${i}`);
    
    if (input && plusSign && uploadedImage) {
      input.addEventListener('change', (event) => {
        const file = event.target.files[0];
        if (file) {
          const reader = new FileReader();
          reader.onload = (e) => {
            plusSign.classList.add('hidden');
            uploadedImage.src = e.target.result;
            uploadedImage.classList.remove('hidden');
          };
          reader.readAsDataURL(file);
        }
      });
    }
  });
});

document.addEventListener('turbo:load', () => {
  const thumbnails = document.querySelectorAll('.user-show-thumbnail');
  const lightbox = document.getElementById('user-show-lightbox');
  const lightboxImage = document.getElementById('user-show-lightbox-image');
  const lightboxThumbnails = document.getElementById('user-show-lightbox-thumbnails');
  const closeLightbox = document.getElementById('user-show-close-lightbox');
  const prevImage = document.getElementById('user-show-prev-image');
  const nextImage = document.getElementById('user-show-next-image');
  
  if (!thumbnails || !lightbox || !lightboxImage || !lightboxThumbnails || !closeLightbox || !prevImage || !nextImage) return;
  
  const images = Array.from(thumbnails).map(thumbnail => thumbnail.dataset.fullUrl);

  let currentIndex = 0;

  function updateLightboxImage(index) {
    lightboxImage.src = images[index];
    lightboxThumbnails.innerHTML = images.map((src, i) => `
      <img src="${src}" class="cursor-pointer w-16 h-16 object-contain ${i === index ? 'border-2 border-blue-500' : ''}" data-index="${i}">
    `).join('');
  }

  thumbnails.forEach((thumbnail, index) => {
    thumbnail.addEventListener('click', () => {
      currentIndex = index;
      updateLightboxImage(currentIndex);
      lightbox.classList.remove('hidden');
    });
  });

  lightboxThumbnails.addEventListener('click', event => {
    if (event.target.tagName === 'IMG') {
      currentIndex = parseInt(event.target.dataset.index);
      updateLightboxImage(currentIndex);
    }
  });

  prevImage.addEventListener('click', () => {
    currentIndex = (currentIndex - 1 + images.length) % images.length;
    updateLightboxImage(currentIndex);
  });

  nextImage.addEventListener('click', () => {
    currentIndex = (currentIndex + 1) % images.length;
    updateLightboxImage(currentIndex);
  });

  closeLightbox.addEventListener('click', () => {
    lightbox.classList.add('hidden');
  });
  
  document.addEventListener('turbo:load', () => {
    const deleteButtons = document.querySelectorAll('.delete-image-button');
  
    deleteButtons.forEach(button => {
      button.addEventListener('click', (event) => {
        event.preventDefault();
  
        if (confirm('Are you sure you want to delete this image?')) {
          const imageId = event.target.closest('form').action.split('/').pop();
          fetch(event.target.closest('form').action, {
            method: 'DELETE',
            headers: {
              'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
              'Accept': 'text/vnd.turbo-stream.html'
            }
          })
          .then(response => {
            if (response.ok) {
              document.getElementById(`image-container-${imageId}`).remove();
            } else {
              alert('Failed to delete the image.');
            }
          });
        }
      });
    });
  });  
});
