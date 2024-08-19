document.addEventListener('turbo:load', function() {
  const tutorialButton = document.getElementById('tutorial-button');
  const expandMenuButton = document.getElementById('expanded-tutorial-button');
  const overlay = document.getElementById('tutorial-overlay');
  const introBox = document.getElementById('tutorial-intro');
  const stepBox = document.getElementById('tutorial-step');
  const startButton = document.getElementById('tutorial-start');
  const nextButton = document.getElementById('tutorial-next');
  const tutorialText = document.getElementById('tutorial-text');

  const steps = [
    { 
      element: 'dashboard-link', 
      mobileElement: 'mobile-dashboard-link', 
      offset: 50, 
      text: "W prawym dolnym rogu, widoczny jest panel głowny. Jako użytkownik zobaczysz tam raporty Twojego profilu oraz zbiór powiadomień.", 
      detailed_text: "Dashboard jest centralnym miejscem, gdzie możesz zobaczyć najważniejsze informacje dotyczące Twojego konta.",
    },
    { 
      element: 'new-post-link', 
      mobileElement: 'expanded-new-post-link', 
      offset: 50, 
      text: "W zakładce powyżej, możesz dodać post w którym opiszesz swoje zlecenie oraz ustalisz wszystkie ważne do jego realizacji szczegóły.",
      detailed_text: "Tutaj możesz dodać nowe ogłoszenie, które będzie widoczne dla wszystkich użytkowników.",
    },
    { 
      element: 'posts-link', 
      mobileElement: 'mobile-posts-link', 
      offset: 50, 
      text: "W lewym dolnym rogu, widoczna jest strona zleceń. To w tym miejscu możesz wyszukać potencjalnych klientów lub zleceniobiorców.",
      detailed_text: "W tej sekcji możesz przeglądać wszystkie dostępne ogłoszenia.",
    },
    { 
      element: 'user-posts-link', 
      mobileElement: 'expanded-user-posts-link', 
      offset: 50, 
      text: "Zakladka 'Moje ogłoszenia' umożliwia Ci przeglądanie ogłoszeń, które utworzyłeś.",
      detailed_text: "W tej sekcji znajdują się wszystkie ogłoszenia, które sam opublikowałeś.",
    },
    { 
      element: 'conversations-link', 
      mobileElement: 'expanded-conversations-link', 
      offset: 50, 
      text: "W zakladce 'Wiadomości', znajdziesz swoje aktywne konwersacje, oraz utworzysz nowe.",
      detailed_text: "Tutaj znajdziesz wszystkie wiadomości, które otrzymałeś od innych użytkowników.",
    },
    { 
      element: 'notifications-link', 
      mobileElement: 'expanded-notifications-link', 
      offset: 50, 
      text: "W sekcji powiadomień, będą widoczne aktualności Twoich zleceń, oraz informacje dotyczące konta użytkownika.",
      detailed_text: "Ta sekcja pokazuje wszystkie powiadomienia, które otrzymałeś.",
    },
    { 
      element: 'bookings-link', 
      mobileElement: 'expanded-bookings-link', 
      offset: 50, 
      text: "W widocznym panelu zleceń, użytkownik posiada możliwiość monitorowania i zarządzania wszystkimi zleceniami.",
      detailed_text: "W tej sekcji znajdują się wszystkie Twoje zlecenia, które otrzymałeś lub zaakceptowałeś.",
    },
    { 
      element: 'calendar-link', 
      mobileElement: 'expanded-calendar-link', 
      offset: 50, 
      text: "Po otrzymaniu lub dodaniu zlecenia, zostaną one dodane do Twojego kalendarza według dat ustalonych w zleceniu.",
      detailed_text: "Kalendarz pozwala na zarządzanie Twoimi zleceniami oraz innymi ważnymi datami.",
    },
    { 
      element: 'map-link', 
      mobileElement: 'mobile-calendar-link', 
      offset: 50, 
      text: "Jeśli zlecenie posiada ustaloną lokalizację, zostaną one zaznaczone w sekcji mapy.",
      detailed_text: "Mapa pokazuje lokalizacje wszystkich dostępnych zleceń w Twojej okolicy.",
    },
    { 
      element: 'profile-link', 
      mobileElement: 'mobile-profile-link', 
      offset: 50, 
      text: "Widoczna sekcja, przeniesie Cię na twoj aktualny profil. Umożliwi to sprawną edycję twoich danych.",
      detailed_text: "Profil użytkownika zawiera wszystkie Twoje dane osobowe oraz ustawienia konta.",
    },
    { 
      element: 'tutorial-button', 
      mobileElement: 'expand-menu-button', 
      offset: 50, 
      text: "Widoczna ikona, pozwala na chowanie/otwieranie panelu skrótów.",
      detailed_text: "Poradnik prowadzi Cię krok po kroku przez najważniejsze funkcje aplikacji.",
    }
  ];
  
  let currentStep = 0;

  const isBelowNotificationLink = (stepElement) => {
    const elementsBelowNotification = [
      'notifications-link',
      'bookings-link',
      'calendar-link',
      'map-link',
      'profile-link',
      'destroy_user_session_path',
      'tutorial-button'
    ];

    return elementsBelowNotification.includes(stepElement);
  };

  function showIntro() {
    introBox.classList.remove('hidden');
    stepBox.classList.add('hidden');
    overlay.classList.remove('hidden');

    if (window.innerWidth < 1024) {
      introBox.style.top = '1%';
    } else {
      introBox.style.top = '50%';
    }
  }

  function showStep(stepIndex) {
    if (stepIndex >= steps.length) {
      overlay.classList.add('hidden');
      return;
    }

    const step = steps[stepIndex];
    const element = window.innerWidth >= 1024 ? document.getElementById(step.element) : document.getElementById(step.mobileElement);

    if (element) {
      const rect = element.getBoundingClientRect();

      tutorialText.textContent = step.text;

      stepBox.classList.remove('hidden');
      overlay.classList.remove('hidden');

      // Adjust position based on step
      if (window.innerWidth < 1024) {
        if (isBelowNotificationLink(step.element)) {
          stepBox.style.top = '10%';  // Set to 80% for steps below or at notifications
        } else {
          stepBox.style.top = '50%';  // Default to 50%
        }
      } else {
        stepBox.style.top = '50%';  // Default to 50% for larger screens
      }

      overlay.style.clipPath = `polygon(0% 0%, 0% 100%, ${rect.left + window.scrollX}px 100%, ${rect.left + window.scrollX}px ${rect.top + window.scrollY}px, ${rect.right + window.scrollX}px ${rect.top + window.scrollY}px, ${rect.right + window.scrollX}px ${rect.bottom + window.scrollY}px, ${rect.left + window.scrollX}px ${rect.bottom + window.scrollY}px, ${rect.left + window.scrollX}px 100%, 100% 100%, 100% 0%)`;
    }
  }

  function attachTutorialEvent(button) {
    if (button) {
      button.addEventListener('click', function () {
        currentStep = 0;
        showIntro();
      });
    }
  }

  attachTutorialEvent(tutorialButton);
  attachTutorialEvent(expandMenuButton);

  if (startButton) {
    startButton.addEventListener('click', function () {
      introBox.classList.add('hidden');
      showStep(currentStep);
    });
  }

  if (nextButton) {
    nextButton.addEventListener('click', function () {
      currentStep += 1;
      showStep(currentStep);
    });
  }

  const detailedButtons = document.querySelectorAll('#detailed-description');

  detailedButtons.forEach((button, index) => {
    button.addEventListener('click', function () {
      const step = steps[currentStep];
      const detailedModal = document.createElement('div');
      detailedModal.id = `detailed-modal-${index}`;
      detailedModal.className = 'fixed bg-white p-4 rounded shadow-lg text-center';

      if (window.innerWidth >= 1024 || isBelowNotificationLink(step.element)) {
        detailedModal.style.top = '80%'; // Set to 80% for steps below or at notifications
      } else {
        detailedModal.style.top = '50%'; // Default to 50%
      }
      detailedModal.style.left = '50%';
      detailedModal.style.transform = 'translate(-50%, -50%)';
      detailedModal.style.zIndex = '70';

      detailedModal.innerHTML = `
        <p class="mb-4">${step.detailed_text}</p>
        <button class="detailed-close px-4 py-2 bg-blue-500 text-white rounded">Zamknij</button>
      `;
      document.body.appendChild(detailedModal);

      detailedModal.querySelector('.detailed-close').addEventListener('click', function () {
        detailedModal.classList.add('hidden');
        stepBox.classList.remove('hidden');
        document.body.removeChild(detailedModal);
      });

      stepBox.classList.add('hidden');
      detailedModal.classList.remove('hidden');
    });
  });
});
