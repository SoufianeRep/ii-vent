import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="update-tasks"
export default class extends Controller {
  static targets = ['tasksPage', 'doneform'];

  connect() {
  }

  done(e) {
    e.preventDefault();
    console.log(e.currentTarget);
    fetch(e.currentTarget.action, {
      method: 'PATCH',
      headers: {"Accept": "text/plain"},
      body: new FormData(e.currentTarget)
    }).then(response => response.text())
      .then((data) => {
        this.tasksPageTarget.innerHTML = data;
      });
  }
}
