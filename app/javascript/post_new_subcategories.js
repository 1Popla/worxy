document.addEventListener("turbo:load", function() {
  const categorySelectNew = document.querySelector('#post_category_id');
  const subcategorySelectNew = document.querySelector('#post_subcategory_id');
  
  if (categorySelectNew) {
    categorySelectNew.addEventListener('change', function() {
      const categoryId = this.value;
      
      if (subcategorySelectNew) {
        fetch(`/subcategories?category_id=${categoryId}`)
          .then(response => response.json())
          .then(data => {
            subcategorySelectNew.innerHTML = '<option value="">Wybierz podkategorię</option>';
            data.forEach(subcategory => {
              const option = document.createElement('option');
              option.value = subcategory.id;
              option.textContent = subcategory.name;
              subcategorySelectNew.appendChild(option);
            });
          });
      }
    });
  }
});
