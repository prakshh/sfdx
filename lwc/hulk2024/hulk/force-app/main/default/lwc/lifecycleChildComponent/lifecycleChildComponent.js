import { LightningElement } from 'lwc';

export default class LifecycleChildComponent extends LightningElement {
    constructor() {
        super();
        console.log("Call from Child constructor");
    }
    connectedCallback() {
        console.log("Call from Child connected callback");
    }
    renderedCallback() {
        console.log("Call from Child rendered callback");
    }
}