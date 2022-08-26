import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="poster-upload-options"
export default class extends Controller {
  connect() {
    console.log("Hello, from the poster-upload-options-controller!");
  }
}
