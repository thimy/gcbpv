import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["total", "donation"]
  static values = { total: Number }

  initialize() {
    this.updateTotal()
  }

  updateTotal() {
    this.totalTarget.innerHTML = `${(parseFloat(this.totalValue, 10) + (parseFloat(this.donationTarget.value, 10) || 0)).toFixed(2)} €`
  }
}
