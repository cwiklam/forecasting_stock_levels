import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['template']

    addAssociation(event) {
        event.preventDefault()
        const uniqueNumber = new Date().valueOf()
        const content = this.templateTarget.innerHTML.replace(/TEMPLATE_FIELD/g, uniqueNumber)
        console.log(content)
        this.templateTarget.insertAdjacentHTML('beforebegin', content)
    }

    removeAssociations(event) {
        const fieldContainer = event.target.parentElement.parentElement
        const destroyField = event.target.nextElementSibling.children[0]
        console.log(destroyField)
        fieldContainer.classList.add('hidden')
        destroyField.value = 'true'
    }
}
