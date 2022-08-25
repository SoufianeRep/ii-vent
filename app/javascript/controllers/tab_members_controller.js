import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab-members"
export default class extends Controller {
  connect() {
    this.selectTab()
  }
  static targets = [ "tabManager", "tabArtist", "tabSecurity", "tabStaff", "tab", "pagesManager", "pages", "pagesArtist", "pagesSecurity", "pagesStaff" ]

  toggle(event) {
    this.tabTargets.forEach((t) => {t.classList.remove("active")});
    event.currentTarget.classList.add("active");
    this.pagesTargets.forEach((t) => {t.classList.add("d-none")});
    if (event.currentTarget == this.tabManagerTarget)
      this.pagesManagerTarget.classList.remove("d-none");
    else if (event.currentTarget == this.tabArtistTarget)
      this.pagesArtistTarget.classList.remove("d-none");
    else if (event.currentTarget == this.tabSecurityTarget)
      this.pagesSecurityTarget.classList.remove("d-none");
    else if (event.currentTarget == this.tabStaffTarget)
    this.pagesStaffTarget.classList.remove("d-none");
  }

  selectTab() {
    const params = new URLSearchParams(window.location.search);
    if (params.get("sub_tab") === "artists") {
      this.tabArtistTarget.click()
    }
    if (params.get("sub_tab") === "staff") {
      this.tabStaffTarget.click()
    }
    if (params.get("sub_tab") === "security") {
      this.tabSecurityTarget.click()
    }
  }
}
