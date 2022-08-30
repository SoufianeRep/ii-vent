import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard-mark-task-as-done"
export default class extends Controller {
  static targets = ["forms", "status"]

  connect() {
    // console.log("Hello from the 'dashboard-mark-task-as-done' controller!");
    console.log(this.formsTargets);
    // console.log(this.statusTarget);
    this.formsTargets.forEach(form => {
      console.log(form);
      form.addEventListener("change", function (event) {
        event.currentTarget.submit()
      })
    })
  }
}
