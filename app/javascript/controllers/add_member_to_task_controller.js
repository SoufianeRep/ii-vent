import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-member-to-task"
export default class extends Controller {
  static targets = ['addMemberForm', 'tickMember']

  connect() {
    console.log('add member to task controller connected');
  }

  submit() {

  }

  addMember(e) {
    e.preventDefault();
    // console.log(this.formInputTarget);
    const formData = new FormData(e.currentTarget);
    for (let [key, value] of formData.entries()) {
      console.log(key, ": ", value);
    }
    // console.log(formData.entries());
    // console.log(formData);
    fetch(this.addMemberFormTarget.action, {
      method: 'POST',
      headers: {
        "Accept": "text/html",
    },
      body: formData,
    }).then((response) => {
      console.log(response);
      if (response.ok === true) {
        console.log('submitted');
      }
    }).then(() => {
        // this.tickMemberTarget.classList.toggle('d-none');
      });
  }
}
