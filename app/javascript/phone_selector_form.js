document.addEventListener('turbo:load', () => {
    const countryCodeSelect = document.querySelector('select[data-action="change->country-code#updatePhoneNumber"]');
    const phoneNumberField = document.querySelector('input[data-target="country-code.phoneNumber"]');
  
    if (countryCodeSelect && phoneNumberField) {
      const defaultCountryCode = '+48';
      phoneNumberField.placeholder = defaultCountryCode;
      phoneNumberField.value = defaultCountryCode;
  
      countryCodeSelect.addEventListener('change', (event) => {
        const selectedCountryCode = event.target.value;
        phoneNumberField.placeholder = selectedCountryCode;
        const currentPhoneNumber = phoneNumberField.value;
  
        const phoneWithoutCode = currentPhoneNumber.replace(/^\+\d+\s*/, '');
  
        phoneNumberField.value = `${selectedCountryCode} ${phoneWithoutCode}`;
      });
    }
  });