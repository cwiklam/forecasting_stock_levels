import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['template']

    connect() {
        console.log('cconnet')
    }

    addAssociation(event) {
        event.preventDefault()
        const uniqueNumber = new Date().valueOf()
        const content = this.templateTarget.innerHTML.replace(/TEMPLATE_FIELD/g, uniqueNumber)
        this.templateTarget.insertAdjacentHTML('beforebegin', content)
    }

    removeAssociations(event) {
        const fieldContainer = document.getElementById(`po_${event.target.attributes.value.value}`)
        fieldContainer.remove()
    }
}
