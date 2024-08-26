document.addEventListener("turbo:load", function() {
  const categorySearchInput = document.getElementById('categorySearchInput');
  const subcategorySearchInput = document.getElementById('subcategorySearchInput');
  const categoryDropdown = document.getElementById('categoryDropdown');
  const subcategoryDropdown = document.getElementById('subcategoryDropdown');
  const categorySelectHidden = document.getElementById('categorySelectHidden');
  const subcategorySelectHidden = document.getElementById('subcategorySelectHidden');

  function hideDropdowns() {
    if (categoryDropdown) categoryDropdown.style.display = 'none';
    if (subcategoryDropdown) subcategoryDropdown.style.display = 'none';
  }

  hideDropdowns();

  function filterDropdown(searchInput, dropdown) {
    if (!searchInput || !dropdown) return;

    searchInput.addEventListener('input', function() {
      const searchValue = searchInput.value.toLowerCase();
      Array.from(dropdown.querySelectorAll('li')).forEach(item => {
        const text = item.textContent.toLowerCase();
        item.style.display = text.includes(searchValue) ? 'block' : 'none';
      });
    });

    searchInput.addEventListener('focus', function() {
      dropdown.style.display = 'block';
    });

    document.addEventListener('click', function(event) {
      if (!searchInput.contains(event.target) && !dropdown.contains(event.target)) {
        dropdown.style.display = 'none';
      }
    });
  }

  function selectDropdownItem(dropdown, hiddenField, searchInput) {
    if (!dropdown || !hiddenField || !searchInput) return;

    dropdown.addEventListener('click', function(e) {
      if (e.target && e.target.nodeName === "LI") {
        hiddenField.value = e.target.getAttribute('data-value');
        searchInput.value = e.target.textContent;
        dropdown.style.display = 'none';

        if (hiddenField === categorySelectHidden) {
          loadSubcategories(e.target.getAttribute('data-value'));
        }
      }
    });
  }

  function loadSubcategories(categoryId) {
    if (subcategoryDropdown) {
      fetch(`/subcategories?category_id=${categoryId}`)
        .then(response => response.json())
        .then(data => {
          subcategoryDropdown.innerHTML = '';
          data.forEach(subcategory => {
            const li = document.createElement('li');
            li.textContent = subcategory.name;
            li.setAttribute('data-value', subcategory.id);
            li.classList.add('p-2', 'hover:bg-gray-100', 'cursor-pointer');
            subcategoryDropdown.appendChild(li);
          });

          filterDropdown(subcategorySearchInput, subcategoryDropdown);
          selectDropdownItem(subcategoryDropdown, subcategorySelectHidden, subcategorySearchInput);
        })
        .catch(error => console.error('Fetch error:', error));
    }
  }

  if (categorySearchInput && categoryDropdown) filterDropdown(categorySearchInput, categoryDropdown);
  if (subcategorySearchInput && subcategoryDropdown) filterDropdown(subcategorySearchInput, subcategoryDropdown);

  if (categoryDropdown && categorySelectHidden && categorySearchInput) selectDropdownItem(categoryDropdown, categorySelectHidden, categorySearchInput);
  if (subcategoryDropdown && subcategorySelectHidden && subcategorySearchInput) selectDropdownItem(subcategoryDropdown, subcategorySelectHidden, subcategorySearchInput);

  if (categorySelectHidden && categorySelectHidden.value) {
    loadSubcategories(categorySelectHidden.value);
  }

  document.addEventListener('DOMContentLoaded', hideDropdowns);
});
