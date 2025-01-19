import { LightningElement } from 'lwc';

export default class CustomEventsParentComponent extends LightningElement {
    setValue() {
        let inputValue = this.template.querySelector('lightning-input').value;
        this.template.querySelector('c-custom-events-child-component').childProperty2 = inputValue;
    }

    emptyChildProperty() {
        this.template.querySelector('c-custom-events-child-component').callChildMethod();
    }

    // custom event
    childMessage = 'No message received'
    storeMessage(event) {
        console.log(event.detail);
        this.childMessage = event.detail;
    }
}