document.addEventListener('turbo:load', () => {
  const openPortfolioButton = document.getElementById('open-portfolio');
  const closePortfolioButton = document.getElementById('close-portfolio');
  const portfolioModal = document.getElementById('portfolio-modal');

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
