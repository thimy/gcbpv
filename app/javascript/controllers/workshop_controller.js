import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu-button"
export default class extends Controller {
  static targets = ["workshop", "slot"]

  updateSlots() {
    const workshopId = this.workshopTarget.value;
    this.fetchAndUpdate(`/update_workshop_slots?workshop_id=${workshopId}`, this.slotTarget)
  }

  fetchAndUpdate(url, target) {
    fetch(url)
      .then(response => response.json())
      .then(data => {
        this.#fillSelect(data, target)
      })
      .catch(error => console.error("Error:", error))
  }

  getMetaContent(name) {
    return document.querySelector(`meta[name="${name}"]`).getAttribute("content")
  }

  removeRow() {
    this.element.remove()
  }

  #fillSelect(data, target) {
    target.options.length = 0
    if (data.length > 1) {
      target.append(new Option("", ""))
    }
    data.forEach(element => {
      const option = new Option(`${element.city.name} – ${element.slot_time || "Horaire à définir"}`, element.id)
      target.append(option)
    })
  }
}
