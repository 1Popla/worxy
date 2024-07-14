document.addEventListener('turbo:load', function() {
  const tutorialButton = document.getElementById('tutorial-button');
  const mobileTutorialButton = document.getElementById('mobile-tutorial-button');
  const overlay = document.getElementById('tutorial-overlay');
  const introBox = document.getElementById('tutorial-intro');
  const stepBox = document.getElementById('tutorial-step');
  const arrow = document.getElementById('tutorial-arrow');
  const startButton = document.getElementById('tutorial-start');
  const nextButton = document.getElementById('tutorial-next');
  const tutorialText = document.getElementById('tutorial-text');

  const steps = [
    { element: 'dashboard-link', mobileElement: 'mobile-dashboard-link', offset: 50, text: "W tym miejscu znajdziesz dashboard.", hideArrow: true },
    { element: 'new-post-link', mobileElement: 'mobile-new-post-link', offset: 50, text: "W tym miejscu dodasz ogłoszenie." },
    { element: 'posts-link', mobileElement: 'mobile-posts-link', offset: 50, text: "Tutaj znajdziesz ogłoszenia." },
    { element: 'user-posts-link', mobileElement: 'mobile-user-posts-link', offset: 50, text: "Tutaj znajdziesz swoje ogłoszenia." },
    { element: 'conversations-link', mobileElement: 'mobile-conversations-link', offset: 50, text: "Tutaj możesz przeglądać swoje wiadomości." },
    { element: 'notifications-link', mobileElement: 'mobile-notifications-link', offset: 50, text: "Tutaj znajdziesz swoje powiadomienia." },
    { element: 'bookings-link', mobileElement: 'mobile-bookings-link', offset: 50, text: "Tutaj możesz przeglądać swoje zlecenia." },
    { element: 'calendar-link', mobileElement: 'mobile-calendar-link', offset: 50, text: "Tutaj możesz zobaczyć swój kalendarz." },
    { element: 'map-link', mobileElement: 'mobile-map-link', offset: 50, text: "Tutaj znajdziesz mapę zleceń." },
    { element: 'profile-link', mobileElement: 'mobile-profile-link', offset: 50, text: "Tutaj możesz zobaczyć i edytować swój profil." },
    { element: 'tutorial-button', mobileElement: 'mobile-tutorial-button', offset: 50, text: "W tym miejscu możesz uruchomić poradnik." }
  ];

  let currentStep = 0;

  function showIntro() {
    introBox.classList.remove('hidden');
    stepBox.classList.add('hidden');
    arrow.classList.add('hidden');
    overlay.classList.remove('hidden');

    if (window.innerWidth < 1024) {
      introBox.style.top = '80%';
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
      const stepBoxRect = stepBox.getBoundingClientRect();

      tutorialText.textContent = step.text;

      if (step.hideArrow) {
        arrow.classList.add('hidden');
      } else {
        const arrowStartX = stepBoxRect.left + (stepBoxRect.width / 2);
        const arrowStartY = stepBoxRect.top + (stepBoxRect.height / 2);
        const arrowEndX = rect.left + (rect.width / 2);
        const arrowEndY = rect.top + (rect.height / 2);
        const arrowLength = Math.sqrt(Math.pow(arrowEndX - arrowStartX, 2) + Math.pow(arrowEndY - arrowStartY, 2));
        const arrowAngle = Math.atan2(arrowEndY - arrowStartY, arrowEndX - arrowStartX) * 180 / Math.PI;

        arrow.style.width = `${arrowLength}px`;
        arrow.style.height = '2px';
        arrow.style.transform = `rotate(${arrowAngle}deg)`;
        arrow.style.transformOrigin = `0 0`;
        arrow.style.top = `${arrowStartY}px`;
        arrow.style.left = `${arrowStartX}px`;

        arrow.classList.remove('hidden');
      }

      stepBox.classList.remove('hidden');
      overlay.classList.remove('hidden');

      if (window.innerWidth < 1024) {
        stepBox.style.top = '80%';
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
  attachTutorialEvent(mobileTutorialButton);

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
});
