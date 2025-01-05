import { LightningElement } from 'lwc';

export default class LifecycleHooksExample extends LightningElement {
    isVisible = true;

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

    /*

    html display:
        Parent Component
        Child Component

    console display:
        Call from Constructor
        Call from connected callback
        Call from Child constructor
        Call from Child connected callback
        Call from Child rendered callback
        Call from rendered callback
    */

    errorCallback() {
        console.log("Call from error callback");
    }

    /*

    html display:
        doesn't display anything in this case

    console diplay:
        Call from Constructor
        Call from connected callback
        Call from Child constructor
        Call from error callback
        Call from rendered callback
    */

    handleClick() {
        if(this.isVisible == true) {
            this.isVisible = false;
        } else {
            this.isVisible = true;
        }
    }

    /*

    errorCallback -> is present in parent component
    disconnectedCallback -> is present in child component

    by default, the toggle button shows the child component as isVisible has default value of true

    when toggle button is clicked, tehn child component gets hidden as isVisible becomes false

    then,

        console display:
            Call from Child disconnected callback
            Call from rendered callback
    */
}