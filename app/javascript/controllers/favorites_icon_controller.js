import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favorites-icon"
export default class extends Controller {
  static targets = ["color", "icon"]

  connect() {

  }

  changeColor() {
    this.colorTarget.classList.toggle("listing-heart-red")

    const currentClass = this.iconTarget.classList.contains("fa-solid") ? "fa-solid" : "fa-regular"
    const newClass = currentClass === "fa-solid" ? "fa-regular" : "fa-solid"

    this.iconTarget.classList.remove(currentClass)
    this.iconTarget.classList.add(newClass)
  }

  changeToDefaultColor(event){
    event.preventDefault();
    this.colorTarget.classList.remove("listing-heart-red")

    const currentClass = this.iconTarget.classList.contains("fa-regular") ? "fa-regular" : "fa-solid"
    const newClass = currentClass === "fa-regular" ? "fa-solit" : "fa-regular"

    this.iconTarget.classList.remove(currentClass)
    this.iconTarget.classList.add(newClass)
    this.element.querySelector("form").submit();
  }

}
