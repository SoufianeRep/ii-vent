import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="event-messages-subscription"
export default class extends Controller {
  static targets = [ "messages", "form", "panel", "messagesTab", "messagesPage", "messagesGeneral", "messagesArtists", "messagesSecurity", "messagesStaff", "messagesManagers" ]
  static values = { eventId: Number, currentUserId: Number } // string?

  connect() {
    console.log(`Connecting to the channel: ${this.eventIdValue}`)
    createConsumer().subscriptions.create(
      { channel: "EventMessagesChannel", id: this.eventIdValue },
      {
        received: (data) => {
          this.#insertMessageAndScrollDown(data)
        },
      }
    )
  }

  // Private methods
  #insertMessageAndScrollDown(data) {
    const currentUserIsSender = this.currentUserIdValue === data.sender_id
    const messageElement = this.#buildMessageElement(currentUserIsSender, data.message)
    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement)
    this.panelTarget.scrollTo(0, this.panelTarget.scrollHeight)
  }

  #buildMessageElement(currentUserIsSender, message) {
    return `
      <div class="message-row d-flex ${this.#justifyClass(currentUserIsSender)}">
        <div class="${this.#userStyleClass(currentUserIsSender)}">
          ${message}
        </div>
      </div>
    `
  }

  #justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content-start" : "justify-content-end"
  }

  #userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "sender-style" : "receiver-style"
  }

  resetForm(event) {
    this.formTarget.reset()
  }

  changeRoom(event) {
    console.log("hello")
    this.messagesTarget.innerHTML = ""
    this.messagesPageTarget.value = 1
    this.messagesGeneralTarget.classList.remove("active")
    this.messagesArtistsTarget.classList.remove("active")
    this.messagesSecurityTarget.classList.remove("active")
    this.messagesStaffTarget.classList.remove("active")
    this.messagesManagersTarget.classList.remove("active")
    event.currentTarget.classList.add("active")
    this.messagesTabTarget.value = event.currentTarget.dataset.room
    this.messagesTarget.innerHTML = ""
    this.messagesPageTarget.value = 1
    this.messagesTarget.insertAdjacentHTML("beforeend", `<div class="spinner-border text-primary" role="status">
    <span class="sr-only">Loading...</span>
  </div>`)
    this.fetchMessages()
  }
}
