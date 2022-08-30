import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard-mark-task-as-done"
export default class extends Controller {
  static targets = ["input", "status"]

  connect() {
    // console.log("Hello from the 'dashboard-mark-task-as-done' controller!");
    // console.log(this.inputTarget);
    // console.log(this.statusTarget);
  }

  markAsDone(event) {
    event.preventDefault()
    console.log(this.inputTarget.action);


    // url = this.inputTarget.action;
    // options = {
    //   method: 'PATCH',
    //   header: { "Accept": 'text/html' },
    //   body: new FormData(this.formTarget)
    // }

    // fetch(url, options)
    //   .then(response => response.json())
    //   .then((data) => {
    //     console.log(data);
    //   })
  }
}
