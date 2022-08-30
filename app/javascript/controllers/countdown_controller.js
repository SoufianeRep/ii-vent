import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="countdown"
export default class extends Controller {
  static targets = ['counter', 'date'];

  connect() {
    // this.counterTarget.innerHTML = 'something';
    // console.log(this.counterTarget.innerHTML);
    // this.#countdownTimer(this.counterTarget);
    // setInterval(this.#countdownTimer(this.counterTarget), 1000);
  }

  #countdownTimer(counter) {
    const difference = +new Date("2022-12-01") - +new Date();
    let remaining = "Past the date";

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
    // console.log(this.counterTarget, '<================ COUNTER')
    counter.innerHTML = `<p>${remaining}</p>`;
    console.log(remaining, '<============ Remainung');
  }
}
