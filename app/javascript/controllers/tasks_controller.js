import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tasks"
export default class extends Controller {
  static targets = ['task', 'badge', 'members'];

  connect() {
    console.log('hello from tasks controller');
  }

  toggleDisplay(e) {
    this.taskTarget.classList.toggle('d-none');
    this.badgeTarget.classList.toggle('d-none');
    this.membersTarget.classList.toggle('d-none');
  }
}
