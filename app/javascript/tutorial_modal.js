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
      text: "W tym miejscu znajdziesz dashboard.", 
      detailed_text: "Dashboard jest centralnym miejscem, gdzie możesz zobaczyć najważniejsze informacje dotyczące Twojego konta.",
    },
    { 
      element: 'new-post-link', 
      mobileElement: 'expanded-new-post-link', 
      offset: 50, 
      text: "W tym miejscu dodasz ogłoszenie.",
      detailed_text: "Tutaj możesz dodać nowe ogłoszenie, które będzie widoczne dla wszystkich użytkowników.",
    },
    { 
      element: 'posts-link', 
      mobileElement: 'mobile-posts-link', 
      offset: 50, 
      text: "Tutaj znajdziesz ogłoszenia.",
      detailed_text: "W tej sekcji możesz przeglądać wszystkie dostępne ogłoszenia.",
    },
    { 
      element: 'user-posts-link', 
      mobileElement: 'expanded-user-posts-link', 
      offset: 50, 
      text: "Tutaj znajdziesz swoje ogłoszenia.",
      detailed_text: "W tej sekcji znajdują się wszystkie ogłoszenia, które sam opublikowałeś.",
    },
    { 
      element: 'conversations-link', 
      mobileElement: 'expanded-conversations-link', 
      offset: 50, 
      text: "Tutaj możesz przeglądać swoje wiadomości.",
      detailed_text: "Tutaj znajdziesz wszystkie wiadomości, które otrzymałeś od innych użytkowników.",
    },
    { 
      element: 'notifications-link', 
      mobileElement: 'expanded-notifications-link', 
      offset: 50, 
      text: "Tutaj znajdziesz swoje powiadomienia.",
      detailed_text: "Ta sekcja pokazuje wszystkie powiadomienia, które otrzymałeś.",
    },
    { 
      element: 'bookings-link', 
      mobileElement: 'expanded-bookings-link', 
      offset: 50, 
      text: "Tutaj możesz przeglądać swoje zlecenia.",
      detailed_text: "W tej sekcji znajdują się wszystkie Twoje zlecenia, które otrzymałeś lub zaakceptowałeś.",
    },
    { 
      element: 'calendar-link', 
      mobileElement: 'expanded-calendar-link', 
      offset: 50, 
      text: "Tutaj możesz zobaczyć swój kalendarz.",
      detailed_text: "Kalendarz pozwala na zarządzanie Twoimi zleceniami oraz innymi ważnymi datami.",
    },
    { 
      element: 'map-link', 
      mobileElement: 'mobile-calendar-link', 
      offset: 50, 
      text: "Tutaj znajdziesz mapę zleceń.",
      detailed_text: "Mapa pokazuje lokalizacje wszystkich dostępnych zleceń w Twojej okolicy.",
    },
    { 
      element: 'profile-link', 
      mobileElement: 'mobile-profile-link', 
      offset: 50, 
      text: "Tutaj możesz zobaczyć i edytować swój profil.",
      detailed_text: "Profil użytkownika zawiera wszystkie Twoje dane osobowe oraz ustawienia konta.",
    },
    { 
      element: 'tutorial-button', 
      mobileElement: 'expand-menu-button', 
      offset: 50, 
      text: "W tym miejscu możesz uruchomić poradnik.",
      detailed_text: "Poradnik prowadzi Cię krok po kroku przez najważniejsze funkcje aplikacji.",
    }
  ];
  
  let currentStep = 0;

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

      if (window.innerWidth < 1024) {
        stepBox.style.top = '1%';
      } else {
        stepBox.style.top = '50%';
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

  // Use the actual step index for detailed description
  const detailedButtons = document.querySelectorAll('#detailed-description');

  detailedButtons.forEach((button, index) => {
    button.addEventListener('click', function () {
      const step = steps[currentStep];
      const detailedModal = document.createElement('div');
      detailedModal.id = `detailed-modal-${index}`;
      detailedModal.className = 'fixed bg-white p-4 rounded shadow-lg text-center';

      if (window.innerWidth >= 1024) {
        detailedModal.style.top = '50%';
      } else {
        detailedModal.style.top = '80%';
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
