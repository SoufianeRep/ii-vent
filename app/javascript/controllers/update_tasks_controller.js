import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="update-tasks"
export default class extends Controller {
  static targets = ['tasksPage', 'doneform'];

  connect() {
    console.log('update tasks controller HELLO');
    console.log(this.tasksPageTarget, '<== tasks page');
    console.log(this.doneformTarget, '<== tasks page');
  }

  done(e) {
    e.preventDefault();
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
