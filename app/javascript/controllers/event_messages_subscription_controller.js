import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="event-messages-subscription"
export default class extends Controller {
  static targets = [ "messages", "form", "panel" ]
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
    // Logic to know if the sender is the current_user
    const currentUserIsSender = this.currentUserIdValue === data.sender_id

    // Creating the whole message from the `data.message` String
    const messageElement = this.#buildMessageElement(currentUserIsSender, data.message)

    // Inserting the `message` in the DOM
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

  // we need a reset form private method to clear the form after submit
  resetForm(event) {
    console.log("hello")
    this.formTarget.reset()
  }
}
