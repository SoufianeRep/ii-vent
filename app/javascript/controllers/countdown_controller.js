import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="countdown"
export default class extends Controller {
  static targets = ['counter', 'date'];

  connect() {
    // this.#countdownTimer();
    // setInterval(this.#countdownTimer, 1000);
  }
  #countdownTimer() {
    const difference = +new Date(this.dateTarget.innerHTML) - +new Date();
    let remaining = "Time's up!";

    if (difference > 0) {
      const parts = {
        days: Math.floor(difference / (1000 * 60 * 60 * 24)),
        hours: Math.floor((difference / (1000 * 60 * 60)) % 24),
        minutes: Math.floor((difference / 1000 / 60) % 60),
        seconds: Math.floor((difference / 1000) % 60),
      };

      remaining = Object.keys(parts).map(part => {
        if (!parts[part]) return;
        return `${parts[part]} ${part}`;
      }).join(" ");
    }
    console.log(remaining, typeof remaining);
    // this.counterTarget.innerHTML = `<p>${remaining}</p>`;
  }
}
