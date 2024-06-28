import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["description", "generatingMessage"];

  connect() {
    this.generateDescriptionButton = this.element.querySelector("#generate-description");
    if (this.generateDescriptionButton) {
      this.generateDescriptionButton.addEventListener("click", () => this.generateDescription());
    }
  }

  generateDescription() {
    this.generatingMessageTarget.classList.remove("hidden");

    fetch('/posts/generate_description', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({ user_id: this.data.get("userId") })
    })
      .then(response => response.json())
      .then(data => {
        this.descriptionTarget.value = data.description;
        this.generatingMessageTarget.classList.add("hidden");
      })
      .catch(error => {
        console.error('Error generating description:', error);
        this.generatingMessageTarget.textContent = 'Błąd podczas generowania opisu. Proszę spróbować ponownie.';
      });
  }
}
