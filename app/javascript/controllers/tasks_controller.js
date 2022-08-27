import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tasks"
export default class extends Controller {
  static targets = ['task', 'badge', 'members', 'subtaskform', 'subtasks'];

  connect() {
    console.log('hello from tasks controller');
  }

  toggleDisplay() {
    this.taskTarget.classList.toggle('d-none');
    this.badgeTarget.classList.toggle('d-none');
    this.membersTarget.classList.toggle('d-none');
  }

  send(e) {
    e.preventDefault();
    fetch(this.subtaskformTarget.action,{
      method: "POST",
      headers: {"Accept": "application/json"},
      body: new FormData(this.subtaskformTarget)
    }).then(response => response.json())
      .then((data) => {
        console.log(data);
        if (data.inserted_item) {
          this.subtasksTarget.insertAdjacentHTML('beforeend',
            `<p class="ms-5">↪ ${data.inserted_item.locals.task.name}</p>`
          );
        }
        this.subtaskformTarget.outerHTML = data.form;
      });
  }
}
