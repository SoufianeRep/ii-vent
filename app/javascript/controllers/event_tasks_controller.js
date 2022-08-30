import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="event-tasks"
export default class extends Controller {
  static targets = [
    "taskTab",
    "allTab", "all",
    "musicTab", "music",
    "securityTab", "security",
    "organizationTab", "organization",
    "cateringTab", "catering",
    "promotionTab", "promotion"
  ]

  connect() {
    this.#taskSelectTab()
  }

  toggleDisplay(e) {
    this.taskTabTargets.forEach(tab => tab.classList.add('d-none'))
    if (e.currentTarget == this.allTarget) {
      this.allTabTarget.classList.remove("d-none")
    } else if (e.currentTarget == this.musicTarget) {
      this.musicTabTarget.classList.remove("d-none")
    } else if (e.currentTarget == this.securityTarget) {
      this.securityTabTarget.classList.remove("d-none")
    } else if (e.currentTarget == this.organizationTarget) {
      this.organizationTabTarget.classList.remove("d-none")
    } else if (e.currentTarget == this.cateringTarget) {
      this.cateringTabTarget.classList.remove("d-none")
    } else if (e.currentTarget == this.promotionTarget) {
      this.promotionTabTarget.classList.remove("d-none")
    }
  }

  #taskSelectTab() {
    const params = new URLSearchParams(window.location.search);
      if (params.get("subtab") === "music") {
        this.musicTarget.click();
      } else if (params.get("subtab") === "security") {
        this.securityTarget.click();
      } else if (params.get("subtab") === "organization") {
        this.organizationTarget.click();
      } else if (params.get("subtab") === "catering") {
        this.cateringTarget.click();
      } else if (params.get("subtab") === "security") {
        this.securityTarget.click();
      } else if (params.get("subtab") === "promotion") {
        this.promotionTarget.click();
      }
  }
}
