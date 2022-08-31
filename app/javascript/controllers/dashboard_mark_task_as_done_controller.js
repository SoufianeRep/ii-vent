import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard-mark-task-as-done"
export default class extends Controller {
  static targets = ["forms", "status"]

  connect() {
    this.formsTargets.forEach(form => {
      form.addEventListener("change", function (event) {
        event.currentTarget.submit()
      })
    })
  }
}
