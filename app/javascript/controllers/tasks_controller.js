import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tasks"
export default class extends Controller {
  static targets = ['task', 'badge', 'members', 'subtaskform', 'subtasks', 'doneform'];

  connect() {
  }

  toggleDisplay() {
    this.taskTarget.classList.toggle('d-none');
    this.badgeTarget.classList.toggle('d-none');
    this.membersTarget.classList.toggle('d-none');
  }

  addSubtask(e) {
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

  done() {
    // this.doneformTarget.submit();
    // console.log(new FormData(this.doneformTarget));
    fetch(this.doneformTarget.action, {
      method: 'PATCH',
      header: {"Accept": 'text/html'},
      body: new FormData(this.doneformTarget)
    }).then((response) => console.log(response));

  }


}
