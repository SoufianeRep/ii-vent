import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-member-to-task"
export default class extends Controller {
  static targets = ['addMemberForm', 'tickMember']

  connect() {
  }

  submit() {

  }

  addMember(e) {
    e.preventDefault();
    const formData = new FormData(e.currentTarget);

    this.currentTarget = e.currentTarget;

    fetch(this.addMemberFormTarget.action, {
      method: 'POST',
      headers: {
        "Accept": "text/html",
      },
      body: formData,
    }).then((response) => {
      if (response.ok) {
        this.currentTarget.classList.add('opacity-25', 'pe-none');
      }
    });
  }


}
