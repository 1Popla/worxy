document.addEventListener("turbo:load", function() {
  const avatarContainer = document.getElementById('user-profile-avatar-container');
  const avatarInput = document.getElementById('user-profile-avatar-input');

  if (avatarContainer && avatarInput) {
    avatarContainer.addEventListener('click', function() {
      avatarInput.click();
    });

    avatarInput.addEventListener('change', function() {
      document.getElementById('user-profile-avatar-form').submit();
    });
  }
});
