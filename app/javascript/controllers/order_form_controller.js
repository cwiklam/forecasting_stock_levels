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
        const fieldContainer = event.target.parentElement.parentElement
        const destroyField = event.target.nextElementSibling.children[0]
        fieldContainer.classList.add('hidden')
        destroyField.value = 'true'
    }
}
