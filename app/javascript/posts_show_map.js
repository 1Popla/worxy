function initShowPostMap() {
  var mapElement = document.getElementById('showMap');
  if (mapElement) {
    var postLocation = { lat: parseFloat(mapElement.dataset.lat), lng: parseFloat(mapElement.dataset.lng) };
    var map = new google.maps.Map(mapElement, {
      center: postLocation,
      zoom: 10
    });

    new google.maps.Marker({
      position: postLocation,
      map: map
    });
  }
}

function switchImage(event) {
  const thumbnails = document.querySelectorAll('.thumbnail');
  thumbnails.forEach(thumbnail => thumbnail.classList.remove('border-2', 'border-blue-500'));
  event.target.classList.add('border-2', 'border-blue-500');
  const mainImage = document.getElementById('main-image');
  const fullUrl = event.target.dataset.fullUrl;
  mainImage.src = fullUrl;
}

document.addEventListener('turbo:load', function () {
  document.querySelectorAll('.thumbnail').forEach(thumbnail => {
    thumbnail.addEventListener('click', switchImage);
  });

  const mainImageContainer = document.getElementById('main-image-container');
  const lightbox = document.getElementById('lightbox');
  const lightboxImage = document.getElementById('lightbox-image');
  const lightboxThumbnails = document.getElementById('lightbox-thumbnails');
  const closeLightbox = document.getElementById('close-lightbox');
  const prevImage = document.getElementById('prev-image');
  const nextImage = document.getElementById('next-image');
  const images = Array.from(document.querySelectorAll('.thumbnail')).map(thumb => thumb.dataset.fullUrl);

  let currentIndex = 0;

  function updateLightboxImage(index) {
    lightboxImage.src = images[index];
    lightboxThumbnails.innerHTML = images.map((src, i) => `
      <img src="${src}" class="cursor-pointer w-16 h-16 object-contain ${i === index ? 'border-2 border-blue-500' : ''}" data-index="${i}">
    `).join('');
  }

  if (mainImageContainer) {
    mainImageContainer.addEventListener('click', function () {
      currentIndex = images.indexOf(mainImageContainer.querySelector('img').dataset.fullUrl);
      updateLightboxImage(currentIndex);
      lightbox.classList.remove('hidden');
    });
  }

  if (lightboxThumbnails) {
    lightboxThumbnails.addEventListener('click', function (event) {
      if (event.target.tagName === 'IMG') {
        currentIndex = parseInt(event.target.dataset.index);
        updateLightboxImage(currentIndex);
      }
    });
  }

  if (prevImage) {
    prevImage.addEventListener('click', function () {
      currentIndex = (currentIndex - 1 + images.length) % images.length;
      updateLightboxImage(currentIndex);
    });
  }

  if (nextImage) {
    nextImage.addEventListener('click', function () {
      currentIndex = (currentIndex + 1) % images.length;
      updateLightboxImage(currentIndex);
    });
  }

  if (closeLightbox) {
    closeLightbox.addEventListener('click', function () {
      lightbox.classList.add('hidden');
    });
  }

  document.querySelectorAll("[id^='upload-input-']").forEach(input => {
    input.addEventListener('change', function() {
      handleImageUpload(this.files);
    });
  });

  function handleImageUpload(files) {
    const containers = document.querySelectorAll("[id^='upload-container-']");
    let fileIndex = 0;
    
    containers.forEach((container, index) => {
      if (fileIndex >= files.length) return;

      const input = container.querySelector("input[type='file']");
      const plusSign = container.querySelector("span[id^='plus-sign-']");
      const img = container.querySelector("img[id^='uploaded-image-']");

      if (input && plusSign && img && !img.src) {
        const file = files[fileIndex];
        const reader = new FileReader();
        
        reader.onload = function(e) {
          plusSign.classList.add('hidden');
          img.src = e.target.result;
          img.classList.remove('hidden');
        };

        reader.readAsDataURL(file);
        fileIndex++;
      }
    });
  }

  initShowPostMap();
});
