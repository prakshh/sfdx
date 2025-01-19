import { LightningElement, api } from 'lwc';

export default class CustomEventsChildComponent extends LightningElement {
    @api childProperty1;
    @api childProperty2;

    @api callChildMethod() {
        console.log('Child method called')
        this.childProperty2 = '';
    }

    // custom events
    sendToParent() {
        console.log('Parent method called');
        const inputValue = this.template.querySelector('lightning-input').value;
        let evt = new CustomEvent('send', {detail: inputValue});
        this.dispatchEvent(evt);
    }
}