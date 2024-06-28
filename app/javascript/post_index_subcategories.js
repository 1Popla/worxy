document.addEventListener("turbo:load", function() {
  const categorySelect = document.getElementById('categorySelect');
  const subcategorySelect = document.getElementById('subcategorySelect');
  const categorySearch = document.getElementById('categorySearch');
  const subcategorySearch = document.getElementById('subcategorySearch');

  // Filter dropdown options based on search input
  function filterDropdown(searchInput, selectElement) {
    searchInput.addEventListener('input', function() {
      const searchValue = searchInput.value.toLowerCase();
      Array.from(selectElement.options).forEach(option => {
        const text = option.textContent.toLowerCase();
        option.style.display = text.includes(searchValue) ? 'block' : 'none';
      });
    });
  }

  if (categorySelect) {
    filterDropdown(categorySearch, categorySelect);

    categorySelect.addEventListener('change', function() {
      const categoryId = this.value;

      if (subcategorySelect) {
        fetch(`/subcategories?category_id=${categoryId}`)
          .then(response => response.json())
          .then(data => {
            subcategorySelect.innerHTML = '<option value="">Podkategorie</option>';
            data.forEach(subcategory => {
              const option = document.createElement('option');
              option.value = subcategory.id;
              option.textContent = subcategory.name;
              subcategorySelect.appendChild(option);
            });

            // Restore selected subcategory if it exists
            const selectedSubcategoryId = "<%= params[:subcategory] %>";
            if (selectedSubcategoryId) {
              subcategorySelect.value = selectedSubcategoryId;
            }

            filterDropdown(subcategorySearch, subcategorySelect);
          });
      }
    });

    // Re-populate the subcategories if a category is selected and page reloads
    const selectedCategoryId = categorySelect.value;
    if (selectedCategoryId) {
      fetch(`/subcategories?category_id=${selectedCategoryId}`)
        .then(response => response.json())
        .then(data => {
          subcategorySelect.innerHTML = '<option value="">Podkategorie</option>';
          data.forEach(subcategory => {
            const option = document.createElement('option');
            option.value = subcategory.id;
            option.textContent = subcategory.name;
            option.selected = subcategory.id == "<%= params[:subcategory] %>";
            subcategorySelect.appendChild(option);
          });

          filterDropdown(subcategorySearch, subcategorySelect);
        });
    }
  }
});
