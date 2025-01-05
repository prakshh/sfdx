import { LightningElement } from 'lwc';

export default class LifecycleHooksExample extends LightningElement {
    constructor() {
        super();
        console.log("Call from Constructor")
    }
    connectedCallback() {
        console.log("Call from connected callback");
    }
    renderedCallback() {
        console.log("Call from rendered callback");
    }
}