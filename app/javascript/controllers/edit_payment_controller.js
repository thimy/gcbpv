import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { id: Number }

  connect() {
    this.clickSave = false
  }

  fetchAndUpdate(url, method = "GET") {
    fetch(url, {
      method: method,
      headers: {
        Accept: "text/vnd.turbo-stream.html, text/html, application/xhtml+xml",
        "X-Requested-With": "XMLHttpRequest",
        "X-CSRF-Token": this.getMetaContent("csrf-token"),
        "Cache-Control": "no-cache"
      }
    }).then(response => response.ok ? response.text() : Promise.reject("Response not OK"))
      .then(html => Turbo.renderStreamMessage(html))
      .catch(error => console.error("Error:", error))
  }

  editEntry(event) {
    event.preventDefault()
    this.fetchAndUpdate(event.params.url)
  }

  saveEntry(event) {
    if (!this.clickSave) {
      event.preventDefault()
      const form = event.currentTarget.closest("form")
      form.action = form.action.replace(/\/[^\/]*$/, `/${this.idValue}`)
      this.clickSave = true
      event.currentTarget.click()
    }
  }

  createEntry(event) {
    event.preventDefault()
    const form = event.currentTarget.closest("form")
    const subscriptionGroupId = form.dataset.subscriptionGroupId
    const itemType = form.dataset.itemType
    const formData = new FormData(form)
    formData.delete("_method")
    formData.append(`${itemType}[subscription_group_id]`, subscriptionGroupId)
    fetch(event.params.url, {
      method: "POST",
      headers: {
        Accept: "text/vnd.turbo-stream.html, text/html, application/xhtml+xml",
        "X-Requested-With": "XMLHttpRequest",
        "X-CSRF-Token": this.getMetaContent("csrf-token"),
        "Cache-Control": "no-cache"
      },
      body: formData
    }).then(response => response.ok ? response.text() : Promise.reject("Response not OK"))
      .then(html => Turbo.renderStreamMessage(html))
      .catch(error => console.error("Error:", error))
  }

  cancelNew(event) {
    event.currentTarget.closest("tr").remove()
  }

  getMetaContent(name) {
    return document.querySelector(`meta[name="${name}"]`).getAttribute("content")
  }
}
