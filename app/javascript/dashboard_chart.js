document.addEventListener('turbo:load', function () {
  function updateEarningsChart() {
    const checkedCheckboxes = document.querySelectorAll('.include-booking-checkbox:checked');
    const titles = [];
    const prices = [];
    let totalEarnings = 0;

    checkedCheckboxes.forEach(checkbox => {
      const bookingId = checkbox.getAttribute('data-booking-id');
      const row = checkbox.closest('tr');
      const title = row.querySelector('td:nth-child(1) a').innerText;
      const price = parseFloat(row.querySelector('td:nth-child(3)').innerText.replace(/[^0-9.-]+/g, ""));

      titles.push(title);
      prices.push(price);
      totalEarnings += price;
    });

    if (window.earningsChart) {
      window.earningsChart.data.labels = titles;
      window.earningsChart.data.datasets[0].data = prices;
      window.earningsChart.update();
    }

    const totalEarningsElement = document.getElementById('total-earnings');
    if (totalEarningsElement) {
      totalEarningsElement.innerText = `Łączne Zarobki: ${totalEarnings.toFixed(2)} PLN`;
    }
  }

  function loadCheckboxStates() {
    const savedStates = JSON.parse(localStorage.getItem('checkboxStates')) || {};
    document.querySelectorAll('.include-booking-checkbox').forEach(checkbox => {
      const bookingId = checkbox.getAttribute('data-booking-id');
      checkbox.checked = savedStates[bookingId] === true;
    });
  }

  function saveCheckboxStates() {
    const states = {};
    document.querySelectorAll('.include-booking-checkbox').forEach(checkbox => {
      const bookingId = checkbox.getAttribute('data-booking-id');
      states[bookingId] = checkbox.checked;
    });
    localStorage.setItem('checkboxStates', JSON.stringify(states));
  }

  const chartContainer = document.getElementById('chart-container');
  if (chartContainer) {
    if (window.bookingChart instanceof Chart) {
      window.bookingChart.destroy();
    }

    const loadingSpinner = document.getElementById('loading-spinner');
    if (loadingSpinner) {
      loadingSpinner.classList.add('flex', 'items-center', 'justify-center');

      if (!loadingSpinner.querySelector('.loader')) {
        const loader = document.createElement('div');
        loader.classList.add('loader', 'border-4', 'border-gray-200', 'border-solid', 'border-l-blue-600', 'w-9', 'h-9', 'rounded-full', 'animate-spin');
        loadingSpinner.appendChild(loader);
      }

      loadingSpinner.style.display = 'flex';
    }

    const ctx = document.getElementById('bookingChart').getContext('2d');
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
        indexAxis: window.innerWidth < 768 ? 'y' : 'x',
        scales: {
          y: {
            beginAtZero: true
          }
        },
        animation: {
          onComplete: function () {
            if (loadingSpinner) {
              loadingSpinner.style.display = 'none';
            }
          }
        }
      }
    });
  }

  const earningsChartContainer = document.getElementById('earnings-chart-container');
  if (earningsChartContainer) {
    if (window.earningsChart instanceof Chart) {
      window.earningsChart.destroy();
    }

    const earningsLoadingSpinner = document.getElementById('earnings-loading-spinner');
    if (earningsLoadingSpinner) {
      earningsLoadingSpinner.classList.add('flex', 'items-center', 'justify-center');

      if (!earningsLoadingSpinner.querySelector('.loader')) {
        const loader = document.createElement('div');
        loader.classList.add('loader', 'border-4', 'border-gray-200', 'border-solid', 'border-l-blue-600', 'w-9', 'h-9', 'rounded-full', 'animate-spin');
        earningsLoadingSpinner.appendChild(loader);
      }

      earningsLoadingSpinner.style.display = 'flex';
    }

    const earningsCtx = document.getElementById('earningsChart').getContext('2d');
    window.earningsChart = new Chart(earningsCtx, {
      type: 'pie',
      data: {
        labels: gon.booking_titles,
        datasets: [{
          label: 'Zarobki',
          data: gon.booking_prices,
          backgroundColor: ['rgba(76, 175, 80, 0.5)', 'rgba(255, 152, 0, 0.5)', 'rgba(244, 67, 54, 0.5)', 'rgba(33, 150, 243, 0.5)', 'rgba(156, 39, 176, 0.5)'],
          borderColor: ['rgba(76, 175, 80, 1)', 'rgba(255, 152, 0, 1)', 'rgba(244, 67, 54, 1)', 'rgba(33, 150, 243, 1)', 'rgba(156, 39, 176, 1)'],
          borderWidth: 1
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          tooltip: {
            callbacks: {
              label: function(tooltipItem) {
                return `${tooltipItem.label}: ${tooltipItem.raw.toLocaleString('pl-PL', {style: 'currency', currency: 'PLN'})}`;
              }
            }
          }
        },
        animation: {
          onComplete: function () {
            if (earningsLoadingSpinner) {
              earningsLoadingSpinner.style.display = 'none';
            }
          }
        }
      }
    });

    loadCheckboxStates();
    updateEarningsChart();
  }

  loadCheckboxStates();

  document.querySelectorAll('.include-booking-checkbox').forEach(checkbox => {
    checkbox.addEventListener('change', function() {
      const bookingId = this.getAttribute('data-booking-id');
      const includeInChart = this.checked;

      fetch('/dashboard/update_booking_in_chart', {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({
          id: bookingId,
          include_in_chart: includeInChart
        })
      })
      .then(response => {
        if (response.ok) {
          saveCheckboxStates();
          updateEarningsChart();
        }
      });
    });
  });
});
