document.addEventListener('turbo:load', function () {
  const modal = document.getElementById('bookingModal');
  const modalContent = document.getElementById('modalContent');
  const closeModal = document.getElementById('closeModal');

  if (modal && modalContent && closeModal) {
    document.querySelectorAll('[data-booking-id]').forEach(element => {
      element.addEventListener('click', function () {
        const bookingId = this.getAttribute('data-booking-id');

        fetch(`/bookings/${bookingId}`, {
          headers: {
            'Accept': 'application/json'
          }
        })
        .then(response => response.json())
        .then(data => {
          modalContent.innerHTML = `
            <h2 class="text-xl font-semibold mb-4">Szczegóły Rezerwacji</h2>
            <p><strong>Tytuł Ogłoszenia:</strong> ${data.post.title}</p>
            <p><strong>Status:</strong> ${data.status}</p>
            <p><strong>Data Rozpoczęcia:</strong> ${new Date(data.start_date).toLocaleString()}</p>
            <p><strong>Data Zakończenia:</strong> ${new Date(data.end_date).toLocaleString()}</p>
            <p><strong>Opis:</strong> ${data.post.description}</p>
            <p><strong>Cena:</strong> ${data.post.price}</p>
            <p><strong>Informacje Kontaktowe:</strong> ${data.post.contact_information}</p>
            <p><strong>Zabookowane przez:</strong> ${data.user.email}</p>
          `;

          modal.classList.remove('hidden');
        });
      });
    });

    closeModal.addEventListener('click', function () {
      modal.classList.add('hidden');
    });
  }
});
