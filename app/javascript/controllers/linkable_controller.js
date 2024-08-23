import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  navigate(event) {
    const path = event.params.path
    window.location.href = path
  }
}
