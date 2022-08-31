import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="poster-upload-options"
export default class extends Controller {
  static targets = ['fileRadio', 'urlRadio', 'url', 'file']

  connect() {
  }

  changeInput() {
    if (this.fileRadioTarget.checked == true) {
      console.log("File is checked!");
      this.fileTarget.classList.remove('d-none')
      this.urlTarget.classList.add('d-none');
    }
    if (this.urlRadioTarget.checked == true) {
      console.log("URL is checked!");
      this.urlTarget.classList.remove('d-none');
      this.fileTarget.classList.add('d-none');
    }
  }
}
