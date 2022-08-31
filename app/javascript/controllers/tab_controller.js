import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"
export default class extends Controller {
  connect() {
    this.selectTab()
  }
  static targets = [ "tabTasks", "tabMembers", "tabMain", "tabMessages", "tab", "pagesMain", "pages", "pagesMembers", "pagesTasks", "pagesMessages" ]

  toggle(event) {
    this.tabTargets.forEach(t => t.classList.remove("active"));
    event.currentTarget.classList.add("active");
    this.pagesTargets.forEach(t => t.classList.add("d-none"));
    if (event.currentTarget == this.tabMainTarget)
      this.pagesMainTarget.classList.remove("d-none");
    else if (event.currentTarget == this.tabMembersTarget)
      this.pagesMembersTarget.classList.remove("d-none");
    else if (event.currentTarget == this.tabTasksTarget)
      this.pagesTasksTarget.classList.remove("d-none");
    else if (event.currentTarget == this.tabMessagesTarget)
      this.pagesMessagesTarget.classList.remove("d-none");
  }

  selectTab() {
    const params = new URLSearchParams(window.location.search);
    if (params.get("tab") === "members") {
      this.tabMembersTarget.click()
    } else if (params.get("tab") === "tasks") {
      this.tabTasksTarget.click()
    } else if (params.get("tab") === "messages") {
      this.tabMessagesTarget.click()
    }
  }
}
