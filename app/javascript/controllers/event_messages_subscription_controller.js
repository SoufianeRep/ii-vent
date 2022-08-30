import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="event-messages-subscription"
export default class extends Controller {
  static targets = [ "messages" ]
  static values = { eventId: Number } // string?

  connect() {
    console.log(`Connecting to the channel: ${this.eventIdValue}`)
    createConsumer().subscriptions.create(
      { channel: "EventMessagesChannel", id: this.eventIdValue },
      {
        received: (data) => {
          this.#insertMessage(data)
        },
      }
    )
  }

  // Private methods
  #insertMessage(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }
}
