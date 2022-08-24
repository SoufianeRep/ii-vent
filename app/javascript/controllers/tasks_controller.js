import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tasks"
export default class extends Controller {
  static targets = ['task'];

  connect() {
    console.log('hello from tasks controller');
  }

  toggleDisplay(e) {
    this.taskTarget.classList.toggle('d-none');
  }
}
