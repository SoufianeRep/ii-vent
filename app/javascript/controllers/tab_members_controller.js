import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab-members"
export default class extends Controller {
  connect() {
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

}
