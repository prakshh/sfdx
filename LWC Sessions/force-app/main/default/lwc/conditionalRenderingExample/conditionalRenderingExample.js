import { LightningElement, track } from 'lwc';

export default class ConditionalRenderingExample extends LightningElement {
    @track displayDiv = false;

    @track cityList = ['Kolkata', 'Bengaluru', 'Mumbai', 'Delhi'];

    showDivHandler(event) {
        this.displayDiv = event.target.checked;
    }
}