document.addEventListener('turbo:load', function () {
  // Check if the chart container exists before proceeding
  var chartContainer = document.getElementById('chart-container');
  if (chartContainer) {
    // Destroy existing chart instance if it exists
    if (window.bookingChart instanceof Chart) {
      window.bookingChart.destroy();
    }

    // Show the loading spinner if it exists
    var loadingSpinner = document.getElementById('loading-spinner');
    if (loadingSpinner) {
      loadingSpinner.classList.add('flex', 'items-center', 'justify-center');

      // Check if the loader already exists before creating a new one
      if (!loadingSpinner.querySelector('.loader')) {
        // Create and style loader
        var loader = document.createElement('div');
        loader.classList.add('loader', 'border-4', 'border-gray-200', 'border-solid', 'border-l-blue-600', 'w-9', 'h-9', 'rounded-full', 'animate-spin');
        loadingSpinner.appendChild(loader);
      }

      loadingSpinner.style.display = 'flex';
    }

    var ctx = document.getElementById('bookingChart').getContext('2d');
    window.bookingChart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: ['Wszystkie zlecenia', 'Zakończone zlecenia', 'Oczekujące zlecenia'],
        datasets: [{
          label: 'Zlecenia',
          data: [gon.all_bookings, gon.completed_bookings, gon.pending_bookings],
          backgroundColor: ['rgba(76, 175, 80, 0.5)', 'rgba(255, 152, 0, 0.5)', 'rgba(244, 67, 54, 0.5)'],
          borderColor: ['rgba(76, 175, 80, 1)', 'rgba(255, 152, 0, 1)', 'rgba(244, 67, 54, 1)'],
          borderWidth: 1
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        indexAxis: window.innerWidth < 768 ? 'y' : 'x', // Use horizontal layout on mobile
        scales: {
          y: {
            beginAtZero: true
          }
        },
        animation: {
          onComplete: function () {
            // Hide the loading spinner once the chart animation is complete
            if (loadingSpinner) {
              loadingSpinner.style.display = 'none';
            }
          }
        }
      }
    });
  }
});
