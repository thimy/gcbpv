import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu-button"
export default class extends Controller {
  static targets = ["course", "slotParent"]

  updateTeachers() {
    const itemId = this.courseTarget.value;
    this.fetchAndUpdate(`${this.courseTarget.dataset.fillSelectUrlParam}${itemId}`, 
                        this.#fillTeachers.bind(this), 
                        this.element.querySelector(this.courseTarget.dataset.fillSelectTargetParam), 
                        this.element.querySelector(this.courseTarget.dataset.fillSelectResetParam))
  }

  updateSlots() {
    const itemId = this.slotParentTarget.value;
    this.fetchAndUpdate(`${this.slotParentTarget.dataset.fillSelectUrlParam}${itemId}`,
                        this.#fillSlots.bind(this),
                        this.element.querySelector(this.slotParentTarget.dataset.fillSelectTargetParam))
  }

  fetchAndUpdate(url, callback, target, reset = "") {
    fetch(url)
      .then(response => response.json())
      .then(data => {
        callback(data, target, reset)
        if (reset) {
          
        }
      })
      .catch(error => console.error("Error:", error))
  }

  removeRow() {
    this.element.remove()
  }

  #fillTeachers(data, target, reset) {
    target.options.length = 0
    data.forEach(element => {
      const option = new Option(`${[element.first_name, element.last_name].join(" ")}`, element.id)
      target.append(option)
    })
    if (data.length > 1) {
      target.prepend(new Option("---", ""))
      target.value = ""
    } else {
      this.dispatch("change", { target: target, prefix: false })
    }
    reset.options.length = 0
  }

  #fillSlots(data, target) {
    target.options.length = 0
    if (data.length > 1) {
      target.append(new Option("---", ""))
    }
    data.forEach(element => {
      const option = new Option(`${element.city.name} – ${this.#setSlotTime(element)}`, element.id)
      target.append(option)
    })
  }

  #setSlotTime(element) {
    if (element.day_of_week && element.slot_time) {
      return `${element.day_of_week} ${element.slot_time}`.toLowerCase()
    } else if (element.day_of_week) {
      return `${element.day_of_week} - horaires à définir`
    } else if (element.slot_time) {
      return `jour à définir - ${element.slot_time}`.toLowerCase()
    } else {
      return "jour et horaires à définir"
    }
  }
}
