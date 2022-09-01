import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tasks"
export default class extends Controller {
  static targets = ['task', 'badge', 'members', 'subtaskform', 'subtasks', 'memberImage', 'addMemberForm', 'tickMember', 'formInput'];

  connect() {
  }

  toggleDisplay() {
    this.taskTarget.classList.toggle('d-none');
    this.membersTarget.classList.toggle('d-none');
    this.badgeTargets.forEach(badge => badge.classList.toggle('d-none'));
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
            `<div class="ms-4 d-flex gap-2 align-items-center">
              <i class="fa-solid fa-circle subtask-icon"></i>
              <p class="text-secondary m-0">${data.inserted_item.locals.task.name}</p>
            </div>`
          );
        }
        this.subtaskformTarget.outerHTML = data.form;
      });
  }
}
