import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu-button"
export default class extends Controller {
  static targets = ["list", "category", "entry", "address", "postcode", "city"]
  
  categoryMapping = {
    housenumber: "Numéro",
    street: "Rue",
    locality: "Lieu-dit",
    municipality: "Commune"
  }

  search(event) {
    const value = event.currentTarget.value
    if (value.length > 3) {
      fetch(`https://api-adresse.data.gouv.fr/search/?q=${value}`)
        .then(response => response.json())
        .then(data => {
          this.listTarget.removeAttribute("hidden")
          this.listTarget.innerHTML = ""
          let type = ""
          this.addresses = data.features.sort((a, b) => a.properties.type - b.properties.type);
          this.addresses.forEach(feature => {
            if (type != feature.properties.type) {
              const category = document.importNode(this.categoryTarget.content, true)
              type = feature.properties.type
              category.querySelector(".autocomplete-category").textContent = this.categoryMapping[type]
              this.listTarget.appendChild(category.cloneNode(true))
            }
            const entry = document.importNode(this.entryTarget.content, true)
            entry.firstElementChild.dataset.addressId = feature.properties.id
            entry.querySelector(".street").textContent = feature.properties.name
            entry.querySelector(".city").textContent = `${feature.properties.city} – ${feature.properties.postcode}`
            this.listTarget.appendChild(entry.cloneNode(true))
          })
        })
        .catch(error => console.error("Error: ", error))
    }
  }

  searchCity(event) {
    const value = event.currentTarget.value
    if (value.length > 3) {
      fetch(`https://api-adresse.data.gouv.fr/search/?q=${value}&type=municipality`)
        .then(response => response.json())
        .then(data => {
          this.listTarget.removeAttribute("hidden")
          this.listTarget.innerHTML = ""
          let type = ""
          this.addresses = data.features.sort((a, b) => a.properties.type - b.properties.type);
          this.addresses.forEach(feature => {
            const entry = document.importNode(this.entryTarget.content, true)
            entry.firstElementChild.dataset.addressId = feature.properties.id
            entry.querySelector(".street").textContent = feature.properties.name
            entry.querySelector(".city").textContent = `${feature.properties.city} – ${feature.properties.postcode}`
            this.listTarget.appendChild(entry.cloneNode(true))
          })
        })
        .catch(error => console.error("Error: ", error))
    }
  }

  autofill(event) {
    const addressId = event.currentTarget.dataset.addressId
    const address = this.addresses.find(element => element.properties.id == addressId)
    this.addressTarget.value = address.properties.name
    if (this.hasPostcodeTarget) this.postcodeTarget.value = address.properties.postcode
    if (this.hasCityTarget) this.cityTarget.value = address.properties.city
    this.listTarget.setAttribute("hidden", true)
  }

  showList() {
    this.listTarget.removeAttribute("hidden")
  }

  hideList(event) {
    if (event.target != this.addressTarget) {
      this.listTarget.setAttribute("hidden", true)
    }
  }
}
