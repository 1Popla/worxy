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
            <h2 class="text-2xl font-semibold text-center mb-6 border-b pb-4">Szczegóły Rezerwacji</h2>
            <dl class="divide-y divide-gray-200 text-gray-700">
              <div class="py-3 flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
                <dt class="font-medium text-gray-900 sm:mr-4">Tytuł Ogłoszenia:</dt>
                <dd class="mt-1 sm:mt-0">${data.post.title}</dd>
              </div>
              <div class="py-3 flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
                <dt class="font-medium text-gray-900 sm:mr-4">Status:</dt>
                <dd class="mt-1 sm:mt-0">${data.status}</dd>
              </div>
              <div class="py-3 flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
                <dt class="font-medium text-gray-900 sm:mr-4">Data Rozpoczęcia:</dt>
                <dd class="mt-1 sm:mt-0">${new Date(data.start_date).toLocaleString()}</dd>
              </div>
              <div class="py-3 flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
                <dt class="font-medium text-gray-900 sm:mr-4">Data Zakończenia:</dt>
                <dd class="mt-1 sm:mt-0">${new Date(data.end_date).toLocaleString()}</dd>
              </div>
              <div class="py-3 flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
                <dt class="font-medium text-gray-900 sm:mr-4">Opis:</dt>
                <dd class="mt-1 sm:mt-0 sm:max-w-sm">${data.post.description}</dd>
              </div>
              <div class="py-3 flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
                <dt class="font-medium text-gray-900 sm:mr-4">Budżet:</dt>
                <dd class="mt-1 sm:mt-0">${data.post.price}</dd>
              </div>
              <div class="py-3 flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
                <dt class="font-medium text-gray-900 sm:mr-4">Informacje Kontaktowe:</dt>
                <dd class="mt-1 sm:mt-0">${data.post.contact_information}</dd>
              </div>
              <div class="py-3 flex flex-col sm:flex-row sm:justify-between sm:items-baseline">
                <dt class="font-medium text-gray-900 sm:mr-4">Zabookowane przez:</dt>
                <dd class="mt-1 sm:mt-0">${data.user.email}</dd>
              </div>
            </dl>
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
