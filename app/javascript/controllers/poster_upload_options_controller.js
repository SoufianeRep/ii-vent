import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="poster-upload-options"
export default class extends Controller {
  static targets = ['fileRadio', 'urlRadio', 'url', 'file']

  connect() {
    // console.log("Hello, from the poster-upload-options-controller!");
  }

  changeInput() {
    // console.log("Your data action works!");

    const url = this.urlTarget;
    const file = this.fileTarget;
    // const fileRadio = this.fileRadioTarget;
    // const urlRadio = this.urlRadioTarget;


    if (this.fileRadioTarget.checked == true) {
      console.log("File is checked!");
      // console.log(this.fileTarget);
      this.fileTarget.classList.remove('d-none')
      this.urlTarget.classList.add('d-none');
    }
    if (this.urlRadioTarget.checked == true) {
      console.log("URL is checked!");
      // console.log(this.urlTarget);
      this.urlTarget.classList.remove('d-none');
      this.fileTarget.classList.add('d-none');
    }

    // console.log(urlRadio.checked);
    // console.log(url);
    // console.log(file);
    // console.log(fileRadio.id);
    // console.log(urlRadio.id);
  }
}
