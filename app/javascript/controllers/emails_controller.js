import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu-button"
export default class extends Controller {
  static values = { list: String }
  copyList() {
    navigator.clipboard.writeText(this.listValue)
    this.element.innerHTML = "Liste copiée !"
    this.element.setAttribute("disabled", true)

    setTimeout(() => {
      this.element.innerHTML = "Copier la liste des emails"
      this.element.removeAttribute("disabled")
    }, 2000)
  }
}
