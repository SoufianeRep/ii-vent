import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard-mark-task-as-done"
export default class extends Controller {
  static targets = ["status"]

  connect() {
    console.log("Hello from the 'dashboard-mark-task-as-done' controller!");
  }

  markAsDone() {
    console.log("Changed!");

    console.log(this.statusTarget);


  }
}
