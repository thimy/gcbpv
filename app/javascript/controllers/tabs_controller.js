import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu-button"
export default class extends Controller {
  static targets = ["tab", "panel"]

  connect() {
    this.panelTargets.forEach((panel, index) => {
      if (index > 0) {
        panel.setAttribute("hidden", true)
      }
    })
    this.currentTab = this.tabTargets[0]
    this.currentPanel = this.panelTargets[0]
  }

  click(event) {
    this.currentTab.setAttribute("data-button-type", "outline")
    this.currentPanel.setAttribute("hidden", true)
    this.currentTab = event.currentTarget
    this.currentTab.removeAttribute("data-button-type")
    this.currentPanel = document.getElementById(this.currentTab.dataset.tabsPanelValue)
    this.currentPanel.removeAttribute("hidden")
  }
}
