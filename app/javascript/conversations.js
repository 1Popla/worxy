document.addEventListener("turbo:load", function() {
    const searchInput = document.getElementById('conversation-user-search');
    const usersList = document.getElementById('conversation-users-list');
    let currentPage = 1;
    let loading = false;
    let hasMoreUsers = true;
  
    function resetSearchState() {
      if (usersList) {
        usersList.classList.add('hidden');
        searchInput.value = "";
        usersList.innerHTML = "";
        currentPage = 1;
        hasMoreUsers = true;
      }
    }
  
    if (searchInput && !searchInput.dataset.listenerAttached) {
      searchInput.dataset.listenerAttached = true;
  
      searchInput.addEventListener('keyup', function() {
        const query = searchInput.value.trim();
  
        if (query) {
          currentPage = 1;
          hasMoreUsers = true;
          if (usersList) {
            usersList.classList.remove('hidden');
          }
          loadUsers(true);
        } else {
          resetSearchState();
        }
      });
  
      document.addEventListener('click', function(event) {
        if (!searchInput.contains(event.target) && !usersList.contains(event.target)) {
          resetSearchState();
        }
      });
    }
  
    function loadUsers(reset = false) {
      if (loading || !hasMoreUsers || !usersList) return;
      loading = true;
  
      const query = searchInput ? searchInput.value : '';
  
      fetch(`/search_users?query=${query}&page=${currentPage}`, {
        headers: {
          'X-Requested-With': 'XMLHttpRequest'
        }
      })
      .then(response => response.text())
      .then(html => {
        if (usersList) {
          if (reset) {
            usersList.innerHTML = html;
          } else {
            usersList.insertAdjacentHTML('beforeend', html);
          }
  
          if (html.includes("Nie znaleziono użytkowników") || html.trim() === "") {
            hasMoreUsers = false;
          } else {
            currentPage += 1;
          }
        }
        loading = false;
      })
      .catch(() => {
        loading = false;
      });
    }
  
    if (usersList && !usersList.dataset.listenerAttached) {
      usersList.dataset.listenerAttached = true;
  
      usersList.addEventListener('scroll', function() {
        if (usersList.scrollTop + usersList.clientHeight >= usersList.scrollHeight) {
          loadUsers();
        }
      });
  
      document.addEventListener('turbo:before-cache', function() {
        resetSearchState();
      });
    }
  });
  