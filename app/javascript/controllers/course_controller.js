import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu-button"
export default class extends Controller {
  static targets = ["instrument", "teacher", "slot"]

  updateTeachers() {
    const instrumentId = this.instrumentTarget.value;
    this.fetchAndUpdate(`/update_teachers?instrument_id=${instrumentId}`, this.teacherTarget)
    console.log(teachers)
  }

  updateSlots() {
    const teacherId = this.teacherTarget.value;
    this.fetchAndUpdate(`/update_slots?teacher_id=${teacherId}`, this.slotTarget)
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
    if (target == this.teacherTarget) {
      data.forEach(element => {
        const option = new Option(`${element.first_name} ${element.last_name}`, element.id)
        target.append(option)
      })
      this.slotTarget.options.length = 0
      if (data.length == 1) {
        this.updateSlots()
      }
    } else {
      data.forEach(element => {
        const option = new Option(`${element.city.name} – ${element.slot_time || "Horaire à définir"}`, element.id)
        target.append(option)
      })
    }
  }
}
