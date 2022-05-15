import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['template']

    connect() {
        console.log('Hello from stimulus')
    }

    addAssociation(event) {
        console.log('Hello from stimulus')
        event.preventDefault()
        const uniqueNumber = new Date().valueOf()
        const content = this.templateTarget.innerHTML.replace(/TEMPLATE_FIELD/g, uniqueNumber)
        console.log(this.templateTarget)
        this.templateTarget.insertAdjacentHTML('beforebegin', content)
    }

    removeAssociations() {

    }
}
