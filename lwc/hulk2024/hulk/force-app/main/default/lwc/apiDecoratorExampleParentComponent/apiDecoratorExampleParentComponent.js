import { LightningElement } from 'lwc';

export default class ApiDecoratorExampleParentComponent extends LightningElement {
    setValue() {
        let inputValue = this.template.querySelector('lightning-input').value;
        // Alternative way to set child property value 
        this.template.querySelector('c-api-decorator-example-child-component').childProperty2 = inputValue;
    }

    emptyChildProperty() {
        // calling the child method
        this.template.querySelector('c-api-decorator-example-child-component').callChildMethod();
    }
}