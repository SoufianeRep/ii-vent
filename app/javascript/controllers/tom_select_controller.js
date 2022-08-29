import { Controller } from "@hotwired/stimulus"
import "tom-select"
window.TomSelect = require('tom-select');

// Connects to data-controller="tom-select"
export default class extends Controller {
  static values = { options: Object }

  connect() {
    new TomSelect(
      this.element ,
      this.optionsValue
    );
  }
}
